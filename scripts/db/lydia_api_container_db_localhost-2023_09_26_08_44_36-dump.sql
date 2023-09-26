--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9 (Debian 14.9-1.pgdg120+1)
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

INSERT INTO public.flyway_schema_history VALUES (1, '1', 'init', 'SQL', '2022/V1__init.sql', 1782034767, 'test', '2023-09-26 08:40:31.156636', 34, true);
INSERT INTO public.flyway_schema_history VALUES (2, '2', 'create virksomhet adresse', 'SQL', '2022/V2__create_virksomhet_adresse.sql', -64248919, 'test', '2023-09-26 08:40:31.243189', 40, true);
INSERT INTO public.flyway_schema_history VALUES (3, '3', 'legg til navn pa virksomhet', 'SQL', '2022/V3__legg_til_navn_pa_virksomhet.sql', 60790216, 'test', '2023-09-26 08:40:31.327595', 15, true);
INSERT INTO public.flyway_schema_history VALUES (4, '4', 'endre prosent til sykefraversprosent', 'SQL', '2022/V4__endre_prosent_til_sykefraversprosent.sql', 125199402, 'test', '2023-09-26 08:40:31.382404', 18, true);
INSERT INTO public.flyway_schema_history VALUES (5, '5', 'endre type paa postnummer', 'SQL', '2022/V5__endre_type_paa_postnummer.sql', 1895026063, 'test', '2023-09-26 08:40:31.431885', 13, true);
INSERT INTO public.flyway_schema_history VALUES (6, '6', 'unique constraint sykefravarstatistikk', 'SQL', '2022/V6__unique_constraint_sykefravarstatistikk.sql', -1493468680, 'test', '2023-09-26 08:40:31.471781', 11, true);
INSERT INTO public.flyway_schema_history VALUES (7, '7', 'unique constraint virksomhet', 'SQL', '2022/V7__unique_constraint_virksomhet.sql', 2085819180, 'test', '2023-09-26 08:40:31.508571', 15, true);
INSERT INTO public.flyway_schema_history VALUES (8, '8', 'unique constraint virksomhet metadata', 'SQL', '2022/V8__unique_constraint_virksomhet_metadata.sql', 1632274980, 'test', '2023-09-26 08:40:31.548564', 11, true);
INSERT INTO public.flyway_schema_history VALUES (9, '9', 'legg til narings kode tabeller', 'SQL', '2022/V9__legg_til_narings_kode_tabeller.sql', 1866713049, 'test', '2023-09-26 08:40:31.58331', 18, true);
INSERT INTO public.flyway_schema_history VALUES (10, '10', 'legg til uoppgitt naeringskode', 'SQL', '2022/V10__legg_til_uoppgitt_naeringskode.sql', 715256750, 'test', '2023-09-26 08:40:31.627591', 11, true);
INSERT INTO public.flyway_schema_history VALUES (11, '11', 'fjern naringskode fra metadata tabell', 'SQL', '2022/V11__fjern_naringskode_fra_metadata_tabell.sql', -23097316, 'test', '2023-09-26 08:40:31.662942', 12, true);
INSERT INTO public.flyway_schema_history VALUES (12, '12', 'legg til adresse i virksomhet', 'SQL', '2022/V12__legg_til_adresse_i_virksomhet.sql', -1159443775, 'test', '2023-09-26 08:40:31.70516', 12, true);
INSERT INTO public.flyway_schema_history VALUES (13, '13', 'ia prosess', 'SQL', '2022/V13__ia_prosess.sql', -1755516749, 'test', '2023-09-26 08:40:31.752796', 21, true);
INSERT INTO public.flyway_schema_history VALUES (14, '14', 'endre ia prosess til ia sak', 'SQL', '2022/V14__endre_ia_prosess_til_ia_sak.sql', -751106797, 'test', '2023-09-26 08:40:31.809899', 21, true);
INSERT INTO public.flyway_schema_history VALUES (15, '15', 'endre saknummer', 'SQL', '2022/V15__endre_saknummer.sql', -1379621340, 'test', '2023-09-26 08:40:31.860879', 11, true);
INSERT INTO public.flyway_schema_history VALUES (16, '16', 'ia sak hendelse', 'SQL', '2022/V16__ia_sak_hendelse.sql', 586872662, 'test', '2023-09-26 08:40:31.90095', 25, true);
INSERT INTO public.flyway_schema_history VALUES (17, '17', 'legg til eidAv i ia sak', 'SQL', '2022/V17__legg_til_eidAv_i_ia_sak.sql', -1075526830, 'test', '2023-09-26 08:40:31.952882', 10, true);
INSERT INTO public.flyway_schema_history VALUES (18, '18', 'sykefravar statistikk grunnlag', 'SQL', '2022/V18__sykefravar_statistikk_grunnlag.sql', -925423348, 'test', '2023-09-26 08:40:31.985576', 14, true);
INSERT INTO public.flyway_schema_history VALUES (19, '19', 'legg til begrunnelser', 'SQL', '2022/V19__legg_til_begrunnelser.sql', 779259005, 'test', '2023-09-26 08:40:32.023059', 10, true);
INSERT INTO public.flyway_schema_history VALUES (20, '20', 'legg til flere indekser', 'SQL', '2022/V20__legg_til_flere_indekser.sql', -843857404, 'test', '2023-09-26 08:40:32.055897', 15, true);
INSERT INTO public.flyway_schema_history VALUES (21, '21', 'fjern enkelt begrunnelse', 'SQL', '2022/V21__fjern_enkelt_begrunnelse.sql', 1129743939, 'test', '2023-09-26 08:40:32.096169', 11, true);
INSERT INTO public.flyway_schema_history VALUES (22, '22', 'legg til endret felt på statistikk', 'SQL', '2022/V22__legg_til_endret_felt_på_statistikk.sql', -1542988905, 'test', '2023-09-26 08:40:32.135621', 11, true);
INSERT INTO public.flyway_schema_history VALUES (23, '23', 'legg til statistikk for sektor', 'SQL', '2022/V23__legg_til_statistikk_for_sektor.sql', -417896716, 'test', '2023-09-26 08:40:32.178117', 16, true);
INSERT INTO public.flyway_schema_history VALUES (24, '24', 'unique constraint endre sektor statistikk sektor', 'SQL', '2022/V24__unique_constraint_endre_sektor_statistikk_sektor.sql', 773753929, 'test', '2023-09-26 08:40:32.219297', 20, true);
INSERT INTO public.flyway_schema_history VALUES (25, '25', 'legg til statistikk for naring og land', 'SQL', '2022/V25__legg_til_statistikk_for_naring_og_land.sql', -336115428, 'test', '2023-09-26 08:40:32.267784', 40, true);
INSERT INTO public.flyway_schema_history VALUES (26, '26', 'fjern type fra ia sak', 'SQL', '2022/V26__fjern_type_fra_ia_sak.sql', 1889267882, 'test', '2023-09-26 08:40:32.333294', 11, true);
INSERT INTO public.flyway_schema_history VALUES (27, '27', 'drop idx orgnr virksomhet', 'SQL', '2022/V27__drop_idx_orgnr_virksomhet.sql', 1323783627, 'test', '2023-09-26 08:40:32.366748', 9, true);
INSERT INTO public.flyway_schema_history VALUES (28, '28', 'legg til uopgitt tosifret kode', 'SQL', '2022/V28__legg_til_uopgitt_tosifret_kode.sql', -912681527, 'test', '2023-09-26 08:40:32.399939', 11, true);
INSERT INTO public.flyway_schema_history VALUES (29, '29', 'index tapte dagsverk', 'SQL', '2022/V29__index_tapte_dagsverk.sql', 1914625834, 'test', '2023-09-26 08:40:32.438092', 10, true);
INSERT INTO public.flyway_schema_history VALUES (30, '30', 'virksomhet flere felter ifbm oppdatering', 'SQL', '2022/V30__virksomhet_flere_felter_ifbm_oppdatering.sql', -558279761, 'test', '2023-09-26 08:40:32.471195', 10, true);
INSERT INTO public.flyway_schema_history VALUES (31, '31', 'sistendrettidspunkt skal ikke vare null', 'SQL', '2022/V31__sistendrettidspunkt_skal_ikke_vare_null.sql', -1891530364, 'test', '2023-09-26 08:40:32.501307', 12, true);
INSERT INTO public.flyway_schema_history VALUES (32, '32', 'statistikk siste 4 kvartal', 'SQL', '2022/V32__statistikk_siste_4_kvartal.sql', -2136617812, 'test', '2023-09-26 08:40:32.533812', 13, true);
INSERT INTO public.flyway_schema_history VALUES (33, '33', 'endre navn fra opprettet til sist endret', 'SQL', '2022/V33__endre_navn_fra_opprettet_til_sist_endret.sql', 1854948614, 'test', '2023-09-26 08:40:32.574201', 10, true);
INSERT INTO public.flyway_schema_history VALUES (34, '34', 'statistikk land siste 4 kvartal', 'SQL', '2022/V34__statistikk_land_siste_4_kvartal.sql', 542360408, 'test', '2023-09-26 08:40:32.608534', 18, true);
INSERT INTO public.flyway_schema_history VALUES (35, '35', 'drop sykefravar statistikk grunnlag', 'SQL', '2022/V35__drop_sykefravar_statistikk_grunnlag.sql', 461103825, 'test', '2023-09-26 08:40:32.651531', 11, true);
INSERT INTO public.flyway_schema_history VALUES (36, '36', 'registrere bistand', 'SQL', '2023/V36__registrere_bistand.sql', -1365283904, 'test', '2023-09-26 08:40:32.687326', 22, true);
INSERT INTO public.flyway_schema_history VALUES (37, '37', 'fullfoert dato leveranse', 'SQL', '2023/V37__fullfoert_dato_leveranse.sql', 1621470787, 'test', '2023-09-26 08:40:32.731624', 10, true);
INSERT INTO public.flyway_schema_history VALUES (38, '38', 'oppdatere moduler', 'SQL', '2023/V38__oppdatere_moduler.sql', -246234034, 'test', '2023-09-26 08:40:32.76607', 20, true);
INSERT INTO public.flyway_schema_history VALUES (39, '39', 'rette iatjeneste på modul', 'SQL', '2023/V39__rette_iatjeneste_på_modul.sql', -1034067650, 'test', '2023-09-26 08:40:32.811799', 8, true);
INSERT INTO public.flyway_schema_history VALUES (40, '40', 'legg til rolle ia sak hendelse', 'SQL', '2023/V40__legg_til_rolle_ia_sak_hendelse.sql', -82283870, 'test', '2023-09-26 08:40:32.842353', 10, true);
INSERT INTO public.flyway_schema_history VALUES (41, '41', 'legg til rolle ia sak leveranse', 'SQL', '2023/V41__legg_til_rolle_ia_sak_leveranse.sql', -2029318456, 'test', '2023-09-26 08:40:32.875541', 9, true);
INSERT INTO public.flyway_schema_history VALUES (42, '42', 'legg til deaktivert', 'SQL', '2023/V42__legg_til_deaktivert.sql', 1170357332, 'test', '2023-09-26 08:40:32.911917', 13, true);
INSERT INTO public.flyway_schema_history VALUES (43, '43', 'siste publiseringsinfo tabell', 'SQL', '2023/V43__siste_publiseringsinfo_tabell.sql', -1555520829, 'test', '2023-09-26 08:40:32.946849', 13, true);
INSERT INTO public.flyway_schema_history VALUES (44, '44', 'hendelse nav enhet', 'SQL', '2023/V44__hendelse_nav_enhet.sql', -1118774222, 'test', '2023-09-26 08:40:32.98287', 10, true);
INSERT INTO public.flyway_schema_history VALUES (45, '45', 'oppdatere siste publiseringsinfo', 'SQL', '2023/V45__oppdatere_siste_publiseringsinfo.sql', -1919960111, 'test', '2023-09-26 08:40:33.015558', 9, true);
INSERT INTO public.flyway_schema_history VALUES (46, '46', 'populer siste publiseringsdato', 'SQL', '2023/V46__populer_siste_publiseringsdato.sql', 21300723, 'test', '2023-09-26 08:40:33.044477', 15, true);
INSERT INTO public.flyway_schema_history VALUES (47, '47', 'virksomhet naringsundergrupper tabell', 'SQL', '2023/V47__virksomhet_naringsundergrupper_tabell.sql', 581614507, 'test', '2023-09-26 08:40:33.080289', 11, true);
INSERT INTO public.flyway_schema_history VALUES (48, '48', 'endre oppdateringsdato', 'SQL', '2023/V48__endre_oppdateringsdato.sql', 855334580, 'test', '2023-09-26 08:40:33.111528', 13, true);
INSERT INTO public.flyway_schema_history VALUES (49, '49', 'sykefravar statistikk bransje tabell', 'SQL', '2023/V49__sykefravar_statistikk_bransje_tabell.sql', 1439525146, 'test', '2023-09-26 08:40:33.14721', 13, true);
INSERT INTO public.flyway_schema_history VALUES (50, '50', 'endre kode lengde siste 4 kvartal', 'SQL', '2023/V50__endre_kode_lengde_siste_4_kvartal.sql', 218855534, 'test', '2023-09-26 08:40:33.182362', 11, true);
INSERT INTO public.flyway_schema_history VALUES (51, '51', 'endre navn fra naeringskode til naringsundergruppe', 'SQL', '2023/V51__endre_navn_fra_naeringskode_til_naringsundergruppe.sql', 498551672, 'test', '2023-09-26 08:40:33.217094', 14, true);
INSERT INTO public.flyway_schema_history VALUES (52, '52', 'slett virksomhet naring tabell', 'SQL', '2023/V52__slett_virksomhet_naring_tabell.sql', 1210783708, 'test', '2023-09-26 08:40:33.255478', 14, true);
INSERT INTO public.flyway_schema_history VALUES (53, '53', 'oppdatere siste publiseringsinfo Q2 2023', 'SQL', '2023/V53__oppdatere_siste_publiseringsinfo_Q2_2023.sql', -100876903, 'test', '2023-09-26 08:40:33.300081', 9, true);
INSERT INTO public.flyway_schema_history VALUES (54, '54', 'naringsundergrupper per bransje tabell', 'SQL', '2023/V54__naringsundergrupper_per_bransje_tabell.sql', -885609844, 'test', '2023-09-26 08:40:33.332566', 110, true);
INSERT INTO public.flyway_schema_history VALUES (55, '55', 'legg til opprettet tidspunkt iasak leveranse', 'SQL', '2023/V55__legg_til_opprettet_tidspunkt_iasak_leveranse.sql', -1334142016, 'test', '2023-09-26 08:40:33.466166', 8, true);
INSERT INTO public.flyway_schema_history VALUES (56, '56', 'legg til endret statistikk tabeller', 'SQL', '2023/V56__legg_til_endret_statistikk_tabeller.sql', 1995700472, 'test', '2023-09-26 08:40:33.497555', 18, true);
INSERT INTO public.flyway_schema_history VALUES (57, '57', 'legg til publiseringskvartal', 'SQL', '2023/V57__legg_til_publiseringskvartal.sql', -1125206576, 'test', '2023-09-26 08:40:33.538294', 21, true);
INSERT INTO public.flyway_schema_history VALUES (58, '58', 'legg til materialized statistikk view', 'SQL', '2023/V58__legg_til_materialized_statistikk_view.sql', -31127815, 'test', '2023-09-26 08:40:33.582019', 19, true);
INSERT INTO public.flyway_schema_history VALUES (59, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', 174605915, 'test', '2023-09-26 08:40:33.624326', 11, true);
INSERT INTO public.flyway_schema_history VALUES (60, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', -37964000, 'test', '2023-09-26 08:41:00.9182', 45, true);


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

INSERT INTO public.naringsundergrupper_per_bransje VALUES ('88.911', 'BARNEHAGER', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.110', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.120', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.130', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.201', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.202', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.203', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.209', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.310', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.320', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.390', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.411', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.412', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.413', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.420', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.510', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.520', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.610', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.620', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.710', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.720', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.730', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.810', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.820', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.830', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.840', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.850', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.860', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.890', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.910', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.920', 'NÆRINGSMIDDELINDUSTRI', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('86.101', 'SYKEHUS', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('86.102', 'SYKEHUS', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('86.104', 'SYKEHUS', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('86.105', 'SYKEHUS', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('86.106', 'SYKEHUS', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('86.107', 'SYKEHUS', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('87.101', 'SYKEHJEM', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('87.102', 'SYKEHJEM', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('49.100', 'TRANSPORT', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('49.311', 'TRANSPORT', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('49.391', 'TRANSPORT', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('49.392', 'TRANSPORT', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('41.101', 'BYGG', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('41.109', 'BYGG', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('41.200', 'BYGG', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.110', 'ANLEGG', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.120', 'ANLEGG', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.130', 'ANLEGG', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.210', 'ANLEGG', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.220', 'ANLEGG', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.910', 'ANLEGG', '2023-09-26 08:40:33.34289');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.990', 'ANLEGG', '2023-09-26 08:40:33.34289');


--
-- Data for Name: sektor; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: siste_publiseringsinfo; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.siste_publiseringsinfo VALUES (1, 2022, 4, '2023-03-02 00:00:00', '2023-06-01 00:00:00', '2023-09-26 08:40:32.955474');
INSERT INTO public.siste_publiseringsinfo VALUES (2, 2023, 1, '2023-06-01 00:00:00', '2023-09-07 00:00:00', '2023-09-26 08:40:33.023457');
INSERT INTO public.siste_publiseringsinfo VALUES (3, 2022, 3, '2022-12-01 00:00:00', '2023-03-02 00:00:00', '2023-09-26 08:40:33.053016');
INSERT INTO public.siste_publiseringsinfo VALUES (4, 2022, 2, '2022-09-08 00:00:00', '2022-12-01 00:00:00', '2023-09-26 08:40:33.053016');
INSERT INTO public.siste_publiseringsinfo VALUES (5, 2022, 1, '2022-06-02 00:00:00', '2022-09-08 00:00:00', '2023-09-26 08:40:33.053016');
INSERT INTO public.siste_publiseringsinfo VALUES (6, 2021, 4, '2022-03-03 00:00:00', '2022-06-02 00:00:00', '2023-09-26 08:40:33.053016');
INSERT INTO public.siste_publiseringsinfo VALUES (7, 2021, 3, '2021-12-02 00:00:00', '2022-03-03 00:00:00', '2023-09-26 08:40:33.053016');
INSERT INTO public.siste_publiseringsinfo VALUES (8, 2023, 2, '2023-09-07 00:00:00', '2023-11-30 00:00:00', '2023-09-26 08:40:33.309895');


--
-- Data for Name: sykefravar_statistikk_bransje; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_bransje VALUES (1, 2023, 2, 'BARNEHAGER', 1000, 25000, 250000, 10, false, '2023-09-26 08:41:09.70081', NULL);
INSERT INTO public.sykefravar_statistikk_bransje VALUES (2, 2023, 2, 'NÆRINGSMIDDELINDUSTRI', 1000, 25000, 250000, 10, false, '2023-09-26 08:41:09.75807', NULL);
INSERT INTO public.sykefravar_statistikk_bransje VALUES (3, 2023, 2, 'SYKEHUS', 1000, 25000, 250000, 10, false, '2023-09-26 08:41:09.796558', NULL);
INSERT INTO public.sykefravar_statistikk_bransje VALUES (4, 2023, 2, 'SYKEHJEM', 1000, 25000, 250000, 10, false, '2023-09-26 08:41:09.796558', NULL);
INSERT INTO public.sykefravar_statistikk_bransje VALUES (5, 2023, 2, 'TRANSPORT', 1000, 25000, 250000, 10, false, '2023-09-26 08:41:09.796558', NULL);
INSERT INTO public.sykefravar_statistikk_bransje VALUES (6, 2023, 2, 'BYGG', 1000, 25000, 250000, 10, false, '2023-09-26 08:41:09.796558', NULL);
INSERT INTO public.sykefravar_statistikk_bransje VALUES (7, 2023, 2, 'ANLEGG', 1000, 25000, 250000, 10, false, '2023-09-26 08:41:09.796558', NULL);


--
-- Data for Name: sykefravar_statistikk_kategori_siste_4_kvartal; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (1, 'NÆRING', '00', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:08.748726', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (2, 'NÆRING', '01', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:08.914554', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (3, 'NÆRING', '02', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (4, 'NÆRING', '03', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (5, 'NÆRING', '05', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (6, 'NÆRING', '06', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (7, 'NÆRING', '07', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (8, 'NÆRING', '08', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (9, 'NÆRING', '09', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (10, 'NÆRING', '10', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (11, 'NÆRING', '11', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (12, 'NÆRING', '12', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (13, 'NÆRING', '13', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (14, 'NÆRING', '14', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (15, 'NÆRING', '15', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (16, 'NÆRING', '16', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (17, 'NÆRING', '17', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (18, 'NÆRING', '18', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (19, 'NÆRING', '19', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (20, 'NÆRING', '20', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (21, 'NÆRING', '21', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (22, 'NÆRING', '22', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (23, 'NÆRING', '23', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (24, 'NÆRING', '24', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (25, 'NÆRING', '25', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (26, 'NÆRING', '26', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (27, 'NÆRING', '27', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (28, 'NÆRING', '28', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (29, 'NÆRING', '29', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (30, 'NÆRING', '30', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.009511', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (31, 'NÆRING', '31', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.192985', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (32, 'NÆRING', '32', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (33, 'NÆRING', '33', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (34, 'NÆRING', '35', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (35, 'NÆRING', '36', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (36, 'NÆRING', '37', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (37, 'NÆRING', '38', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (38, 'NÆRING', '39', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (39, 'NÆRING', '41', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (40, 'NÆRING', '42', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (41, 'NÆRING', '43', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (42, 'NÆRING', '45', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (43, 'NÆRING', '46', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (44, 'NÆRING', '47', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (45, 'NÆRING', '49', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (46, 'NÆRING', '50', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (47, 'NÆRING', '51', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (48, 'NÆRING', '52', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (49, 'NÆRING', '53', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (50, 'NÆRING', '55', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (51, 'NÆRING', '56', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (52, 'NÆRING', '58', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (53, 'NÆRING', '59', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (54, 'NÆRING', '60', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (55, 'NÆRING', '61', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (56, 'NÆRING', '62', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (57, 'NÆRING', '63', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (58, 'NÆRING', '64', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (59, 'NÆRING', '65', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (60, 'NÆRING', '66', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.257464', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (61, 'NÆRING', '68', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.384088', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (62, 'NÆRING', '69', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.384088', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (63, 'NÆRING', '70', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.384088', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (64, 'NÆRING', '71', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.455282', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (65, 'NÆRING', '72', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.455282', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (66, 'NÆRING', '73', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.455282', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (67, 'NÆRING', '74', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.455282', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (68, 'NÆRING', '75', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.455282', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (69, 'NÆRING', '77', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.455282', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (70, 'NÆRING', '78', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.455282', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (71, 'NÆRING', '79', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.455282', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (72, 'NÆRING', '80', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.455282', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (73, 'NÆRING', '81', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.455282', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (74, 'NÆRING', '82', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.455282', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (75, 'NÆRING', '84', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.455282', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (76, 'NÆRING', '85', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.455282', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (77, 'NÆRING', '86', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.455282', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (78, 'NÆRING', '87', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.455282', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (79, 'NÆRING', '88', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.455282', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (80, 'NÆRING', '90', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.455282', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (81, 'NÆRING', '91', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.455282', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (82, 'NÆRING', '92', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.455282', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (83, 'NÆRING', '93', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.563239', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (84, 'NÆRING', '94', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.563239', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (85, 'NÆRING', '95', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.563239', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (86, 'NÆRING', '96', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.604942', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (87, 'NÆRING', '97', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.604942', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (88, 'NÆRING', '99', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.604942', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (89, 'BRANSJE', 'BARNEHAGER', 100000, 1000000, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.684289', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (90, 'BRANSJE', 'NÆRINGSMIDDELINDUSTRI', 100000, 1000000, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.734273', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (91, 'BRANSJE', 'SYKEHUS', 100000, 1000000, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.786479', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (92, 'BRANSJE', 'SYKEHJEM', 100000, 1000000, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.786479', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (93, 'BRANSJE', 'TRANSPORT', 100000, 1000000, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.786479', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (94, 'BRANSJE', 'BYGG', 100000, 1000000, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.786479', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (95, 'BRANSJE', 'ANLEGG', 100000, 1000000, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:09.786479', 2, 2023);


--
-- Data for Name: sykefravar_statistikk_land; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: sykefravar_statistikk_naring; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_naring VALUES (1, 2023, 2, '00', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:08.789868', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (2, 2023, 2, '01', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:08.927023', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (3, 2023, 2, '02', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (4, 2023, 2, '03', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (5, 2023, 2, '05', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (6, 2023, 2, '06', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (7, 2023, 2, '07', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (8, 2023, 2, '08', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (9, 2023, 2, '09', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (10, 2023, 2, '10', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (11, 2023, 2, '11', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (12, 2023, 2, '12', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (13, 2023, 2, '13', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (14, 2023, 2, '14', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (15, 2023, 2, '15', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (16, 2023, 2, '16', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (17, 2023, 2, '17', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (18, 2023, 2, '18', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (19, 2023, 2, '19', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (20, 2023, 2, '20', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (21, 2023, 2, '21', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (22, 2023, 2, '22', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (23, 2023, 2, '23', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (24, 2023, 2, '24', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (25, 2023, 2, '25', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (26, 2023, 2, '26', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (27, 2023, 2, '27', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (28, 2023, 2, '28', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (29, 2023, 2, '29', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (30, 2023, 2, '30', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.089943', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (31, 2023, 2, '31', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.203262', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (32, 2023, 2, '32', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (33, 2023, 2, '33', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (34, 2023, 2, '35', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (35, 2023, 2, '36', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (36, 2023, 2, '37', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (37, 2023, 2, '38', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (38, 2023, 2, '39', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (39, 2023, 2, '41', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (40, 2023, 2, '42', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (41, 2023, 2, '43', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (42, 2023, 2, '45', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (43, 2023, 2, '46', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (44, 2023, 2, '47', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (45, 2023, 2, '49', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (46, 2023, 2, '50', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (47, 2023, 2, '51', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (48, 2023, 2, '52', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (49, 2023, 2, '53', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (50, 2023, 2, '55', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (51, 2023, 2, '56', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (52, 2023, 2, '58', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (53, 2023, 2, '59', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (54, 2023, 2, '60', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (55, 2023, 2, '61', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (56, 2023, 2, '62', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (57, 2023, 2, '63', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (58, 2023, 2, '64', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (59, 2023, 2, '65', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (60, 2023, 2, '66', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.297384', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (61, 2023, 2, '68', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.400607', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (62, 2023, 2, '69', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.400607', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (63, 2023, 2, '70', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.400607', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (64, 2023, 2, '71', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.50226', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (65, 2023, 2, '72', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.50226', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (66, 2023, 2, '73', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.50226', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (67, 2023, 2, '74', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.50226', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (68, 2023, 2, '75', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.50226', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (69, 2023, 2, '77', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.50226', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (70, 2023, 2, '78', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.50226', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (71, 2023, 2, '79', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.50226', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (72, 2023, 2, '80', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.50226', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (73, 2023, 2, '81', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.50226', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (74, 2023, 2, '82', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.50226', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (75, 2023, 2, '84', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.50226', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (76, 2023, 2, '85', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.50226', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (77, 2023, 2, '86', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.50226', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (78, 2023, 2, '87', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.50226', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (79, 2023, 2, '88', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.50226', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (80, 2023, 2, '90', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.50226', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (81, 2023, 2, '91', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.50226', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (82, 2023, 2, '92', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.50226', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (83, 2023, 2, '93', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.572198', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (84, 2023, 2, '94', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.572198', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (85, 2023, 2, '95', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.572198', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (86, 2023, 2, '96', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.620381', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (87, 2023, 2, '97', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.620381', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (88, 2023, 2, '99', 1000, 12500, 250000, 5, false, '2023-09-26 08:41:09.620381', NULL);


--
-- Data for Name: sykefravar_statistikk_naringsundergruppe; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: sykefravar_statistikk_sektor; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: sykefravar_statistikk_virksomhet; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (1, '987654321', 2023, 2, 6, 5658.1013503011, 125, 9, false, '2023-09-26 08:41:13.284423', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (2, '987654321', 2023, 1, 6, 5658.1013503011, 125, 2, false, '2023-09-26 08:41:13.307695', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (3, '123456789', 2023, 2, 930, 373.451871398176, 125, 7, false, '2023-09-26 08:41:13.351885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (4, '123456789', 2023, 1, 930, 373.451871398176, 125, 7, false, '2023-09-26 08:41:13.351885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (5, '123456789', 2022, 4, 930, 373.451871398176, 125, 7, false, '2023-09-26 08:41:13.351885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (6, '123456789', 2022, 3, 930, 373.451871398176, 125, 7, false, '2023-09-26 08:41:13.351885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (7, '123456789', 2022, 2, 930, 373.451871398176, 125, 7, false, '2023-09-26 08:41:13.351885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (8, '123456789', 2022, 1, 930, 373.451871398176, 125, 7, false, '2023-09-26 08:41:13.351885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (9, '123456789', 2021, 4, 930, 373.451871398176, 125, 7, false, '2023-09-26 08:41:13.351885', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (10, '123456789', 2021, 3, 930, 373.451871398176, 125, 7, false, '2023-09-26 08:41:13.395016', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (11, '123456789', 2021, 2, 930, 373.451871398176, 125, 7, false, '2023-09-26 08:41:13.395016', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (12, '123456789', 2021, 1, 930, 373.451871398176, 125, 7, false, '2023-09-26 08:41:13.395016', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (13, '123456789', 2020, 4, 930, 373.451871398176, 125, 7, false, '2023-09-26 08:41:13.395016', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (14, '123456789', 2020, 3, 930, 373.451871398176, 125, 7, false, '2023-09-26 08:41:13.395016', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (15, '123456789', 2020, 2, 930, 373.451871398176, 125, 7, false, '2023-09-26 08:41:13.395016', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (16, '123456789', 2020, 1, 930, 373.451871398176, 125, 7, false, '2023-09-26 08:41:13.431915', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (17, '123456789', 2019, 4, 930, 373.451871398176, 125, 7, false, '2023-09-26 08:41:13.431915', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (18, '123456789', 2019, 3, 930, 373.451871398176, 125, 7, false, '2023-09-26 08:41:13.431915', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (19, '123456789', 2019, 2, 930, 373.451871398176, 125, 7, false, '2023-09-26 08:41:13.431915', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (20, '123456789', 2019, 1, 930, 373.451871398176, 125, 7, false, '2023-09-26 08:41:13.431915', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (21, '123456789', 2018, 4, 930, 373.451871398176, 125, 7, false, '2023-09-26 08:41:13.431915', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (22, '123456789', 2018, 3, 930, 373.451871398176, 125, 7, false, '2023-09-26 08:41:13.431915', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (23, '555555555', 2023, 2, 710, 266.771052788751, 125, 8, false, '2023-09-26 08:41:13.468045', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (24, '857241581', 2023, 2, 836, 784.756785497559, 125, 6, false, '2023-09-26 08:41:13.468045', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (25, '857241581', 2023, 1, 836, 784.756785497559, 125, 6, false, '2023-09-26 08:41:13.468045', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (26, '867365117', 2023, 2, 42, 8714.01678691939, 125, 6, false, '2023-09-26 08:41:13.468045', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (27, '867365117', 2023, 1, 42, 8714.01678691939, 125, 6, false, '2023-09-26 08:41:13.468045', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (28, '881114246', 2023, 2, 42, 972.736190476571, 125, 6, false, '2023-09-26 08:41:13.521051', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (29, '881114246', 2023, 1, 42, 972.736190476571, 125, 6, false, '2023-09-26 08:41:13.521051', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (30, '891771817', 2023, 2, 870, 4878.74197537698, 125, 20, false, '2023-09-26 08:41:13.521051', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (31, '891771817', 2023, 1, 870, 4878.74197537698, 125, 15, false, '2023-09-26 08:41:13.521051', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (32, '898525058', 2023, 2, 418, 6296.79946573413, 125, 10, false, '2023-09-26 08:41:13.521051', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (33, '835220383', 2023, 2, 962, 5423.95434874536, 125, 14, false, '2023-09-26 08:41:13.521051', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (34, '878746520', 2023, 2, 108, 5745.38672776253, 125, 14, false, '2023-09-26 08:41:13.564122', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (35, '883329944', 2023, 2, 458, 7852.96646157489, 125, 14, false, '2023-09-26 08:41:13.564122', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (36, '852437928', 2023, 2, 628, 2042.66644650691, 125, 6, false, '2023-09-26 08:41:13.564122', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (37, '895309223', 2023, 2, 592, 4472.57941188928, 125, 1, false, '2023-09-26 08:41:13.564122', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (38, '835031049', 2023, 2, 638, 1100.61593098538, 125, 18, false, '2023-09-26 08:41:13.564122', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (39, '873220998', 2023, 2, 550, 8482.84679591355, 125, 15, false, '2023-09-26 08:41:13.564122', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (40, '835774114', 2023, 2, 257, 8647.49976839259, 125, 8, false, '2023-09-26 08:41:13.564122', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (41, '862164924', 2023, 2, 607, 5566.5604132299, 125, 4, false, '2023-09-26 08:41:13.610072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (42, '896270090', 2023, 2, 311, 1686.22198106379, 125, 1, false, '2023-09-26 08:41:13.610072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (43, '897255882', 2023, 2, 258, 6327.08358305041, 125, 19, false, '2023-09-26 08:41:13.610072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (44, '848363736', 2023, 2, 544, 2372.26314441645, 125, 9, false, '2023-09-26 08:41:13.610072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (45, '882275284', 2023, 2, 703, 6164.41472107867, 125, 15, false, '2023-09-26 08:41:13.610072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (46, '834436066', 2023, 2, 913, 2585.3756426332, 125, 19, false, '2023-09-26 08:41:13.610072', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (47, '829040586', 2023, 2, 865, 3798.14602238384, 125, 17, false, '2023-09-26 08:41:13.655308', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (48, '816209538', 2023, 2, 57, 1142.90341470982, 125, 4, false, '2023-09-26 08:41:13.655308', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (49, '831787072', 2023, 2, 284, 9928.66555874114, 125, 8, false, '2023-09-26 08:41:13.655308', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (50, '877257237', 2023, 2, 760, 8367.40439420637, 125, 19, false, '2023-09-26 08:41:13.655308', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (51, '889355886', 2023, 2, 300, 915.340693908108, 125, 16, false, '2023-09-26 08:41:13.655308', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (52, '895626556', 2023, 2, 970, 5724.5877704625, 125, 19, false, '2023-09-26 08:41:13.655308', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (53, '821709008', 2023, 2, 433, 9829.92547930021, 125, 4, false, '2023-09-26 08:41:13.655308', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (54, '804237955', 2023, 2, 724, 9921.64036737005, 125, 15, false, '2023-09-26 08:41:13.655308', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (55, '872367868', 2023, 2, 894, 3406.51784693726, 125, 11, false, '2023-09-26 08:41:13.701627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (56, '803742463', 2023, 2, 422, 8927.73456712444, 125, 11, false, '2023-09-26 08:41:13.701627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (57, '892845353', 2023, 2, 645, 1575.9214326816, 125, 17, false, '2023-09-26 08:41:13.701627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (58, '861622901', 2023, 2, 404, 6191.66549356885, 125, 13, false, '2023-09-26 08:41:13.701627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (59, '881875590', 2023, 2, 987, 63.9654937784535, 125, 19, false, '2023-09-26 08:41:13.701627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (60, '801835452', 2023, 2, 953, 8826.33828604419, 125, 10, false, '2023-09-26 08:41:13.701627', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (61, '875258326', 2023, 2, 95, 2428.66839610058, 125, 6, false, '2023-09-26 08:41:13.751383', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (62, '845784470', 2023, 2, 451, 1304.52639609195, 125, 9, false, '2023-09-26 08:41:13.751383', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (63, '859440331', 2023, 2, 545, 5034.54581021047, 125, 6, false, '2023-09-26 08:41:13.751383', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (64, '819479903', 2023, 2, 505, 5273.06672884237, 125, 20, false, '2023-09-26 08:41:13.751383', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (65, '890551762', 2023, 2, 589, 8090.20721981409, 125, 1, false, '2023-09-26 08:41:13.751383', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (66, '861778194', 2023, 2, 412, 7223.31510623021, 125, 15, false, '2023-09-26 08:41:13.751383', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (67, '805339854', 2023, 2, 636, 7620.23906931489, 125, 7, false, '2023-09-26 08:41:13.751383', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (68, '815390484', 2023, 2, 108, 6580.27079195834, 125, 16, false, '2023-09-26 08:41:13.788688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (69, '850462341', 2023, 2, 729, 661.249558604791, 125, 4, false, '2023-09-26 08:41:13.788688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (70, '874452140', 2023, 2, 430, 6724.6163609069, 125, 12, false, '2023-09-26 08:41:13.788688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (71, '811851790', 2023, 2, 340, 3401.21121053358, 125, 10, false, '2023-09-26 08:41:13.788688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (72, '873515591', 2023, 2, 532, 6118.16527582853, 125, 5, false, '2023-09-26 08:41:13.788688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (73, '836279558', 2023, 2, 212, 2559.54394426273, 125, 4, false, '2023-09-26 08:41:13.788688', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (74, '809727399', 2023, 2, 66, 5464.18837127452, 125, 15, false, '2023-09-26 08:41:13.822006', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (75, '824470634', 2023, 2, 652, 852.772096965992, 125, 6, false, '2023-09-26 08:41:13.822006', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (76, '836516461', 2023, 2, 580, 5658.42382960955, 125, 12, false, '2023-09-26 08:41:13.822006', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (77, '837159750', 2023, 2, 554, 9342.39893417777, 125, 6, false, '2023-09-26 08:41:13.822006', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (78, '811866664', 2023, 2, 182, 6762.99080579832, 125, 7, false, '2023-09-26 08:41:13.822006', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (79, '851277727', 2023, 2, 103, 2700.94982022498, 125, 12, false, '2023-09-26 08:41:13.822006', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (80, '842226671', 2023, 2, 377, 5957.58468718186, 125, 8, false, '2023-09-26 08:41:13.86412', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (81, '821968574', 2023, 2, 491, 9297.27217032859, 125, 19, false, '2023-09-26 08:41:13.86412', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (82, '824580761', 2023, 2, 666, 7167.33693386958, 125, 18, false, '2023-09-26 08:41:13.86412', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (83, '889367910', 2023, 2, 634, 3423.19170274956, 125, 13, false, '2023-09-26 08:41:13.86412', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (84, '840237611', 2023, 2, 26, 2369.34526629695, 125, 13, false, '2023-09-26 08:41:13.86412', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (85, '800908366', 2023, 2, 852, 7279.67854932012, 125, 13, false, '2023-09-26 08:41:13.896481', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (86, '822930437', 2023, 2, 557, 9288.48710270717, 125, 5, false, '2023-09-26 08:41:13.896481', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (87, '814250450', 2023, 2, 290, 1659.90861668646, 125, 17, false, '2023-09-26 08:41:13.896481', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (88, '808744432', 2023, 2, 86, 867.914458253095, 125, 13, false, '2023-09-26 08:41:13.896481', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (89, '857826950', 2023, 2, 433, 7779.69347892379, 125, 3, false, '2023-09-26 08:41:13.896481', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (90, '870623580', 2023, 2, 893, 6184.63317850917, 125, 16, false, '2023-09-26 08:41:13.896481', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (91, '810733872', 2023, 2, 595, 1307.31197551474, 125, 14, false, '2023-09-26 08:41:13.896481', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (92, '827935929', 2023, 2, 94, 8119.55495062999, 125, 13, false, '2023-09-26 08:41:13.931068', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (93, '863730729', 2023, 2, 850, 1817.95929411193, 125, 7, false, '2023-09-26 08:41:13.931068', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (94, '857184109', 2023, 2, 634, 187.655680035141, 125, 18, false, '2023-09-26 08:41:13.931068', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (95, '852734859', 2023, 2, 83, 9436.83301524494, 125, 18, false, '2023-09-26 08:41:13.931068', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (96, '853594439', 2023, 2, 902, 4465.41237913686, 125, 19, false, '2023-09-26 08:41:13.931068', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (97, '818803358', 2023, 2, 749, 1720.67438457381, 125, 1, false, '2023-09-26 08:41:13.931068', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (98, '853653063', 2023, 2, 844, 7390.56795276106, 125, 2, false, '2023-09-26 08:41:13.931068', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (99, '841238334', 2023, 2, 9, 3367.79920446937, 125, 3, false, '2023-09-26 08:41:13.968309', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (100, '813169303', 2023, 2, 495, 4563.20156661633, 125, 4, false, '2023-09-26 08:41:13.968309', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (101, '839551215', 2023, 2, 942, 5902.48400190722, 125, 20, false, '2023-09-26 08:41:13.968309', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (102, '880193321', 2023, 2, 820, 5282.28197768097, 125, 20, false, '2023-09-26 08:41:13.968309', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (103, '833735069', 2023, 2, 180, 5000.48436311179, 125, 16, false, '2023-09-26 08:41:13.968309', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (104, '859513692', 2023, 2, 203, 9547.7195196381, 125, 16, false, '2023-09-26 08:41:13.968309', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (105, '842466076', 2023, 2, 514, 8878.18325710209, 125, 17, false, '2023-09-26 08:41:13.968309', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (106, '894329113', 2023, 2, 679, 359.266010886281, 125, 9, false, '2023-09-26 08:41:14.010563', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (107, '878105030', 2023, 2, 298, 1861.34812750136, 125, 6, false, '2023-09-26 08:41:14.010563', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (108, '801615123', 2023, 2, 841, 5160.07943453853, 125, 8, false, '2023-09-26 08:41:14.010563', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (109, '899812147', 2023, 2, 182, 6767.34841287834, 125, 4, false, '2023-09-26 08:41:14.070715', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (110, '867355472', 2023, 2, 988, 2100.67353684968, 125, 19, false, '2023-09-26 08:41:14.070715', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (111, '862566596', 2023, 2, 910, 3502.43294224342, 125, 6, false, '2023-09-26 08:41:14.070715', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (112, '848711875', 2023, 2, 346, 4127.07149344162, 125, 2, false, '2023-09-26 08:41:14.070715', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (113, '899871018', 2023, 2, 666, 7156.19075735883, 125, 14, false, '2023-09-26 08:41:14.070715', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (114, '834231007', 2023, 2, 267, 2674.41981631651, 125, 6, false, '2023-09-26 08:41:14.070715', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (115, '844851816', 2023, 2, 770, 4140.13053681652, 125, 5, false, '2023-09-26 08:41:14.070715', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (116, '883686536', 2023, 2, 146, 8549.32044808769, 125, 2, false, '2023-09-26 08:41:14.104686', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (117, '846917560', 2023, 2, 959, 7148.1630157421, 125, 16, false, '2023-09-26 08:41:14.104686', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (118, '819849863', 2023, 2, 299, 2499.64167976972, 125, 14, false, '2023-09-26 08:41:14.104686', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (119, '802805958', 2023, 2, 853, 5651.05523959303, 125, 6, false, '2023-09-26 08:41:14.104686', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (120, '893385116', 2023, 2, 667, 6313.69958615558, 125, 16, false, '2023-09-26 08:41:14.150097', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (121, '821342624', 2023, 2, 546, 8582.8293938414, 125, 3, false, '2023-09-26 08:41:14.150097', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (122, '807688973', 2023, 2, 884, 4308.35160123796, 125, 19, false, '2023-09-26 08:41:14.150097', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (123, '807482958', 2023, 2, 258, 3317.38710834283, 125, 2, false, '2023-09-26 08:41:14.150097', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (124, '840247819', 2023, 2, 681, 5611.31063696849, 125, 3, false, '2023-09-26 08:41:14.150097', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (125, '833662191', 2023, 2, 785, 318.185358582801, 125, 18, false, '2023-09-26 08:41:14.150097', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (126, '857600929', 2023, 2, 781, 7417.97247075195, 125, 11, false, '2023-09-26 08:41:14.150097', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (127, '823595968', 2023, 2, 39, 4393.24997439122, 125, 3, false, '2023-09-26 08:41:14.150097', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (128, '828176199', 2023, 2, 992, 1684.35142223252, 125, 15, false, '2023-09-26 08:41:14.150097', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (129, '889592815', 2023, 2, 565, 2684.82415183696, 125, 1, false, '2023-09-26 08:41:14.150097', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (130, '876326312', 2023, 2, 206, 6020.47663479244, 125, 6, false, '2023-09-26 08:41:14.200338', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (131, '895656026', 2023, 2, 265, 3986.77507003243, 125, 12, false, '2023-09-26 08:41:14.200338', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (132, '866550041', 2023, 2, 55, 2615.57261003846, 125, 17, false, '2023-09-26 08:41:14.200338', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (133, '807148470', 2023, 2, 482, 9444.33601048702, 125, 1, false, '2023-09-26 08:41:14.200338', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (134, '873480135', 2023, 2, 992, 6506.776518543, 125, 7, false, '2023-09-26 08:41:14.200338', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (135, '834244928', 2023, 2, 711, 5590.06143733998, 125, 17, false, '2023-09-26 08:41:14.245467', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (136, '867599989', 2023, 2, 86, 3471.13252969725, 125, 2, false, '2023-09-26 08:41:14.245467', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (137, '800799655', 2023, 2, 233, 7718.76724466714, 125, 6, false, '2023-09-26 08:41:14.245467', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (138, '891901027', 2023, 2, 170, 5214.72433397346, 125, 5, false, '2023-09-26 08:41:14.245467', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (139, '897759899', 2023, 2, 32, 9672.26145985887, 125, 16, false, '2023-09-26 08:41:14.245467', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (140, '828451410', 2023, 2, 716, 1586.54031580333, 125, 11, false, '2023-09-26 08:41:14.245467', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (141, '843216309', 2023, 2, 20, 9528.52865556737, 125, 17, false, '2023-09-26 08:41:14.245467', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (142, '840322470', 2023, 2, 642, 7146.52210786665, 125, 19, false, '2023-09-26 08:41:14.245467', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (143, '834850124', 2023, 2, 477, 6579.88168391622, 125, 5, false, '2023-09-26 08:41:14.245467', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (144, '868514204', 2023, 2, 562, 2178.70271536461, 125, 20, false, '2023-09-26 08:41:14.284724', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (145, '817793850', 2023, 2, 630, 147.590870523686, 125, 14, false, '2023-09-26 08:41:14.284724', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (146, '812101864', 2023, 2, 411, 1904.73001491295, 125, 14, false, '2023-09-26 08:41:14.284724', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (147, '895076821', 2023, 2, 278, 4769.36815641221, 125, 19, false, '2023-09-26 08:41:14.284724', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (148, '827110995', 2023, 2, 203, 2053.96631295114, 125, 13, false, '2023-09-26 08:41:14.284724', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (149, '887902366', 2023, 2, 815, 5581.23461083651, 125, 13, false, '2023-09-26 08:41:14.323903', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (150, '834720617', 2023, 2, 820, 6656.77747461945, 125, 16, false, '2023-09-26 08:41:14.323903', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (151, '832815951', 2023, 2, 304, 9557.45330005118, 125, 1, false, '2023-09-26 08:41:14.323903', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (152, '813087477', 2023, 2, 964, 9843.1508754073, 125, 6, false, '2023-09-26 08:41:14.323903', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (153, '804157028', 2023, 2, 754, 8731.9051795613, 125, 4, false, '2023-09-26 08:41:14.323903', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (154, '854866731', 2023, 2, 346, 6493.9638703468, 125, 20, false, '2023-09-26 08:41:14.323903', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (155, '853500402', 2023, 2, 137, 6117.41873022674, 125, 5, false, '2023-09-26 08:41:14.323903', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (156, '893413801', 2023, 2, 916, 9281.95759019745, 125, 15, false, '2023-09-26 08:41:14.323903', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (157, '872692522', 2023, 2, 634, 7758.05907894505, 125, 14, false, '2023-09-26 08:41:14.353563', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (158, '882405148', 2023, 2, 621, 3956.69437872649, 125, 13, false, '2023-09-26 08:41:14.353563', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (159, '830563991', 2023, 2, 67, 6934.89499582802, 125, 8, false, '2023-09-26 08:41:14.353563', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (160, '827455980', 2023, 2, 602, 7793.22801812183, 125, 19, false, '2023-09-26 08:41:14.353563', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (161, '856160971', 2023, 2, 45, 8659.17218851751, 125, 6, false, '2023-09-26 08:41:14.353563', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (162, '843873189', 2023, 2, 255, 4628.65694469143, 125, 20, false, '2023-09-26 08:41:14.353563', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (163, '834748117', 2023, 2, 471, 356.363225539624, 125, 15, false, '2023-09-26 08:41:14.376573', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (164, '882432753', 2023, 2, 520, 5916.83771557917, 125, 15, false, '2023-09-26 08:41:14.376573', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (165, '881809662', 2023, 2, 227, 5572.9549896428, 125, 5, false, '2023-09-26 08:41:14.376573', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (166, '858896992', 2023, 2, 605, 8174.40912623623, 125, 1, false, '2023-09-26 08:41:14.376573', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (167, '889927062', 2023, 2, 592, 9465.25205155348, 125, 7, false, '2023-09-26 08:41:14.376573', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (168, '898258524', 2023, 2, 823, 7962.75151483617, 125, 8, false, '2023-09-26 08:41:14.403524', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (169, '889622954', 2023, 2, 611, 2072.15173173461, 125, 16, false, '2023-09-26 08:41:14.403524', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (170, '853241627', 2023, 2, 618, 1239.83116794252, 125, 11, false, '2023-09-26 08:41:14.403524', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (171, '870014549', 2023, 2, 353, 8634.12755499358, 125, 10, false, '2023-09-26 08:41:14.403524', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (172, '832059430', 2023, 2, 139, 5291.80767895537, 125, 18, false, '2023-09-26 08:41:14.403524', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (173, '831960181', 2023, 2, 680, 2092.93758206646, 125, 19, false, '2023-09-26 08:41:14.42626', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (174, '860954143', 2023, 2, 580, 14.6978436997586, 125, 8, false, '2023-09-26 08:41:14.42626', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (175, '892104686', 2023, 2, 305, 5091.66605263204, 125, 5, false, '2023-09-26 08:41:14.42626', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (176, '842058201', 2023, 2, 156, 9451.69648370343, 125, 5, false, '2023-09-26 08:41:14.469981', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (177, '859203352', 2023, 2, 262, 167.140741381241, 125, 1, false, '2023-09-26 08:41:14.469981', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (178, '843485965', 2023, 2, 330, 3060.27244593624, 125, 18, false, '2023-09-26 08:41:14.469981', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (179, '853657247', 2023, 2, 323, 3205.96285007086, 125, 14, false, '2023-09-26 08:41:14.469981', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (180, '824447452', 2023, 2, 342, 2048.4177914455, 125, 11, false, '2023-09-26 08:41:14.469981', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (181, '840050834', 2023, 2, 346, 132.76535212868, 125, 17, false, '2023-09-26 08:41:14.505381', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (182, '843326004', 2023, 2, 853, 7371.79844034223, 125, 7, false, '2023-09-26 08:41:14.505381', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (183, '860914228', 2023, 2, 867, 7879.1551275276, 125, 16, false, '2023-09-26 08:41:14.505381', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (184, '885643447', 2023, 2, 225, 9125.00176365117, 125, 10, false, '2023-09-26 08:41:14.505381', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (185, '878852103', 2023, 2, 199, 9573.61621371505, 125, 13, false, '2023-09-26 08:41:14.537017', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (186, '819613989', 2023, 2, 483, 2598.81671984276, 125, 12, false, '2023-09-26 08:41:14.537017', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (187, '814874744', 2023, 2, 846, 9369.70398008993, 125, 7, false, '2023-09-26 08:41:14.537017', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (188, '854547155', 2023, 2, 665, 9647.48725539611, 125, 5, false, '2023-09-26 08:41:14.537017', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (189, '813690133', 2023, 2, 155, 3902.35205397428, 125, 7, false, '2023-09-26 08:41:14.537017', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (190, '815692568', 2023, 2, 159, 1049.27689206769, 125, 20, false, '2023-09-26 08:41:14.570143', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (191, '832104782', 2023, 2, 629, 6035.4104118428, 125, 9, false, '2023-09-26 08:41:14.570143', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (192, '819546920', 2023, 2, 303, 6290.25012393677, 125, 13, false, '2023-09-26 08:41:14.59047', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (193, '825401573', 2023, 2, 518, 340.699544740972, 125, 14, false, '2023-09-26 08:41:14.59047', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (194, '843866157', 2023, 2, 509, 3977.65347451693, 125, 17, false, '2023-09-26 08:41:14.59047', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (195, '805658539', 2023, 2, 408, 8121.46552036433, 125, 16, false, '2023-09-26 08:41:14.59047', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (196, '841224892', 2023, 2, 149, 4931.87588911563, 125, 5, false, '2023-09-26 08:41:14.59047', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (197, '803022880', 2023, 2, 813, 925.068610811889, 125, 5, false, '2023-09-26 08:41:14.59047', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (198, '896518254', 2023, 2, 983, 257.337555120512, 125, 13, false, '2023-09-26 08:41:14.621129', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (199, '830643030', 2023, 2, 314, 2147.36309797474, 125, 9, false, '2023-09-26 08:41:14.621129', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (200, '893338866', 2023, 2, 512, 8749.02341082051, 125, 10, false, '2023-09-26 08:41:14.648062', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (201, '801530830', 2023, 2, 235, 3985.52259056154, 125, 8, false, '2023-09-26 08:41:14.648062', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (202, '854116543', 2023, 2, 652, 9203.18326563385, 125, 11, false, '2023-09-26 08:41:14.648062', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (203, '822163976', 2023, 2, 851, 8959.9312850661, 125, 19, false, '2023-09-26 08:41:14.648062', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (204, '808933287', 2023, 2, 507, 181.71528147828, 125, 14, false, '2023-09-26 08:41:14.648062', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (205, '818050310', 2023, 2, 133, 6175.96562036025, 125, 5, false, '2023-09-26 08:41:14.648062', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (206, '863716068', 2023, 2, 447, 830.560020439021, 125, 9, false, '2023-09-26 08:41:14.648062', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (207, '831760105', 2023, 2, 234, 4745.30110150614, 125, 10, false, '2023-09-26 08:41:14.671901', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (208, '888564163', 2023, 2, 405, 4618.1373575083, 125, 19, false, '2023-09-26 08:41:14.671901', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (209, '852309451', 2023, 2, 624, 3344.54738910143, 125, 5, false, '2023-09-26 08:41:14.671901', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (210, '890371035', 2023, 2, 474, 1446.18351326421, 125, 17, false, '2023-09-26 08:41:14.671901', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (211, '890925186', 2023, 2, 942, 5764.12422332106, 125, 11, false, '2023-09-26 08:41:14.671901', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (212, '898920835', 2023, 2, 846, 703.025837357115, 125, 3, false, '2023-09-26 08:41:14.706149', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (213, '890663657', 2023, 2, 14, 3421.90640847018, 125, 10, false, '2023-09-26 08:41:14.706149', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (214, '898784411', 2023, 2, 364, 5549.34023024541, 125, 2, false, '2023-09-26 08:41:14.706149', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (215, '852322922', 2023, 2, 422, 4680.32040390542, 125, 7, false, '2023-09-26 08:41:14.706149', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (216, '882706228', 2023, 2, 249, 8344.33670682225, 125, 15, false, '2023-09-26 08:41:14.706149', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (217, '886131564', 2023, 2, 723, 6375.83252937468, 125, 11, false, '2023-09-26 08:41:14.751368', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (218, '812662067', 2023, 2, 457, 4459.90818080442, 125, 11, false, '2023-09-26 08:41:14.751368', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (219, '832810025', 2023, 2, 786, 4238.68734423181, 125, 20, false, '2023-09-26 08:41:14.751368', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (220, '843127037', 2023, 2, 110, 6064.16957697333, 125, 3, false, '2023-09-26 08:41:14.751368', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (221, '876218247', 2023, 2, 623, 9727.21679020621, 125, 11, false, '2023-09-26 08:41:14.751368', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (222, '856802794', 2023, 2, 214, 5257.16372975985, 125, 14, false, '2023-09-26 08:41:14.784288', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (223, '866003303', 2023, 2, 550, 8235.88523895678, 125, 6, false, '2023-09-26 08:41:14.784288', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (224, '867493772', 2023, 2, 741, 8755.21710467148, 125, 9, false, '2023-09-26 08:41:14.784288', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (225, '811617678', 2023, 2, 148, 2205.22375274306, 125, 4, false, '2023-09-26 08:41:14.784288', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (226, '822556309', 2023, 2, 763, 7440.97576132296, 125, 11, false, '2023-09-26 08:41:14.784288', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (227, '805926138', 2023, 2, 300, 6554.95789482484, 125, 19, false, '2023-09-26 08:41:14.806917', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (228, '862023896', 2023, 2, 704, 4496.80400636768, 125, 7, false, '2023-09-26 08:41:14.806917', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (229, '875893485', 2023, 2, 772, 7361.98746604787, 125, 5, false, '2023-09-26 08:41:14.806917', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (230, '811788361', 2023, 2, 188, 1533.73590002095, 125, 15, false, '2023-09-26 08:41:14.806917', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (231, '808215390', 2023, 2, 876, 7852.23792966606, 125, 1, false, '2023-09-26 08:41:14.806917', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (232, '843297634', 2023, 2, 445, 4862.3918686995, 125, 15, false, '2023-09-26 08:41:14.834853', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (233, '845197013', 2023, 2, 182, 7083.12960994539, 125, 4, false, '2023-09-26 08:41:14.834853', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (234, '893637675', 2023, 2, 778, 7519.04116378614, 125, 17, false, '2023-09-26 08:41:14.834853', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (235, '845548783', 2023, 2, 68, 3544.67054980075, 125, 13, false, '2023-09-26 08:41:14.834853', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (236, '830539701', 2023, 2, 592, 3680.10753396346, 125, 12, false, '2023-09-26 08:41:14.834853', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (237, '820563519', 2023, 2, 915, 4512.87880399628, 125, 13, false, '2023-09-26 08:41:14.834853', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (238, '814765188', 2023, 2, 476, 5999.30395650228, 125, 17, false, '2023-09-26 08:41:14.834853', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (239, '875814545', 2023, 2, 297, 9076.76381677743, 125, 6, false, '2023-09-26 08:41:14.858428', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (240, '867296859', 2023, 2, 372, 19.26660045541, 125, 20, false, '2023-09-26 08:41:14.858428', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (241, '859376922', 2023, 2, 564, 6109.06605434901, 125, 6, false, '2023-09-26 08:41:14.858428', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (242, '890692239', 2023, 2, 669, 3121.10269405921, 125, 17, false, '2023-09-26 08:41:14.884561', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (243, '845661814', 2023, 2, 873, 9650.24681396461, 125, 11, false, '2023-09-26 08:41:14.884561', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (244, '876092060', 2023, 2, 388, 6410.83554141039, 125, 17, false, '2023-09-26 08:41:14.884561', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (245, '823313186', 2023, 2, 724, 2557.1300134003, 125, 20, false, '2023-09-26 08:41:14.917217', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (246, '854791028', 2023, 2, 517, 898.378010351009, 125, 6, false, '2023-09-26 08:41:14.917217', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (247, '848270274', 2023, 2, 353, 9280.04023002622, 125, 20, false, '2023-09-26 08:41:14.917217', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (248, '864247136', 2023, 2, 974, 820.617668007128, 125, 2, false, '2023-09-26 08:41:14.963834', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (249, '891403785', 2023, 2, 685, 3023.97681712703, 125, 20, false, '2023-09-26 08:41:14.963834', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (250, '814939601', 2023, 2, 940, 4307.24929029937, 125, 15, false, '2023-09-26 08:41:14.963834', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (251, '854703179', 2023, 2, 934, 1629.41187281066, 125, 9, false, '2023-09-26 08:41:14.963834', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (252, '849166780', 2023, 2, 606, 3322.66665893469, 125, 17, false, '2023-09-26 08:41:14.963834', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (253, '809533904', 2023, 2, 900, 3185.482637433, 125, 6, false, '2023-09-26 08:41:15.003823', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (254, '839802289', 2023, 2, 389, 8821.82528973092, 125, 19, false, '2023-09-26 08:41:15.003823', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (255, '858870327', 2023, 2, 88, 6959.22869309336, 125, 8, false, '2023-09-26 08:41:15.003823', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (256, '814625362', 2023, 2, 902, 924.48984641173, 125, 9, false, '2023-09-26 08:41:15.003823', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (257, '869274174', 2023, 2, 515, 7905.48868464491, 125, 3, false, '2023-09-26 08:41:15.003823', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (258, '862679562', 2023, 2, 945, 9083.1476047864, 125, 9, false, '2023-09-26 08:41:15.003823', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (259, '855263203', 2023, 2, 297, 4943.33609409593, 125, 13, false, '2023-09-26 08:41:15.003823', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (260, '807947468', 2023, 2, 113, 4223.71739111849, 125, 4, false, '2023-09-26 08:41:15.003823', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (261, '899140832', 2023, 2, 45, 1003.51327607902, 125, 20, false, '2023-09-26 08:41:15.046772', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (262, '814995115', 2023, 2, 740, 7287.21856474151, 125, 12, false, '2023-09-26 08:41:15.046772', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (263, '840627940', 2023, 2, 426, 9187.14216440749, 125, 7, false, '2023-09-26 08:41:15.046772', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (264, '822409793', 2023, 2, 919, 4226.25636509437, 125, 5, false, '2023-09-26 08:41:15.046772', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (265, '829598728', 2023, 2, 791, 1247.42576000848, 125, 14, false, '2023-09-26 08:41:15.046772', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (266, '811487041', 2023, 2, 177, 4017.23392862258, 125, 5, false, '2023-09-26 08:41:15.046772', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (267, '873219637', 2023, 2, 764, 5822.89442483427, 125, 10, false, '2023-09-26 08:41:15.086134', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (268, '891248584', 2023, 2, 311, 2004.59543165522, 125, 2, false, '2023-09-26 08:41:15.086134', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (269, '858042253', 2023, 2, 425, 8745.17129778232, 125, 9, false, '2023-09-26 08:41:15.086134', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (270, '804035361', 2023, 2, 277, 2053.30654060922, 125, 14, false, '2023-09-26 08:41:15.086134', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (271, '856940194', 2023, 2, 897, 5550.62209797716, 125, 10, false, '2023-09-26 08:41:15.086134', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (272, '832595872', 2023, 2, 525, 1951.3754433831, 125, 19, false, '2023-09-26 08:41:15.086134', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (273, '843931110', 2023, 2, 293, 327.548681590408, 125, 14, false, '2023-09-26 08:41:15.117728', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (274, '844627392', 2023, 2, 355, 7650.56071970585, 125, 16, false, '2023-09-26 08:41:15.117728', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (275, '837280530', 2023, 2, 23, 8853.07089998885, 125, 3, false, '2023-09-26 08:41:15.117728', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (276, '861895351', 2023, 2, 952, 6452.26759248489, 125, 6, false, '2023-09-26 08:41:15.117728', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (277, '862752393', 2023, 2, 10, 2368.95784201204, 125, 17, false, '2023-09-26 08:41:15.117728', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (278, '876901137', 2023, 2, 744, 4543.62593417033, 125, 16, false, '2023-09-26 08:41:15.117728', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (279, '841908141', 2023, 2, 70, 243.009788349685, 125, 1, false, '2023-09-26 08:41:15.141724', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (280, '835693750', 2023, 2, 276, 9212.59195117474, 125, 3, false, '2023-09-26 08:41:15.141724', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (281, '843856841', 2023, 2, 551, 7537.13919200294, 125, 8, false, '2023-09-26 08:41:15.141724', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (282, '816506380', 2023, 2, 177, 1263.1290106127, 125, 10, false, '2023-09-26 08:41:15.141724', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (283, '867068412', 2023, 2, 753, 6554.29259076467, 125, 14, false, '2023-09-26 08:41:15.141724', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (284, '880009250', 2023, 2, 737, 9597.02929171308, 125, 8, false, '2023-09-26 08:41:15.174413', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (285, '812011848', 2023, 2, 581, 7657.08355757086, 125, 1, false, '2023-09-26 08:41:15.174413', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (286, '888273755', 2023, 2, 157, 3937.06352242797, 125, 14, false, '2023-09-26 08:41:15.174413', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (287, '846393436', 2023, 2, 63, 6482.08751290492, 125, 14, false, '2023-09-26 08:41:15.174413', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (288, '831113163', 2023, 2, 793, 4001.34976808016, 125, 4, false, '2023-09-26 08:41:15.174413', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (289, '841116951', 2023, 2, 58, 6082.05188034302, 125, 12, false, '2023-09-26 08:41:15.174413', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (290, '869607779', 2023, 2, 627, 347.121614201275, 125, 11, false, '2023-09-26 08:41:15.206091', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (291, '835030409', 2023, 2, 650, 3576.76509401462, 125, 15, false, '2023-09-26 08:41:15.206091', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (292, '822263497', 2023, 2, 132, 5273.49482660966, 125, 12, false, '2023-09-26 08:41:15.206091', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (293, '875126680', 2023, 2, 30, 3002.24042352792, 125, 14, false, '2023-09-26 08:41:15.206091', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (294, '885953705', 2023, 2, 304, 1839.14638125788, 125, 13, false, '2023-09-26 08:41:15.206091', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (295, '891596153', 2023, 2, 151, 3071.17348304308, 125, 11, false, '2023-09-26 08:41:15.241937', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (296, '836503490', 2023, 2, 185, 8063.03517621746, 125, 20, false, '2023-09-26 08:41:15.241937', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (297, '805201745', 2023, 2, 88, 4265.6595905562, 125, 18, false, '2023-09-26 08:41:15.241937', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (298, '836133320', 2023, 2, 769, 3942.41663465897, 125, 18, false, '2023-09-26 08:41:15.241937', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (299, '826668465', 2023, 2, 774, 4362.54449061531, 125, 4, false, '2023-09-26 08:41:15.241937', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (300, '895148808', 2023, 2, 178, 3891.21248092082, 125, 17, false, '2023-09-26 08:41:15.277653', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (301, '827397411', 2023, 2, 534, 1900.73791314163, 125, 16, false, '2023-09-26 08:41:15.277653', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (302, '865680414', 2023, 2, 49, 7194.4853484274, 125, 14, false, '2023-09-26 08:41:15.277653', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (303, '882526380', 2023, 2, 330, 3937.7529148416, 125, 20, false, '2023-09-26 08:41:15.277653', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (304, '893639860', 2023, 2, 382, 7426.9083108012, 125, 11, false, '2023-09-26 08:41:15.277653', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (305, '849959569', 2023, 2, 928, 6442.05877750989, 125, 17, false, '2023-09-26 08:41:15.309043', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (306, '822591872', 2023, 2, 155, 9076.16916412257, 125, 3, false, '2023-09-26 08:41:15.309043', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (307, '815923187', 2023, 2, 956, 1680.19751089522, 125, 19, false, '2023-09-26 08:41:15.309043', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (308, '874451949', 2023, 2, 210, 143.715840526428, 125, 17, false, '2023-09-26 08:41:15.309043', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (309, '875847357', 2023, 2, 25, 5705.70358319473, 125, 1, false, '2023-09-26 08:41:15.309043', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (310, '883621424', 2023, 2, 901, 8744.02640153969, 125, 18, false, '2023-09-26 08:41:15.33308', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (311, '828700673', 2023, 2, 296, 41.0400632853144, 125, 12, false, '2023-09-26 08:41:15.33308', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (312, '834669073', 2023, 2, 654, 2857.17248093721, 125, 8, false, '2023-09-26 08:41:15.33308', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (313, '863315976', 2023, 2, 773, 7493.3543043503, 125, 10, false, '2023-09-26 08:41:15.33308', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (314, '877546819', 2023, 2, 807, 2177.17610300864, 125, 18, false, '2023-09-26 08:41:15.33308', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (315, '871751721', 2023, 2, 196, 5232.6311979508, 125, 4, false, '2023-09-26 08:41:15.33308', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (316, '822812612', 2023, 2, 195, 5978.22716202135, 125, 17, false, '2023-09-26 08:41:15.359322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (317, '858966616', 2023, 2, 386, 475.875918992136, 125, 12, false, '2023-09-26 08:41:15.359322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (318, '875705265', 2023, 2, 213, 4313.39919435668, 125, 5, false, '2023-09-26 08:41:15.359322', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (319, '882907789', 2023, 2, 959, 9414.98427569592, 125, 5, false, '2023-09-26 08:41:15.389158', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (320, '849707551', 2023, 2, 697, 7992.48186034488, 125, 9, false, '2023-09-26 08:41:15.389158', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (321, '859103042', 2023, 2, 594, 8696.47425254766, 125, 1, false, '2023-09-26 08:41:15.389158', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (322, '830359834', 2023, 2, 575, 434.920093842778, 125, 7, false, '2023-09-26 08:41:15.389158', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (323, '880967607', 2023, 2, 532, 4332.46504764776, 125, 14, false, '2023-09-26 08:41:15.389158', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (324, '818786135', 2023, 2, 104, 1273.22398708775, 125, 12, false, '2023-09-26 08:41:15.421971', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (325, '842810467', 2023, 2, 782, 1629.79150859437, 125, 3, false, '2023-09-26 08:41:15.421971', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (326, '869146460', 2023, 2, 284, 7648.83442861166, 125, 1, false, '2023-09-26 08:41:15.421971', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (327, '811235604', 2023, 2, 749, 904.70109786769, 125, 17, false, '2023-09-26 08:41:15.421971', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (328, '875345141', 2023, 2, 670, 7662.7665110999, 125, 8, false, '2023-09-26 08:41:15.450517', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (329, '880013472', 2023, 2, 708, 83.5457495263962, 125, 14, false, '2023-09-26 08:41:15.450517', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (330, '833759078', 2023, 2, 365, 5132.65495438879, 125, 9, false, '2023-09-26 08:41:15.450517', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (331, '888464361', 2023, 2, 866, 114.882325581857, 125, 12, false, '2023-09-26 08:41:15.450517', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (332, '854339829', 2023, 2, 288, 3845.46368928922, 125, 4, false, '2023-09-26 08:41:15.450517', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (333, '894571142', 2023, 2, 868, 707.945368064584, 125, 18, false, '2023-09-26 08:41:15.450517', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (334, '887905822', 2023, 2, 996, 9245.60718472893, 125, 13, false, '2023-09-26 08:41:15.492013', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (335, '833756981', 2023, 2, 434, 349.874672855899, 125, 17, false, '2023-09-26 08:41:15.492013', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (336, '826330385', 2023, 2, 458, 5206.95877926581, 125, 14, false, '2023-09-26 08:41:15.492013', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (337, '891555439', 2023, 2, 446, 7201.36212483155, 125, 11, false, '2023-09-26 08:41:15.492013', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (338, '896920834', 2023, 2, 578, 3033.38757493822, 125, 4, false, '2023-09-26 08:41:15.492013', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (339, '879564751', 2023, 2, 455, 8421.65069816687, 125, 13, false, '2023-09-26 08:41:15.492013', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (340, '836530672', 2023, 2, 548, 5652.19910781459, 125, 2, false, '2023-09-26 08:41:15.492013', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (341, '892324905', 2023, 2, 603, 8278.93865764528, 125, 8, false, '2023-09-26 08:41:15.492013', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (342, '822582670', 2023, 2, 365, 4519.5448392241, 125, 4, false, '2023-09-26 08:41:15.529111', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (343, '844004408', 2023, 2, 979, 5033.37047093555, 125, 19, false, '2023-09-26 08:41:15.529111', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (344, '806868172', 2023, 2, 458, 7257.39263363933, 125, 11, false, '2023-09-26 08:41:15.529111', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (345, '809808915', 2023, 2, 348, 717.11858064614, 125, 9, false, '2023-09-26 08:41:15.529111', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (346, '804710758', 2023, 2, 492, 8140.88688597455, 125, 19, false, '2023-09-26 08:41:15.572954', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (347, '851371456', 2023, 2, 135, 1986.07444223116, 125, 9, false, '2023-09-26 08:41:15.572954', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (348, '890797411', 2023, 2, 698, 4248.02739784466, 125, 12, false, '2023-09-26 08:41:15.572954', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (349, '834730925', 2023, 2, 80, 7848.09431139812, 125, 14, false, '2023-09-26 08:41:15.572954', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (350, '879694468', 2023, 2, 471, 3823.33764218847, 125, 5, false, '2023-09-26 08:41:15.572954', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (351, '878491400', 2023, 2, 482, 6132.39207925397, 125, 3, false, '2023-09-26 08:41:15.572954', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (352, '887695198', 2023, 2, 512, 4497.3656321652, 125, 8, false, '2023-09-26 08:41:15.572954', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (353, '817754837', 2023, 2, 323, 571.019554270098, 125, 11, false, '2023-09-26 08:41:15.572954', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (354, '817592892', 2023, 2, 420, 5329.38796380532, 125, 4, false, '2023-09-26 08:41:15.613009', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (355, '839628252', 2023, 2, 252, 7220.34159292366, 125, 7, false, '2023-09-26 08:41:15.613009', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (356, '881133468', 2023, 2, 75, 4400.86353435531, 125, 17, false, '2023-09-26 08:41:15.613009', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (357, '851076314', 2023, 2, 504, 7179.13196698761, 125, 19, false, '2023-09-26 08:41:15.613009', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (358, '812785759', 2023, 2, 786, 1355.56021405755, 125, 7, false, '2023-09-26 08:41:15.653985', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (359, '884442635', 2023, 2, 681, 9777.51863022868, 125, 20, false, '2023-09-26 08:41:15.653985', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (360, '845307946', 2023, 2, 258, 9619.37963170226, 125, 5, false, '2023-09-26 08:41:15.682254', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (361, '866583348', 2023, 2, 485, 2319.87195918392, 125, 15, false, '2023-09-26 08:41:15.682254', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (362, '875467294', 2023, 2, 280, 6456.47499147962, 125, 16, false, '2023-09-26 08:41:15.682254', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (363, '845360782', 2023, 2, 675, 9031.39980076939, 125, 6, false, '2023-09-26 08:41:15.682254', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (364, '864718167', 2023, 2, 926, 4127.15918380399, 125, 11, false, '2023-09-26 08:41:15.682254', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (365, '812375313', 2023, 2, 322, 835.195439384529, 125, 2, false, '2023-09-26 08:41:15.682254', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (366, '824153216', 2023, 2, 649, 4398.17433241297, 125, 3, false, '2023-09-26 08:41:15.682254', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (367, '844481790', 2023, 2, 602, 4758.69138500433, 125, 8, false, '2023-09-26 08:41:15.711798', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (368, '883251195', 2023, 2, 97, 9148.53269468152, 125, 8, false, '2023-09-26 08:41:15.711798', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (369, '847393696', 2023, 2, 972, 7815.22935521836, 125, 11, false, '2023-09-26 08:41:15.739425', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (370, '877551828', 2023, 2, 640, 3888.49394861665, 125, 17, false, '2023-09-26 08:41:15.739425', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (371, '824151314', 2023, 2, 286, 7492.61383604109, 125, 19, false, '2023-09-26 08:41:15.739425', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (372, '868625646', 2023, 2, 661, 6505.10945507272, 125, 6, false, '2023-09-26 08:41:15.739425', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (373, '801041781', 2023, 2, 555, 5438.78597357407, 125, 10, false, '2023-09-26 08:41:15.739425', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (374, '833522111', 2023, 2, 342, 9463.96195938861, 125, 12, false, '2023-09-26 08:41:15.739425', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (375, '838724757', 2023, 2, 134, 2081.01457399596, 125, 11, false, '2023-09-26 08:41:15.764683', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (376, '873142509', 2023, 2, 440, 3708.67046518997, 125, 4, false, '2023-09-26 08:41:15.764683', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (377, '819095643', 2023, 2, 681, 6253.30952129244, 125, 3, false, '2023-09-26 08:41:15.764683', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (378, '839805308', 2023, 2, 958, 5150.45186508564, 125, 12, false, '2023-09-26 08:41:15.764683', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (379, '864530414', 2023, 2, 46, 5256.9288429534, 125, 6, false, '2023-09-26 08:41:15.764683', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (380, '876334530', 2023, 2, 528, 737.069750754854, 125, 2, false, '2023-09-26 08:41:15.764683', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (381, '806839656', 2023, 2, 304, 9571.79934246099, 125, 19, false, '2023-09-26 08:41:15.764683', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (382, '846015259', 2023, 2, 478, 3679.39807113757, 125, 11, false, '2023-09-26 08:41:15.787112', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (383, '814345054', 2023, 2, 930, 5768.45995175914, 125, 9, false, '2023-09-26 08:41:15.787112', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (384, '873748492', 2023, 2, 252, 981.522151326157, 125, 9, false, '2023-09-26 08:41:15.787112', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (385, '870830126', 2023, 2, 834, 6217.45228321231, 125, 4, false, '2023-09-26 08:41:15.787112', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (386, '855694962', 2023, 2, 599, 1495.25254417058, 125, 8, false, '2023-09-26 08:41:15.816941', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (387, '816957144', 2023, 2, 773, 6485.85991240113, 125, 6, false, '2023-09-26 08:41:15.816941', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (388, '879958734', 2023, 2, 292, 5847.83545166226, 125, 9, false, '2023-09-26 08:41:15.816941', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (389, '854997907', 2023, 2, 251, 9747.32817324956, 125, 20, false, '2023-09-26 08:41:15.816941', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (390, '840090931', 2023, 2, 642, 3975.03266146439, 125, 13, false, '2023-09-26 08:41:15.816941', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (391, '896336814', 2023, 2, 428, 1059.65015472873, 125, 14, false, '2023-09-26 08:41:15.852528', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (392, '829763599', 2023, 2, 57, 1964.27270064472, 125, 2, false, '2023-09-26 08:41:15.852528', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (393, '804813050', 2023, 2, 374, 4373.15146770489, 125, 20, false, '2023-09-26 08:41:15.852528', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (394, '821982479', 2023, 2, 151, 6336.34428712588, 125, 20, false, '2023-09-26 08:41:15.852528', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (395, '801590421', 2023, 2, 720, 9861.18254710525, 125, 18, false, '2023-09-26 08:41:15.852528', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (396, '880244637', 2023, 2, 420, 294.012497264666, 125, 3, false, '2023-09-26 08:41:15.852528', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (397, '886923382', 2023, 2, 507, 8678.25188124006, 125, 19, false, '2023-09-26 08:41:15.878813', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (398, '835178070', 2023, 2, 107, 723.564997837629, 125, 14, false, '2023-09-26 08:41:15.878813', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (399, '878399690', 2023, 2, 477, 4574.7549184596, 125, 1, false, '2023-09-26 08:41:15.878813', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (400, '821233692', 2023, 2, 884, 4646.88111864863, 125, 8, false, '2023-09-26 08:41:15.878813', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (401, '834703013', 2023, 2, 26, 522.510986632101, 125, 11, false, '2023-09-26 08:41:15.878813', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (402, '875419244', 2023, 2, 191, 8444.80541715656, 125, 16, false, '2023-09-26 08:41:15.878813', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (403, '875524887', 2023, 2, 456, 3792.37433945843, 125, 11, false, '2023-09-26 08:41:15.878813', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (404, '808577852', 2023, 2, 529, 4697.40972531468, 125, 18, false, '2023-09-26 08:41:15.915361', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (405, '855976007', 2023, 2, 831, 3148.27873916781, 125, 17, false, '2023-09-26 08:41:15.915361', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (406, '805668045', 2023, 2, 487, 4344.94789235794, 125, 6, false, '2023-09-26 08:41:15.915361', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (407, '866053344', 2023, 2, 991, 1702.75117041821, 125, 3, false, '2023-09-26 08:41:15.915361', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (408, '826675802', 2023, 2, 145, 6781.77291840062, 125, 20, false, '2023-09-26 08:41:15.915361', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (409, '891178398', 2023, 2, 830, 5424.54186771673, 125, 3, false, '2023-09-26 08:41:15.915361', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (410, '827246869', 2023, 2, 224, 6347.92394582656, 125, 16, false, '2023-09-26 08:41:15.915361', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (411, '884866232', 2023, 2, 597, 4158.75799441922, 125, 17, false, '2023-09-26 08:41:15.915361', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (412, '832999354', 2023, 2, 564, 2162.75145633399, 125, 4, false, '2023-09-26 08:41:15.915361', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (413, '804217825', 2023, 2, 99, 4314.22585252185, 125, 16, false, '2023-09-26 08:41:15.951398', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (414, '877885837', 2023, 2, 815, 4542.53470670134, 125, 20, false, '2023-09-26 08:41:15.951398', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (415, '845650116', 2023, 2, 371, 8170.75150602407, 125, 8, false, '2023-09-26 08:41:15.951398', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (416, '825243256', 2023, 2, 942, 8657.20570728439, 125, 1, false, '2023-09-26 08:41:15.951398', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (417, '868231650', 2023, 2, 74, 2640.871198739, 125, 14, false, '2023-09-26 08:41:15.951398', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (418, '891495802', 2023, 2, 297, 6244.14467637251, 125, 2, false, '2023-09-26 08:41:15.951398', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (419, '803071765', 2023, 2, 148, 4335.9630943531, 125, 13, false, '2023-09-26 08:41:15.951398', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (420, '813392223', 2023, 2, 51, 4369.42919110768, 125, 6, false, '2023-09-26 08:41:15.990481', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (421, '838837456', 2023, 2, 105, 8769.0578019387, 125, 1, false, '2023-09-26 08:41:15.990481', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (422, '832925912', 2023, 2, 97, 1634.06081547723, 125, 19, false, '2023-09-26 08:41:15.990481', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (423, '879984059', 2023, 2, 896, 1699.73258235669, 125, 1, false, '2023-09-26 08:41:15.990481', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (424, '876194824', 2023, 2, 986, 2903.93428594617, 125, 5, false, '2023-09-26 08:41:15.990481', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (425, '869960927', 2023, 2, 481, 6093.35292380279, 125, 1, false, '2023-09-26 08:41:15.990481', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (426, '864924121', 2023, 2, 293, 8442.47748060939, 125, 13, false, '2023-09-26 08:41:15.990481', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (427, '889871834', 2023, 2, 163, 6282.89041854851, 125, 13, false, '2023-09-26 08:41:15.990481', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (428, '888941725', 2023, 2, 80, 2473.61718975705, 125, 16, false, '2023-09-26 08:41:15.990481', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (429, '864451386', 2023, 2, 892, 7580.96137743397, 125, 13, false, '2023-09-26 08:41:15.990481', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (430, '805409250', 2023, 2, 240, 9908.31105868539, 125, 5, false, '2023-09-26 08:41:15.990481', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (431, '885909306', 2023, 2, 979, 1950.89830983089, 125, 16, false, '2023-09-26 08:41:16.027805', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (432, '882842016', 2023, 2, 358, 2037.69266438839, 125, 1, false, '2023-09-26 08:41:16.027805', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (433, '828800154', 2023, 2, 79, 423.043961592307, 125, 10, false, '2023-09-26 08:41:16.027805', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (434, '865165378', 2023, 2, 43, 9969.01691821681, 125, 14, false, '2023-09-26 08:41:16.027805', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (435, '802468370', 2023, 2, 169, 1333.33012560269, 125, 16, false, '2023-09-26 08:41:16.027805', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (436, '866720470', 2023, 2, 268, 1004.04315941425, 125, 11, false, '2023-09-26 08:41:16.027805', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (437, '837254716', 2023, 2, 326, 114.291238017796, 125, 15, false, '2023-09-26 08:41:16.027805', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (438, '822693795', 2023, 2, 599, 9575.92369085653, 125, 8, false, '2023-09-26 08:41:16.027805', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (439, '824924346', 2023, 2, 221, 583.708836095387, 125, 9, false, '2023-09-26 08:41:16.155719', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (440, '840023586', 2023, 2, 555, 6425.92145554362, 125, 6, false, '2023-09-26 08:41:16.155719', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (441, '864991464', 2023, 2, 17, 7952.59416468357, 125, 8, false, '2023-09-26 08:41:16.155719', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (442, '859153568', 2023, 2, 997, 6271.69819296682, 125, 13, false, '2023-09-26 08:41:16.155719', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (443, '844114779', 2023, 2, 94, 1057.14081811801, 125, 7, false, '2023-09-26 08:41:16.155719', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (444, '838791317', 2023, 2, 398, 7594.74620090982, 125, 5, false, '2023-09-26 08:41:16.155719', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (445, '896532159', 2023, 2, 951, 3373.62645875974, 125, 12, false, '2023-09-26 08:41:16.155719', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (446, '856413108', 2023, 2, 536, 8475.7459354071, 125, 19, false, '2023-09-26 08:41:16.155719', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (447, '809698080', 2023, 2, 176, 4263.98086171842, 125, 19, false, '2023-09-26 08:41:16.194693', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (448, '817684378', 2023, 2, 226, 543.522368887555, 125, 5, false, '2023-09-26 08:41:16.194693', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (449, '832196578', 2023, 2, 309, 6296.41376851431, 125, 7, false, '2023-09-26 08:41:16.194693', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (450, '893850387', 2023, 2, 976, 6079.92023791259, 125, 1, false, '2023-09-26 08:41:16.194693', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (451, '817356166', 2023, 2, 568, 1156.4755025147, 125, 3, false, '2023-09-26 08:41:16.194693', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (452, '851432294', 2023, 2, 848, 4097.67019209132, 125, 19, false, '2023-09-26 08:41:16.194693', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (453, '864392250', 2023, 2, 192, 9565.12766338547, 125, 18, false, '2023-09-26 08:41:16.194693', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (454, '825803329', 2023, 2, 703, 8479.26913546395, 125, 6, false, '2023-09-26 08:41:16.234938', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (455, '819673352', 2023, 2, 562, 3661.40060733188, 125, 14, false, '2023-09-26 08:41:16.234938', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (456, '813294486', 2023, 2, 391, 4305.96867579292, 125, 17, false, '2023-09-26 08:41:16.234938', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (457, '878831599', 2023, 2, 973, 9309.61823277561, 125, 18, false, '2023-09-26 08:41:16.234938', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (458, '864960497', 2023, 2, 169, 1031.9811656264, 125, 19, false, '2023-09-26 08:41:16.234938', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (459, '802850140', 2023, 2, 66, 4362.69606054558, 125, 14, false, '2023-09-26 08:41:16.234938', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (460, '888167848', 2023, 2, 898, 9104.87403720959, 125, 10, false, '2023-09-26 08:41:16.234938', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (461, '842330504', 2023, 2, 346, 6177.90883876763, 125, 3, false, '2023-09-26 08:41:16.258321', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (462, '858424081', 2023, 2, 228, 804.442230156856, 125, 14, false, '2023-09-26 08:41:16.258321', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (463, '815207424', 2023, 2, 284, 4234.52140930101, 125, 10, false, '2023-09-26 08:41:16.258321', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (464, '865941162', 2023, 2, 782, 6749.76251321689, 125, 2, false, '2023-09-26 08:41:16.258321', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (465, '831686801', 2023, 2, 683, 3898.11982308672, 125, 1, false, '2023-09-26 08:41:16.258321', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (466, '895905384', 2023, 2, 134, 3420.49065653509, 125, 1, false, '2023-09-26 08:41:16.258321', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (467, '872009291', 2023, 2, 584, 2280.72245026209, 125, 19, false, '2023-09-26 08:41:16.276919', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (468, '863269152', 2023, 2, 385, 6557.73482028056, 125, 20, false, '2023-09-26 08:41:16.295731', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (469, '849547937', 2023, 2, 305, 5652.9281731588, 125, 20, false, '2023-09-26 08:41:16.295731', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (470, '873304362', 2023, 2, 802, 1801.69205089588, 125, 5, false, '2023-09-26 08:41:16.295731', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (471, '876387118', 2023, 2, 919, 6313.24622363166, 125, 1, false, '2023-09-26 08:41:16.321304', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (472, '857272488', 2023, 2, 905, 1297.04463521034, 125, 10, false, '2023-09-26 08:41:16.321304', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (473, '822221695', 2023, 2, 339, 7943.01178342074, 125, 17, false, '2023-09-26 08:41:16.321304', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (474, '819638427', 2023, 2, 568, 1740.42683343346, 125, 19, false, '2023-09-26 08:41:16.321304', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (475, '866895965', 2023, 2, 807, 9458.79855449603, 125, 4, false, '2023-09-26 08:41:16.353199', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (476, '861193841', 2023, 2, 507, 8325.67905821031, 125, 2, false, '2023-09-26 08:41:16.353199', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (477, '874977279', 2023, 2, 825, 9721.35780267307, 125, 9, false, '2023-09-26 08:41:16.353199', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (478, '889745877', 2023, 2, 488, 8007.87150627673, 125, 4, false, '2023-09-26 08:41:16.353199', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (479, '820698548', 2023, 2, 162, 2796.77040634917, 125, 8, false, '2023-09-26 08:41:16.353199', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (480, '809296618', 2023, 2, 679, 5150.34519265133, 125, 13, false, '2023-09-26 08:41:16.394658', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (481, '863705831', 2023, 2, 500, 4296.90923653654, 125, 14, false, '2023-09-26 08:41:16.394658', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (482, '811014768', 2023, 2, 264, 3330.17420310494, 125, 13, false, '2023-09-26 08:41:16.394658', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (483, '865854422', 2023, 2, 963, 8193.48762040632, 125, 13, false, '2023-09-26 08:41:16.394658', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (484, '820448483', 2023, 2, 268, 8907.98481264826, 125, 4, false, '2023-09-26 08:41:16.394658', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (485, '821667661', 2023, 2, 451, 4819.36561589896, 125, 3, false, '2023-09-26 08:41:16.422782', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (486, '889542390', 2023, 2, 559, 384.949348605021, 125, 13, false, '2023-09-26 08:41:16.422782', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (487, '835409486', 2023, 2, 505, 6785.51249274291, 125, 12, false, '2023-09-26 08:41:16.422782', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (488, '814346717', 2023, 2, 566, 6356.75362455732, 125, 5, false, '2023-09-26 08:41:16.422782', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (489, '815413004', 2023, 2, 497, 413.806166809939, 125, 12, false, '2023-09-26 08:41:16.422782', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (490, '818895804', 2023, 2, 484, 5771.0713121104, 125, 19, false, '2023-09-26 08:41:16.46408', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (491, '861204923', 2023, 2, 836, 1176.5967285063, 125, 8, false, '2023-09-26 08:41:16.46408', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (492, '879555072', 2023, 2, 938, 3188.90616626877, 125, 19, false, '2023-09-26 08:41:16.46408', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (493, '855772393', 2023, 2, 587, 3400.98124338432, 125, 3, false, '2023-09-26 08:41:16.46408', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (494, '837201486', 2023, 2, 580, 6460.41279378713, 125, 16, false, '2023-09-26 08:41:16.46408', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (495, '843460808', 2023, 2, 188, 3108.57040043822, 125, 2, false, '2023-09-26 08:41:16.46408', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (496, '877968358', 2023, 2, 646, 1274.85990287627, 125, 2, false, '2023-09-26 08:41:16.46408', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (497, '874838097', 2023, 2, 238, 7582.03168235031, 125, 19, false, '2023-09-26 08:41:16.46408', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (498, '805560200', 2023, 2, 294, 7258.33286162784, 125, 8, false, '2023-09-26 08:41:16.46408', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (499, '881593144', 2023, 2, 61, 1551.09877826762, 125, 1, false, '2023-09-26 08:41:16.498304', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (500, '842206021', 2023, 2, 847, 2237.73017109561, 125, 18, false, '2023-09-26 08:41:16.498304', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (501, '809539154', 2023, 2, 955, 7931.43598187355, 125, 8, false, '2023-09-26 08:41:16.533271', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (502, '881462374', 2023, 2, 24, 726.250321554819, 125, 19, false, '2023-09-26 08:41:16.533271', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (503, '829262952', 2023, 2, 378, 8046.37544639123, 125, 12, false, '2023-09-26 08:41:16.533271', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (504, '824601665', 2023, 2, 878, 7723.0092146944, 125, 15, false, '2023-09-26 08:41:16.533271', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (505, '862526144', 2023, 2, 78, 1004.38541490142, 125, 13, false, '2023-09-26 08:41:16.533271', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (506, '839613883', 2023, 2, 628, 5444.65564765413, 125, 9, false, '2023-09-26 08:41:16.533271', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (507, '888715789', 2023, 2, 679, 9847.21328138293, 125, 13, false, '2023-09-26 08:41:16.533271', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (508, '832828782', 2023, 2, 408, 6355.50130138424, 125, 14, false, '2023-09-26 08:41:16.533271', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (509, '816554836', 2023, 2, 472, 8432.45100626916, 125, 8, false, '2023-09-26 08:41:16.533271', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (510, '856843871', 2023, 2, 685, 9827.98098294844, 125, 17, false, '2023-09-26 08:41:16.558302', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (511, '885789588', 2023, 2, 499, 1060.72472201639, 125, 13, false, '2023-09-26 08:41:16.558302', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (512, '884813924', 2023, 2, 260, 6500.16558964637, 125, 17, false, '2023-09-26 08:41:16.558302', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (513, '890898121', 2023, 2, 573, 2196.82647238939, 125, 11, false, '2023-09-26 08:41:16.584199', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (514, '800950247', 2023, 2, 129, 3617.65051285804, 125, 19, false, '2023-09-26 08:41:16.584199', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (515, '837591913', 2023, 2, 927, 6237.43112410487, 125, 13, false, '2023-09-26 08:41:16.584199', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (516, '860767128', 2023, 2, 74, 8183.74429217532, 125, 4, false, '2023-09-26 08:41:16.584199', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (517, '838144492', 2023, 2, 834, 9297.00228827857, 125, 8, false, '2023-09-26 08:41:16.584199', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (518, '855490226', 2023, 2, 709, 5597.49075755217, 125, 5, false, '2023-09-26 08:41:16.611713', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (519, '850967552', 2023, 2, 977, 8561.13371217863, 125, 5, false, '2023-09-26 08:41:16.611713', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (520, '840025249', 2023, 2, 360, 5449.47671420642, 125, 18, false, '2023-09-26 08:41:16.611713', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (521, '836815368', 2023, 2, 901, 5945.01186219533, 125, 18, false, '2023-09-26 08:41:16.611713', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (522, '819212825', 2023, 2, 971, 6342.52078004536, 125, 19, false, '2023-09-26 08:41:16.611713', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (523, '868485136', 2023, 2, 705, 3433.18439402983, 125, 3, false, '2023-09-26 08:41:16.637989', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (524, '895904953', 2023, 2, 455, 3496.00013482464, 125, 16, false, '2023-09-26 08:41:16.637989', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (525, '879844455', 2023, 2, 984, 8999.50306626657, 125, 8, false, '2023-09-26 08:41:16.637989', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (526, '843762828', 2023, 2, 234, 8060.96978973519, 125, 18, false, '2023-09-26 08:41:16.663903', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (527, '816273549', 2023, 2, 208, 9207.14924209306, 125, 18, false, '2023-09-26 08:41:16.663903', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (528, '841533906', 2023, 2, 966, 653.619881829629, 125, 2, false, '2023-09-26 08:41:16.663903', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (529, '888102873', 2023, 2, 235, 9193.87913418609, 125, 10, false, '2023-09-26 08:41:16.663903', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (530, '834489694', 2023, 2, 72, 7125.23502510689, 125, 2, false, '2023-09-26 08:41:16.663903', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (531, '839054362', 2023, 2, 106, 6405.56655855099, 125, 20, false, '2023-09-26 08:41:16.663903', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (532, '802825378', 2023, 2, 942, 4401.55625039937, 125, 2, false, '2023-09-26 08:41:16.693134', NULL);


--
-- Data for Name: sykefravar_statistikk_virksomhet_siste_4_kvartal; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (1, '987654321', 22632.4054012044, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.270519', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (2, '987654321', 22632.4054012044, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.303685', 1, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (3, '123456789', 1493.8074855927, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.327911', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (4, '123456789', 1493.8074855927, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.327911', 1, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (5, '123456789', 1493.8074855927, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.327911', 4, 2022);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (6, '123456789', 1493.8074855927, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.327911', 3, 2022);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (7, '123456789', 1493.8074855927, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.327911', 2, 2022);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (8, '123456789', 1493.8074855927, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.327911', 1, 2022);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (9, '123456789', 1493.8074855927, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.327911', 4, 2021);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (10, '123456789', 1493.8074855927, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.382114', 3, 2021);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (11, '123456789', 1493.8074855927, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.382114', 2, 2021);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (12, '123456789', 1493.8074855927, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.382114', 1, 2021);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (13, '123456789', 1493.8074855927, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.382114', 4, 2020);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (14, '123456789', 1493.8074855927, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.382114', 3, 2020);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (15, '123456789', 1493.8074855927, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.382114', 2, 2020);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (16, '123456789', 1493.8074855927, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.421352', 1, 2020);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (17, '123456789', 1493.8074855927, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.421352', 4, 2019);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (18, '123456789', 1493.8074855927, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.421352', 3, 2019);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (19, '123456789', 1493.8074855927, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.421352', 2, 2019);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (20, '123456789', 1493.8074855927, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.421352', 1, 2019);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (21, '123456789', 1493.8074855927, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.421352', 4, 2018);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (22, '123456789', 1493.8074855927, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.421352', 3, 2018);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (23, '555555555', 1067.084211155, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.458892', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (24, '857241581', 3139.02714199023, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.458892', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (25, '857241581', 3139.02714199023, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.458892', 1, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (26, '867365117', 34856.0671476776, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.458892', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (27, '867365117', 34856.0671476776, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.458892', 1, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (28, '881114246', 3890.94476190628, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.500758', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (29, '881114246', 3890.94476190628, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.500758', 1, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (30, '891771817', 19514.9679015079, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.500758', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (31, '891771817', 19514.9679015079, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.500758', 1, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (32, '898525058', 25187.1978629365, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.500758', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (33, '835220383', 21695.8173949814, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.500758', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (34, '878746520', 22981.5469110501, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.551981', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (35, '883329944', 31411.8658462996, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.551981', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (36, '852437928', 8170.66578602764, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.551981', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (37, '895309223', 17890.3176475571, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.551981', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (38, '835031049', 4402.46372394152, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.551981', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (39, '873220998', 33931.3871836542, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.551981', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (40, '835774114', 34589.9990735703, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.551981', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (41, '862164924', 22266.2416529196, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.60198', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (42, '896270090', 6744.88792425515, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.60198', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (43, '897255882', 25308.3343322016, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.60198', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (44, '848363736', 9489.05257766579, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.60198', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (45, '882275284', 24657.6588843147, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.60198', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (46, '834436066', 10341.5025705328, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.60198', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (47, '829040586', 15192.5840895353, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.64419', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (48, '816209538', 4571.6136588393, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.64419', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (49, '831787072', 39714.6622349645, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.64419', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (50, '877257237', 33469.6175768255, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.64419', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (51, '889355886', 3661.36277563243, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.64419', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (52, '895626556', 22898.35108185, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.64419', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (53, '821709008', 39319.7019172009, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.64419', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (54, '804237955', 39686.5614694802, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.64419', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (55, '872367868', 13626.071387749, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.690497', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (56, '803742463', 35710.9382684978, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.690497', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (57, '892845353', 6303.6857307264, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.690497', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (58, '861622901', 24766.6619742754, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.690497', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (59, '881875590', 255.861975113814, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.690497', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (60, '801835452', 35305.3531441767, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.690497', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (61, '875258326', 9714.67358440232, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.733342', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (62, '845784470', 5218.1055843678, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.733342', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (63, '859440331', 20138.1832408419, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.733342', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (64, '819479903', 21092.2669153695, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.733342', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (65, '890551762', 32360.8288792564, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.733342', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (66, '861778194', 28893.2604249208, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.733342', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (67, '805339854', 30480.9562772596, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.733342', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (68, '815390484', 26321.0831678334, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.777776', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (69, '850462341', 2644.99823441916, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.777776', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (70, '874452140', 26898.4654436276, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.777776', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (71, '811851790', 13604.8448421343, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.777776', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (72, '873515591', 24472.6611033141, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.777776', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (73, '836279558', 10238.1757770509, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.777776', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (74, '809727399', 21856.7534850981, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.811258', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (75, '824470634', 3411.08838786397, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.811258', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (76, '836516461', 22633.6953184382, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.811258', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (77, '837159750', 37369.5957367111, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.811258', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (78, '811866664', 27051.9632231933, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.811258', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (79, '851277727', 10803.7992808999, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.811258', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (80, '842226671', 23830.3387487275, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.853121', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (81, '821968574', 37189.0886813144, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.853121', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (82, '824580761', 28669.3477354783, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.853121', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (83, '889367910', 13692.7668109982, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.853121', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (84, '840237611', 9477.3810651878, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.853121', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (85, '800908366', 29118.7141972805, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.885904', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (86, '822930437', 37153.9484108287, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.885904', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (87, '814250450', 6639.63446674585, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.885904', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (88, '808744432', 3471.65783301238, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.885904', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (89, '857826950', 31118.7739156951, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.885904', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (90, '870623580', 24738.5327140367, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.885904', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (91, '810733872', 5229.24790205895, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.885904', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (92, '827935929', 32478.21980252, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.921433', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (93, '863730729', 7271.83717644774, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.921433', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (94, '857184109', 750.622720140566, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.921433', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (95, '852734859', 37747.3320609798, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.921433', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (96, '853594439', 17861.6495165475, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.921433', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (97, '818803358', 6882.69753829524, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.921433', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (98, '853653063', 29562.2718110443, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.921433', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (99, '841238334', 13471.1968178775, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.955526', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (100, '813169303', 18252.8062664653, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.955526', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (101, '839551215', 23609.9360076289, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.955526', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (102, '880193321', 21129.1279107239, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.955526', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (103, '833735069', 20001.9374524471, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.955526', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (104, '859513692', 38190.8780785524, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.955526', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (105, '842466076', 35512.7330284084, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:13.955526', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (106, '894329113', 1437.06404354513, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.00329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (107, '878105030', 7445.39251000544, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.00329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (108, '801615123', 20640.3177381541, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.00329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (109, '899812147', 27069.3936515134, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.040711', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (110, '867355472', 8402.69414739872, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.040711', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (111, '862566596', 14009.7317689737, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.040711', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (112, '848711875', 16508.2859737665, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.040711', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (113, '899871018', 28624.7630294353, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.040711', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (114, '834231007', 10697.679265266, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.040711', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (115, '844851816', 16560.5221472661, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.040711', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (116, '883686536', 34197.2817923508, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.097095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (117, '846917560', 28592.6520629684, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.097095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (118, '819849863', 9998.56671907888, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.097095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (119, '802805958', 22604.2209583721, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.097095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (120, '893385116', 25254.7983446223, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.134601', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (121, '821342624', 34331.3175753656, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.134601', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (122, '807688973', 17233.4064049518, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.134601', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (123, '807482958', 13269.5484333713, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.134601', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (124, '840247819', 22445.242547874, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.134601', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (125, '833662191', 1272.7414343312, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.134601', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (126, '857600929', 29671.8898830078, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.134601', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (127, '823595968', 17572.9998975649, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.134601', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (128, '828176199', 6737.40568893009, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.134601', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (129, '889592815', 10739.2966073478, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.134601', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (130, '876326312', 24081.9065391698, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.18918', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (131, '895656026', 15947.1002801297, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.18918', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (132, '866550041', 10462.2904401538, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.18918', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (133, '807148470', 37777.3440419481, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.18918', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (134, '873480135', 26027.106074172, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.18918', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (135, '834244928', 22360.2457493599, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.232075', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (136, '867599989', 13884.530118789, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.232075', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (137, '800799655', 30875.0689786686, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.232075', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (138, '891901027', 20858.8973358938, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.232075', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (139, '897759899', 38689.0458394355, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.232075', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (140, '828451410', 6346.16126321331, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.232075', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (141, '843216309', 38114.1146222695, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.232075', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (142, '840322470', 28586.0884314666, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.232075', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (143, '834850124', 26319.5267356649, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.232075', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (144, '868514204', 8714.81086145843, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.275295', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (145, '817793850', 590.363482094744, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.275295', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (146, '812101864', 7618.92005965179, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.275295', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (147, '895076821', 19077.4726256488, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.275295', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (148, '827110995', 8215.86525180456, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.275295', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (149, '887902366', 22324.938443346, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.308489', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (150, '834720617', 26627.1098984778, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.308489', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (151, '832815951', 38229.8132002047, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.308489', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (152, '813087477', 39372.6035016292, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.308489', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (153, '804157028', 34927.6207182452, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.308489', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (154, '854866731', 25975.8554813872, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.308489', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (155, '853500402', 24469.674920907, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.308489', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (156, '893413801', 37127.8303607898, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.308489', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (157, '872692522', 31032.2363157802, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.34788', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (158, '882405148', 15826.7775149059, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.34788', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (159, '830563991', 27739.5799833121, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.34788', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (160, '827455980', 31172.9120724873, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.34788', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (161, '856160971', 34636.68875407, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.34788', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (162, '843873189', 18514.6277787657, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.34788', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (163, '834748117', 1425.4529021585, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.372301', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (164, '882432753', 23667.3508623167, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.372301', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (165, '881809662', 22291.8199585712, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.372301', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (166, '858896992', 32697.6365049449, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.372301', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (167, '889927062', 37861.0082062139, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.372301', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (168, '898258524', 31851.0060593447, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.395339', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (169, '889622954', 8288.60692693843, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.395339', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (170, '853241627', 4959.32467177008, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.395339', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (171, '870014549', 34536.5102199743, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.395339', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (172, '832059430', 21167.2307158215, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.395339', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (173, '831960181', 8371.75032826585, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.421514', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (174, '860954143', 58.7913747990345, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.421514', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (175, '892104686', 20366.6642105282, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.421514', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (176, '842058201', 37806.7859348137, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.458856', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (177, '859203352', 668.562965524965, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.458856', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (178, '843485965', 12241.0897837449, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.458856', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (179, '853657247', 12823.8514002834, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.458856', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (180, '824447452', 8193.67116578199, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.458856', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (181, '840050834', 531.061408514718, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.498682', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (182, '843326004', 29487.1937613689, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.498682', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (183, '860914228', 31516.6205101104, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.498682', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (184, '885643447', 36500.0070546047, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.498682', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (185, '878852103', 38294.4648548602, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.526486', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (186, '819613989', 10395.266879371, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.526486', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (187, '814874744', 37478.8159203597, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.526486', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (188, '854547155', 38589.9490215844, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.526486', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (189, '813690133', 15609.4082158971, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.526486', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (190, '815692568', 4197.10756827075, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.564818', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (191, '832104782', 24141.6416473712, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.564818', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (192, '819546920', 25161.0004957471, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.582861', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (193, '825401573', 1362.79817896389, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.582861', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (194, '843866157', 15910.6138980677, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.582861', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (195, '805658539', 32485.8620814573, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.582861', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (196, '841224892', 19727.5035564625, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.582861', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (197, '803022880', 3700.27444324755, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.582861', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (198, '896518254', 1029.35022048205, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.616978', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (199, '830643030', 8589.45239189894, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.616978', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (200, '893338866', 34996.0936432821, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.639536', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (201, '801530830', 15942.0903622462, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.639536', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (202, '854116543', 36812.7330625354, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.639536', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (203, '822163976', 35839.7251402644, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.639536', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (204, '808933287', 726.861125913122, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.639536', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (205, '818050310', 24703.862481441, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.639536', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (206, '863716068', 3322.24008175608, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.639536', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (207, '831760105', 18981.2044060246, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.665977', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (208, '888564163', 18472.5494300332, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.665977', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (209, '852309451', 13378.1895564057, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.665977', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (210, '890371035', 5784.73405305684, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.665977', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (211, '890925186', 23056.4968932842, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.665977', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (212, '898920835', 2812.10334942846, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.699304', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (213, '890663657', 13687.6256338807, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.699304', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (214, '898784411', 22197.3609209817, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.699304', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (215, '852322922', 18721.2816156217, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.699304', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (216, '882706228', 33377.346827289, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.699304', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (217, '886131564', 25503.3301174987, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.739738', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (218, '812662067', 17839.6327232177, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.739738', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (219, '832810025', 16954.7493769272, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.739738', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (220, '843127037', 24256.6783078933, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.739738', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (221, '876218247', 38908.8671608248, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.739738', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (222, '856802794', 21028.6549190394, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.77183', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (223, '866003303', 32943.5409558271, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.77183', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (224, '867493772', 35020.8684186859, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.77183', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (225, '811617678', 8820.89501097226, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.77183', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (226, '822556309', 29763.9030452918, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.77183', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (227, '805926138', 26219.8315792994, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.801754', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (228, '862023896', 17987.2160254707, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.801754', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (229, '875893485', 29447.9498641915, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.801754', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (230, '811788361', 6134.94360008381, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.801754', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (231, '808215390', 31408.9517186643, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.801754', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (232, '843297634', 19449.567474798, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.827276', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (233, '845197013', 28332.5184397816, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.827276', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (234, '893637675', 30076.1646551446, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.827276', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (235, '845548783', 14178.682199203, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.827276', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (236, '830539701', 14720.4301358538, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.827276', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (237, '820563519', 18051.5152159851, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.827276', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (238, '814765188', 23997.2158260091, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.827276', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (239, '875814545', 36307.0552671097, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.852988', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (240, '867296859', 77.0664018216399, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.852988', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (241, '859376922', 24436.264217396, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.852988', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (242, '890692239', 12484.4107762368, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.878073', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (243, '845661814', 38600.9872558584, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.878073', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (244, '876092060', 25643.3421656416, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.878073', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (245, '823313186', 10228.5200536012, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.903358', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (246, '854791028', 3593.51204140404, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.903358', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (247, '848270274', 37120.1609201049, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.903358', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (248, '864247136', 3282.47067202851, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.949982', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (249, '891403785', 12095.9072685081, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.949982', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (250, '814939601', 17228.9971611975, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.949982', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (251, '854703179', 6517.64749124265, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.949982', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (252, '849166780', 13290.6666357388, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.949982', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (253, '809533904', 12741.930549732, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.986119', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (254, '839802289', 35287.3011589237, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.986119', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (255, '858870327', 27836.9147723734, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.986119', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (256, '814625362', 3697.95938564692, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.986119', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (257, '869274174', 31621.9547385796, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.986119', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (258, '862679562', 36332.5904191456, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.986119', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (259, '855263203', 19773.3443763837, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.986119', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (260, '807947468', 16894.869564474, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:14.986119', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (261, '899140832', 4014.05310431609, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.037485', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (262, '814995115', 29148.874258966, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.037485', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (263, '840627940', 36748.5686576299, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.037485', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (264, '822409793', 16905.0254603775, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.037485', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (265, '829598728', 4989.70304003391, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.037485', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (266, '811487041', 16068.9357144903, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.037485', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (267, '873219637', 23291.5776993371, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.077107', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (268, '891248584', 8018.38172662089, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.077107', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (269, '858042253', 34980.6851911293, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.077107', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (270, '804035361', 8213.2261624369, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.077107', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (271, '856940194', 22202.4883919086, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.077107', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (272, '832595872', 7805.5017735324, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.077107', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (273, '843931110', 1310.19472636163, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.108496', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (274, '844627392', 30602.2428788234, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.108496', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (275, '837280530', 35412.2835999554, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.108496', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (276, '861895351', 25809.0703699396, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.108496', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (277, '862752393', 9475.83136804817, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.108496', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (278, '876901137', 18174.5037366813, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.108496', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (279, '841908141', 972.039153398739, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.134114', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (280, '835693750', 36850.367804699, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.134114', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (281, '843856841', 30148.5567680118, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.134114', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (282, '816506380', 5052.51604245081, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.134114', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (283, '867068412', 26217.1703630587, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.134114', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (284, '880009250', 38388.1171668523, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.162094', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (285, '812011848', 30628.3342302834, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.162094', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (286, '888273755', 15748.2540897119, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.162094', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (287, '846393436', 25928.3500516197, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.162094', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (288, '831113163', 16005.3990723206, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.162094', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (289, '841116951', 24328.2075213721, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.162094', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (290, '869607779', 1388.4864568051, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.200935', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (291, '835030409', 14307.0603760585, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.200935', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (292, '822263497', 21093.9793064386, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.200935', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (293, '875126680', 12008.9616941117, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.200935', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (294, '885953705', 7356.5855250315, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.200935', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (295, '891596153', 12284.6939321723, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.229837', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (296, '836503490', 32252.1407048698, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.229837', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (297, '805201745', 17062.6383622248, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.229837', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (298, '836133320', 15769.6665386359, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.229837', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (299, '826668465', 17450.1779624612, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.229837', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (300, '895148808', 15564.8499236833, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.266889', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (301, '827397411', 7602.95165256653, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.266889', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (302, '865680414', 28777.9413937096, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.266889', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (303, '882526380', 15751.0116593664, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.266889', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (304, '893639860', 29707.6332432048, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.266889', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (305, '849959569', 25768.2351100396, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.298679', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (306, '822591872', 36304.6766564903, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.298679', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (307, '815923187', 6720.79004358086, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.298679', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (308, '874451949', 574.863362105712, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.298679', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (309, '875847357', 22822.8143327789, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.298679', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (310, '883621424', 34976.1056061588, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.323888', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (311, '828700673', 164.160253141258, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.323888', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (312, '834669073', 11428.6899237489, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.323888', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (313, '863315976', 29973.4172174012, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.323888', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (314, '877546819', 8708.70441203457, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.323888', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (315, '871751721', 20930.5247918032, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.323888', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (316, '822812612', 23912.9086480854, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.35254', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (317, '858966616', 1903.50367596854, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.35254', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (318, '875705265', 17253.5967774267, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.35254', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (319, '882907789', 37659.9371027837, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.37838', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (320, '849707551', 31969.9274413795, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.37838', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (321, '859103042', 34785.8970101907, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.37838', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (322, '830359834', 1739.68037537111, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.37838', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (323, '880967607', 17329.8601905911, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.37838', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (324, '818786135', 5092.89594835099, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.404568', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (325, '842810467', 6519.16603437749, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.404568', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (326, '869146460', 30595.3377144466, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.404568', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (327, '811235604', 3618.80439147076, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.404568', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (328, '875345141', 30651.0660443996, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.441726', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (329, '880013472', 334.182998105585, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.441726', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (330, '833759078', 20530.6198175552, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.441726', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (331, '888464361', 459.529302327427, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.441726', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (332, '854339829', 15381.8547571569, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.441726', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (333, '894571142', 2831.78147225834, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.441726', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (334, '887905822', 36982.4287389157, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.47785', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (335, '833756981', 1399.49869142359, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.47785', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (336, '826330385', 20827.8351170632, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.47785', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (337, '891555439', 28805.4484993262, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.47785', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (338, '896920834', 12133.5502997529, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.47785', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (339, '879564751', 33686.6027926675, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.47785', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (340, '836530672', 22608.7964312584, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.47785', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (341, '892324905', 33115.7546305811, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.47785', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (342, '822582670', 18078.1793568964, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.521887', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (343, '844004408', 20133.4818837422, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.521887', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (344, '806868172', 29029.5705345573, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.521887', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (345, '809808915', 2868.47432258456, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.521887', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (346, '804710758', 32563.5475438982, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.56149', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (347, '851371456', 7944.29776892464, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.56149', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (348, '890797411', 16992.1095913787, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.56149', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (349, '834730925', 31392.3772455925, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.56149', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (350, '879694468', 15293.3505687539, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.56149', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (351, '878491400', 24529.5683170159, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.56149', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (352, '887695198', 17989.4625286608, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.56149', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (353, '817754837', 2284.07821708039, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.56149', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (354, '817592892', 21317.5518552213, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.603377', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (355, '839628252', 28881.3663716947, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.603377', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (356, '881133468', 17603.4541374212, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.603377', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (357, '851076314', 28716.5278679504, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.603377', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (358, '812785759', 5422.24085623021, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.648249', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (359, '884442635', 39110.0745209147, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.648249', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (360, '845307946', 38477.5185268091, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.671768', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (361, '866583348', 9279.48783673568, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.671768', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (362, '875467294', 25825.8999659185, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.671768', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (363, '845360782', 36125.5992030776, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.671768', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (364, '864718167', 16508.6367352159, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.671768', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (365, '812375313', 3340.78175753812, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.671768', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (366, '824153216', 17592.6973296519, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.671768', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (367, '844481790', 19034.7655400173, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.703062', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (368, '883251195', 36594.1307787261, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.703062', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (369, '847393696', 31260.9174208734, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.734521', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (370, '877551828', 15553.9757944666, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.734521', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (371, '824151314', 29970.4553441644, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.734521', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (372, '868625646', 26020.4378202909, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.734521', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (373, '801041781', 21755.1438942963, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.734521', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (374, '833522111', 37855.8478375544, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.734521', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (375, '838724757', 8324.05829598384, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.757843', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (376, '873142509', 14834.6818607599, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.757843', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (377, '819095643', 25013.2380851698, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.757843', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (378, '839805308', 20601.8074603426, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.757843', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (379, '864530414', 21027.7153718136, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.757843', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (380, '876334530', 2948.27900301942, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.757843', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (381, '806839656', 38287.197369844, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.757843', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (382, '846015259', 14717.5922845503, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.780952', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (383, '814345054', 23073.8398070366, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.780952', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (384, '873748492', 3926.08860530463, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.780952', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (385, '870830126', 24869.8091328492, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.780952', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (386, '855694962', 5981.01017668234, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.806569', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (387, '816957144', 25943.4396496045, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.806569', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (388, '879958734', 23391.3418066491, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.806569', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (389, '854997907', 38989.3126929982, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.806569', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (390, '840090931', 15900.1306458576, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.806569', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (391, '896336814', 4238.60061891493, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.837437', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (392, '829763599', 7857.09080257888, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.837437', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (393, '804813050', 17492.6058708195, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.837437', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (394, '821982479', 25345.3771485035, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.837437', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (395, '801590421', 39444.730188421, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.837437', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (396, '880244637', 1176.04998905866, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.837437', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (397, '886923382', 34713.0075249603, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.87159', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (398, '835178070', 2894.25999135051, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.87159', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (399, '878399690', 18299.0196738384, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.87159', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (400, '821233692', 18587.5244745945, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.87159', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (401, '834703013', 2090.0439465284, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.87159', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (402, '875419244', 33779.2216686262, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.87159', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (403, '875524887', 15169.4973578337, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.87159', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (404, '808577852', 18789.6389012587, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.904258', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (405, '855976007', 12593.1149566712, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.904258', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (406, '805668045', 17379.7915694318, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.904258', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (407, '866053344', 6811.00468167285, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.904258', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (408, '826675802', 27127.0916736025, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.904258', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (409, '891178398', 21698.1674708669, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.904258', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (410, '827246869', 25391.6957833062, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.904258', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (411, '884866232', 16635.0319776769, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.904258', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (412, '832999354', 8651.00582533595, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.904258', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (413, '804217825', 17256.9034100874, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.942436', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (414, '877885837', 18170.1388268054, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.942436', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (415, '845650116', 32683.0060240963, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.942436', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (416, '825243256', 34628.8228291376, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.942436', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (417, '868231650', 10563.484794956, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.942436', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (418, '891495802', 24976.57870549, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.942436', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (419, '803071765', 17343.8523774124, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.942436', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (420, '813392223', 17477.7167644307, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.974923', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (421, '838837456', 35076.2312077548, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.974923', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (422, '832925912', 6536.24326190891, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.974923', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (423, '879984059', 6798.93032942677, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.974923', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (424, '876194824', 11615.7371437847, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.974923', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (425, '869960927', 24373.4116952112, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.974923', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (426, '864924121', 33769.9099224375, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.974923', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (427, '889871834', 25131.5616741941, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.974923', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (428, '888941725', 9894.4687590282, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.974923', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (429, '864451386', 30323.8455097359, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.974923', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (430, '805409250', 39633.2442347415, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:15.974923', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (431, '885909306', 7803.59323932358, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.014411', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (432, '882842016', 8150.77065755357, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.014411', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (433, '828800154', 1692.17584636923, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.014411', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (434, '865165378', 39876.0676728672, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.014411', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (435, '802468370', 5333.32050241076, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.014411', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (436, '866720470', 4016.17263765699, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.014411', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (437, '837254716', 457.164952071186, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.014411', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (438, '822693795', 38303.6947634261, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.014411', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (439, '824924346', 2334.83534438155, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.141955', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (440, '840023586', 25703.6858221745, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.141955', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (441, '864991464', 31810.3766587343, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.141955', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (442, '859153568', 25086.7927718673, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.141955', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (443, '844114779', 4228.56327247203, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.141955', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (444, '838791317', 30378.9848036393, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.141955', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (445, '896532159', 13494.505835039, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.141955', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (446, '856413108', 33902.9837416284, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.141955', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (447, '809698080', 17055.9234468737, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.179279', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (448, '817684378', 2174.08947555022, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.179279', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (449, '832196578', 25185.6550740572, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.179279', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (450, '893850387', 24319.6809516504, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.179279', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (451, '817356166', 4625.90201005879, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.179279', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (452, '851432294', 16390.6807683653, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.179279', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (453, '864392250', 38260.5106535419, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.179279', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (454, '825803329', 33917.0765418558, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.223123', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (455, '819673352', 14645.6024293275, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.223123', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (456, '813294486', 17223.8747031717, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.223123', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (457, '878831599', 37238.4729311024, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.223123', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (458, '864960497', 4127.92466250561, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.223123', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (459, '802850140', 17450.7842421823, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.223123', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (460, '888167848', 36419.4961488383, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.223123', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (461, '842330504', 24711.6353550705, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.251456', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (462, '858424081', 3217.76892062743, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.251456', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (463, '815207424', 16938.085637204, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.251456', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (464, '865941162', 26999.0500528675, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.251456', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (465, '831686801', 15592.4792923469, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.251456', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (466, '895905384', 13681.9626261404, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.251456', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (467, '872009291', 9122.88980104835, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.274319', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (468, '863269152', 26230.9392811223, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.291309', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (469, '849547937', 22611.7126926352, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.291309', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (470, '873304362', 7206.76820358352, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.291309', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (471, '876387118', 25252.9848945266, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.314295', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (472, '857272488', 5188.17854084138, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.314295', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (473, '822221695', 31772.047133683, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.314295', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (474, '819638427', 6961.70733373386, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.314295', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (475, '866895965', 37835.1942179841, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.340608', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (476, '861193841', 33302.7162328413, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.340608', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (477, '874977279', 38885.4312106923, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.340608', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (478, '889745877', 32031.4860251069, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.340608', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (479, '820698548', 11187.0816253967, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.340608', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (480, '809296618', 20601.3807706053, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.382666', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (481, '863705831', 17187.6369461462, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.382666', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (482, '811014768', 13320.6968124197, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.382666', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (483, '865854422', 32773.9504816253, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.382666', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (484, '820448483', 35631.939250593, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.382666', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (485, '821667661', 19277.4624635959, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.417628', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (486, '889542390', 1539.79739442008, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.417628', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (487, '835409486', 27142.0499709716, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.417628', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (488, '814346717', 25427.0144982293, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.417628', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (489, '815413004', 1655.22466723976, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.417628', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (490, '818895804', 23084.2852484416, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.444284', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (491, '861204923', 4706.38691402522, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.444284', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (492, '879555072', 12755.6246650751, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.444284', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (493, '855772393', 13603.9249735373, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.444284', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (494, '837201486', 25841.6511751485, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.444284', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (495, '843460808', 12434.2816017529, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.444284', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (496, '877968358', 5099.43961150509, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.444284', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (497, '874838097', 30328.1267294013, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.444284', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (498, '805560200', 29033.3314465114, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.444284', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (499, '881593144', 6204.39511307046, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.492359', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (500, '842206021', 8950.92068438242, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.492359', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (501, '809539154', 31725.7439274942, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.521041', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (502, '881462374', 2905.00128621927, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.521041', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (503, '829262952', 32185.5017855649, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.521041', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (504, '824601665', 30892.0368587776, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.521041', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (505, '862526144', 4017.54165960569, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.521041', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (506, '839613883', 21778.6225906165, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.521041', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (507, '888715789', 39388.8531255317, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.521041', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (508, '832828782', 25422.005205537, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.521041', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (509, '816554836', 33729.8040250766, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.521041', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (510, '856843871', 39311.9239317937, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.551991', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (511, '885789588', 4242.89888806555, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.551991', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (512, '884813924', 26000.6623585855, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.551991', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (513, '890898121', 8787.30588955755, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.577496', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (514, '800950247', 14470.6020514322, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.577496', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (515, '837591913', 24949.7244964195, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.577496', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (516, '860767128', 32734.9771687013, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.577496', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (517, '838144492', 37188.0091531143, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.577496', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (518, '855490226', 22389.9630302087, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.602999', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (519, '850967552', 34244.5348487145, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.602999', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (520, '840025249', 21797.9068568257, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.602999', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (521, '836815368', 23780.0474487813, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.602999', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (522, '819212825', 25370.0831201814, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.602999', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (523, '868485136', 13732.7375761193, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.63195', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (524, '895904953', 13984.0005392985, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.63195', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (525, '879844455', 35998.0122650663, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.63195', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (526, '843762828', 32243.8791589408, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.655793', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (527, '816273549', 36828.5969683722, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.655793', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (528, '841533906', 2614.47952731851, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.655793', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (529, '888102873', 36775.5165367443, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.655793', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (530, '834489694', 28500.9401004276, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.655793', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (531, '839054362', 25622.2662342039, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.655793', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (532, '802825378', 17606.2250015975, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-26 08:41:16.687799', 2, 2023);


--
-- Data for Name: virksomhet; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet VALUES (1, '987654321', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo', '{"Osloveien 1"}', 'AKTIV', '2023-01-01', 987654322, '2023-09-26 08:41:10.124708', '2023-09-26 08:41:10.124708');
INSERT INTO public.virksomhet VALUES (2, '123456789', 'Norge', 'NO', '1234', 'POSTSTED', 'BERGEN', '4601', 'Virksomhet Bærgen', '{"Bergenveien 1"}', 'AKTIV', '2023-01-01', 123456790, '2023-09-26 08:41:10.158816', '2023-09-26 08:41:10.158816');
INSERT INTO public.virksomhet VALUES (3, '555555555', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo Flere Adresser', '{"c/o Oslo Tigersen","Osloveien 1","0977 Oslo"}', 'AKTIV', '2023-01-01', 555555556, '2023-09-26 08:41:10.167842', '2023-09-26 08:41:10.167842');
INSERT INTO public.virksomhet VALUES (4, '666666666', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo Mangler Adresser', '{}', 'AKTIV', '2023-01-01', 666666667, '2023-09-26 08:41:10.176784', '2023-09-26 08:41:10.176784');
INSERT INTO public.virksomhet VALUES (5, '875088086', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875088086', '{adresse}', 'AKTIV', '2023-01-01', 875088087, '2023-09-26 08:41:10.231046', '2023-09-26 08:41:10.231046');
INSERT INTO public.virksomhet VALUES (6, '857241581', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857241581', '{adresse}', 'AKTIV', '2023-01-01', 857241582, '2023-09-26 08:41:10.238312', '2023-09-26 08:41:10.238312');
INSERT INTO public.virksomhet VALUES (7, '867365117', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867365117', '{adresse}', 'AKTIV', '2023-01-01', 867365118, '2023-09-26 08:41:10.244912', '2023-09-26 08:41:10.244912');
INSERT INTO public.virksomhet VALUES (8, '881114246', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881114246', '{adresse}', 'AKTIV', '2023-01-01', 881114247, '2023-09-26 08:41:10.253425', '2023-09-26 08:41:10.253425');
INSERT INTO public.virksomhet VALUES (9, '891771817', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891771817', '{adresse}', 'AKTIV', '2023-01-01', 891771818, '2023-09-26 08:41:10.258365', '2023-09-26 08:41:10.258365');
INSERT INTO public.virksomhet VALUES (10, '898525058', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898525058', '{adresse}', 'AKTIV', '2023-01-01', 898525059, '2023-09-26 08:41:10.264015', '2023-09-26 08:41:10.264015');
INSERT INTO public.virksomhet VALUES (11, '835220383', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835220383', '{adresse}', 'AKTIV', '2023-01-01', 835220384, '2023-09-26 08:41:10.27052', '2023-09-26 08:41:10.27052');
INSERT INTO public.virksomhet VALUES (12, '878746520', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878746520', '{adresse}', 'AKTIV', '2023-01-01', 878746521, '2023-09-26 08:41:10.27779', '2023-09-26 08:41:10.27779');
INSERT INTO public.virksomhet VALUES (13, '883329944', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883329944', '{adresse}', 'AKTIV', '2023-01-01', 883329945, '2023-09-26 08:41:10.283485', '2023-09-26 08:41:10.283485');
INSERT INTO public.virksomhet VALUES (14, '852437928', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852437928', '{adresse}', 'AKTIV', '2023-01-01', 852437929, '2023-09-26 08:41:10.287596', '2023-09-26 08:41:10.287596');
INSERT INTO public.virksomhet VALUES (15, '895309223', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895309223', '{adresse}', 'AKTIV', '2023-01-01', 895309224, '2023-09-26 08:41:10.296942', '2023-09-26 08:41:10.296942');
INSERT INTO public.virksomhet VALUES (16, '835031049', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835031049', '{adresse}', 'AKTIV', '2023-01-01', 835031050, '2023-09-26 08:41:10.304508', '2023-09-26 08:41:10.304508');
INSERT INTO public.virksomhet VALUES (17, '873220998', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873220998', '{adresse}', 'AKTIV', '2023-01-01', 873220999, '2023-09-26 08:41:10.317222', '2023-09-26 08:41:10.317222');
INSERT INTO public.virksomhet VALUES (18, '835774114', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835774114', '{adresse}', 'AKTIV', '2023-01-01', 835774115, '2023-09-26 08:41:10.322019', '2023-09-26 08:41:10.322019');
INSERT INTO public.virksomhet VALUES (19, '862164924', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862164924', '{adresse}', 'AKTIV', '2023-01-01', 862164925, '2023-09-26 08:41:10.326801', '2023-09-26 08:41:10.326801');
INSERT INTO public.virksomhet VALUES (20, '896270090', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896270090', '{adresse}', 'AKTIV', '2023-01-01', 896270091, '2023-09-26 08:41:10.332598', '2023-09-26 08:41:10.332598');
INSERT INTO public.virksomhet VALUES (21, '897255882', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897255882', '{adresse}', 'AKTIV', '2023-01-01', 897255883, '2023-09-26 08:41:10.337456', '2023-09-26 08:41:10.337456');
INSERT INTO public.virksomhet VALUES (22, '848363736', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848363736', '{adresse}', 'AKTIV', '2023-01-01', 848363737, '2023-09-26 08:41:10.347383', '2023-09-26 08:41:10.347383');
INSERT INTO public.virksomhet VALUES (23, '882275284', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882275284', '{adresse}', 'AKTIV', '2023-01-01', 882275285, '2023-09-26 08:41:10.352114', '2023-09-26 08:41:10.352114');
INSERT INTO public.virksomhet VALUES (24, '834436066', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834436066', '{adresse}', 'AKTIV', '2023-01-01', 834436067, '2023-09-26 08:41:10.361282', '2023-09-26 08:41:10.361282');
INSERT INTO public.virksomhet VALUES (25, '829040586', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829040586', '{adresse}', 'AKTIV', '2023-01-01', 829040587, '2023-09-26 08:41:10.36664', '2023-09-26 08:41:10.36664');
INSERT INTO public.virksomhet VALUES (26, '816209538', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816209538', '{adresse}', 'AKTIV', '2023-01-01', 816209539, '2023-09-26 08:41:10.371119', '2023-09-26 08:41:10.371119');
INSERT INTO public.virksomhet VALUES (27, '831787072', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831787072', '{adresse}', 'AKTIV', '2023-01-01', 831787073, '2023-09-26 08:41:10.37515', '2023-09-26 08:41:10.37515');
INSERT INTO public.virksomhet VALUES (28, '877257237', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877257237', '{adresse}', 'AKTIV', '2023-01-01', 877257238, '2023-09-26 08:41:10.383575', '2023-09-26 08:41:10.383575');
INSERT INTO public.virksomhet VALUES (29, '889355886', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889355886', '{adresse}', 'AKTIV', '2023-01-01', 889355887, '2023-09-26 08:41:10.390654', '2023-09-26 08:41:10.390654');
INSERT INTO public.virksomhet VALUES (30, '895626556', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895626556', '{adresse}', 'AKTIV', '2023-01-01', 895626557, '2023-09-26 08:41:10.398716', '2023-09-26 08:41:10.398716');
INSERT INTO public.virksomhet VALUES (31, '821709008', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821709008', '{adresse}', 'AKTIV', '2023-01-01', 821709009, '2023-09-26 08:41:10.406156', '2023-09-26 08:41:10.406156');
INSERT INTO public.virksomhet VALUES (32, '804237955', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804237955', '{adresse}', 'AKTIV', '2023-01-01', 804237956, '2023-09-26 08:41:10.428795', '2023-09-26 08:41:10.428795');
INSERT INTO public.virksomhet VALUES (33, '872367868', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872367868', '{adresse}', 'AKTIV', '2023-01-01', 872367869, '2023-09-26 08:41:10.491986', '2023-09-26 08:41:10.491986');
INSERT INTO public.virksomhet VALUES (34, '803742463', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803742463', '{adresse}', 'AKTIV', '2023-01-01', 803742464, '2023-09-26 08:41:10.503108', '2023-09-26 08:41:10.503108');
INSERT INTO public.virksomhet VALUES (35, '892845353', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892845353', '{adresse}', 'AKTIV', '2023-01-01', 892845354, '2023-09-26 08:41:10.511008', '2023-09-26 08:41:10.511008');
INSERT INTO public.virksomhet VALUES (36, '861622901', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861622901', '{adresse}', 'AKTIV', '2023-01-01', 861622902, '2023-09-26 08:41:10.521937', '2023-09-26 08:41:10.521937');
INSERT INTO public.virksomhet VALUES (37, '881875590', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881875590', '{adresse}', 'AKTIV', '2023-01-01', 881875591, '2023-09-26 08:41:10.532336', '2023-09-26 08:41:10.532336');
INSERT INTO public.virksomhet VALUES (38, '801835452', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801835452', '{adresse}', 'AKTIV', '2023-01-01', 801835453, '2023-09-26 08:41:10.556474', '2023-09-26 08:41:10.556474');
INSERT INTO public.virksomhet VALUES (39, '875258326', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875258326', '{adresse}', 'AKTIV', '2023-01-01', 875258327, '2023-09-26 08:41:10.564171', '2023-09-26 08:41:10.564171');
INSERT INTO public.virksomhet VALUES (40, '845784470', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845784470', '{adresse}', 'AKTIV', '2023-01-01', 845784471, '2023-09-26 08:41:10.574346', '2023-09-26 08:41:10.574346');
INSERT INTO public.virksomhet VALUES (41, '859440331', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859440331', '{adresse}', 'AKTIV', '2023-01-01', 859440332, '2023-09-26 08:41:10.580716', '2023-09-26 08:41:10.580716');
INSERT INTO public.virksomhet VALUES (42, '819479903', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819479903', '{adresse}', 'AKTIV', '2023-01-01', 819479904, '2023-09-26 08:41:10.589121', '2023-09-26 08:41:10.589121');
INSERT INTO public.virksomhet VALUES (43, '890551762', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890551762', '{adresse}', 'AKTIV', '2023-01-01', 890551763, '2023-09-26 08:41:10.593725', '2023-09-26 08:41:10.593725');
INSERT INTO public.virksomhet VALUES (44, '861778194', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861778194', '{adresse}', 'AKTIV', '2023-01-01', 861778195, '2023-09-26 08:41:10.601769', '2023-09-26 08:41:10.601769');
INSERT INTO public.virksomhet VALUES (45, '805339854', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805339854', '{adresse}', 'AKTIV', '2023-01-01', 805339855, '2023-09-26 08:41:10.606703', '2023-09-26 08:41:10.606703');
INSERT INTO public.virksomhet VALUES (46, '815390484', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815390484', '{adresse}', 'AKTIV', '2023-01-01', 815390485, '2023-09-26 08:41:10.616101', '2023-09-26 08:41:10.616101');
INSERT INTO public.virksomhet VALUES (47, '850462341', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850462341', '{adresse}', 'AKTIV', '2023-01-01', 850462342, '2023-09-26 08:41:10.622715', '2023-09-26 08:41:10.622715');
INSERT INTO public.virksomhet VALUES (48, '874452140', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874452140', '{adresse}', 'AKTIV', '2023-01-01', 874452141, '2023-09-26 08:41:10.629613', '2023-09-26 08:41:10.629613');
INSERT INTO public.virksomhet VALUES (49, '811851790', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811851790', '{adresse}', 'AKTIV', '2023-01-01', 811851791, '2023-09-26 08:41:10.634044', '2023-09-26 08:41:10.634044');
INSERT INTO public.virksomhet VALUES (50, '873515591', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873515591', '{adresse}', 'AKTIV', '2023-01-01', 873515592, '2023-09-26 08:41:10.638112', '2023-09-26 08:41:10.638112');
INSERT INTO public.virksomhet VALUES (51, '836279558', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836279558', '{adresse}', 'AKTIV', '2023-01-01', 836279559, '2023-09-26 08:41:10.64548', '2023-09-26 08:41:10.64548');
INSERT INTO public.virksomhet VALUES (52, '809727399', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809727399', '{adresse}', 'AKTIV', '2023-01-01', 809727400, '2023-09-26 08:41:10.653123', '2023-09-26 08:41:10.653123');
INSERT INTO public.virksomhet VALUES (53, '824470634', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824470634', '{adresse}', 'AKTIV', '2023-01-01', 824470635, '2023-09-26 08:41:10.656361', '2023-09-26 08:41:10.656361');
INSERT INTO public.virksomhet VALUES (54, '836516461', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836516461', '{adresse}', 'AKTIV', '2023-01-01', 836516462, '2023-09-26 08:41:10.664534', '2023-09-26 08:41:10.664534');
INSERT INTO public.virksomhet VALUES (55, '837159750', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837159750', '{adresse}', 'AKTIV', '2023-01-01', 837159751, '2023-09-26 08:41:10.668234', '2023-09-26 08:41:10.668234');
INSERT INTO public.virksomhet VALUES (56, '811866664', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811866664', '{adresse}', 'AKTIV', '2023-01-01', 811866665, '2023-09-26 08:41:10.678379', '2023-09-26 08:41:10.678379');
INSERT INTO public.virksomhet VALUES (57, '851277727', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851277727', '{adresse}', 'AKTIV', '2023-01-01', 851277728, '2023-09-26 08:41:10.683632', '2023-09-26 08:41:10.683632');
INSERT INTO public.virksomhet VALUES (58, '842226671', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842226671', '{adresse}', 'AKTIV', '2023-01-01', 842226672, '2023-09-26 08:41:10.692064', '2023-09-26 08:41:10.692064');
INSERT INTO public.virksomhet VALUES (59, '821968574', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821968574', '{adresse}', 'AKTIV', '2023-01-01', 821968575, '2023-09-26 08:41:10.695855', '2023-09-26 08:41:10.695855');
INSERT INTO public.virksomhet VALUES (60, '824580761', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824580761', '{adresse}', 'AKTIV', '2023-01-01', 824580762, '2023-09-26 08:41:10.700332', '2023-09-26 08:41:10.700332');
INSERT INTO public.virksomhet VALUES (61, '889367910', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889367910', '{adresse}', 'AKTIV', '2023-01-01', 889367911, '2023-09-26 08:41:10.703875', '2023-09-26 08:41:10.703875');
INSERT INTO public.virksomhet VALUES (62, '840237611', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840237611', '{adresse}', 'AKTIV', '2023-01-01', 840237612, '2023-09-26 08:41:10.708181', '2023-09-26 08:41:10.708181');
INSERT INTO public.virksomhet VALUES (63, '800908366', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800908366', '{adresse}', 'AKTIV', '2023-01-01', 800908367, '2023-09-26 08:41:10.717703', '2023-09-26 08:41:10.717703');
INSERT INTO public.virksomhet VALUES (64, '822930437', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822930437', '{adresse}', 'AKTIV', '2023-01-01', 822930438, '2023-09-26 08:41:10.725793', '2023-09-26 08:41:10.725793');
INSERT INTO public.virksomhet VALUES (65, '814250450', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814250450', '{adresse}', 'AKTIV', '2023-01-01', 814250451, '2023-09-26 08:41:10.730261', '2023-09-26 08:41:10.730261');
INSERT INTO public.virksomhet VALUES (66, '808744432', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808744432', '{adresse}', 'AKTIV', '2023-01-01', 808744433, '2023-09-26 08:41:10.7361', '2023-09-26 08:41:10.7361');
INSERT INTO public.virksomhet VALUES (67, '857826950', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857826950', '{adresse}', 'AKTIV', '2023-01-01', 857826951, '2023-09-26 08:41:10.741446', '2023-09-26 08:41:10.741446');
INSERT INTO public.virksomhet VALUES (68, '870623580', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870623580', '{adresse}', 'AKTIV', '2023-01-01', 870623581, '2023-09-26 08:41:10.749685', '2023-09-26 08:41:10.749685');
INSERT INTO public.virksomhet VALUES (69, '810733872', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810733872', '{adresse}', 'AKTIV', '2023-01-01', 810733873, '2023-09-26 08:41:10.755198', '2023-09-26 08:41:10.755198');
INSERT INTO public.virksomhet VALUES (70, '827935929', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827935929', '{adresse}', 'AKTIV', '2023-01-01', 827935930, '2023-09-26 08:41:10.760182', '2023-09-26 08:41:10.760182');
INSERT INTO public.virksomhet VALUES (71, '863730729', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863730729', '{adresse}', 'AKTIV', '2023-01-01', 863730730, '2023-09-26 08:41:10.765931', '2023-09-26 08:41:10.765931');
INSERT INTO public.virksomhet VALUES (72, '857184109', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857184109', '{adresse}', 'AKTIV', '2023-01-01', 857184110, '2023-09-26 08:41:10.77391', '2023-09-26 08:41:10.77391');
INSERT INTO public.virksomhet VALUES (73, '852734859', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852734859', '{adresse}', 'AKTIV', '2023-01-01', 852734860, '2023-09-26 08:41:10.783489', '2023-09-26 08:41:10.783489');
INSERT INTO public.virksomhet VALUES (74, '853594439', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853594439', '{adresse}', 'AKTIV', '2023-01-01', 853594440, '2023-09-26 08:41:10.79303', '2023-09-26 08:41:10.79303');
INSERT INTO public.virksomhet VALUES (75, '818803358', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818803358', '{adresse}', 'AKTIV', '2023-01-01', 818803359, '2023-09-26 08:41:10.801438', '2023-09-26 08:41:10.801438');
INSERT INTO public.virksomhet VALUES (76, '853653063', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853653063', '{adresse}', 'AKTIV', '2023-01-01', 853653064, '2023-09-26 08:41:10.815764', '2023-09-26 08:41:10.815764');
INSERT INTO public.virksomhet VALUES (77, '841238334', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841238334', '{adresse}', 'AKTIV', '2023-01-01', 841238335, '2023-09-26 08:41:10.824708', '2023-09-26 08:41:10.824708');
INSERT INTO public.virksomhet VALUES (78, '813169303', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813169303', '{adresse}', 'AKTIV', '2023-01-01', 813169304, '2023-09-26 08:41:10.832587', '2023-09-26 08:41:10.832587');
INSERT INTO public.virksomhet VALUES (79, '839551215', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839551215', '{adresse}', 'AKTIV', '2023-01-01', 839551216, '2023-09-26 08:41:10.851072', '2023-09-26 08:41:10.851072');
INSERT INTO public.virksomhet VALUES (80, '880193321', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880193321', '{adresse}', 'AKTIV', '2023-01-01', 880193322, '2023-09-26 08:41:10.856088', '2023-09-26 08:41:10.856088');
INSERT INTO public.virksomhet VALUES (81, '833735069', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833735069', '{adresse}', 'AKTIV', '2023-01-01', 833735070, '2023-09-26 08:41:10.864314', '2023-09-26 08:41:10.864314');
INSERT INTO public.virksomhet VALUES (82, '859513692', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859513692', '{adresse}', 'AKTIV', '2023-01-01', 859513693, '2023-09-26 08:41:10.871573', '2023-09-26 08:41:10.871573');
INSERT INTO public.virksomhet VALUES (83, '842466076', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842466076', '{adresse}', 'AKTIV', '2023-01-01', 842466077, '2023-09-26 08:41:10.877324', '2023-09-26 08:41:10.877324');
INSERT INTO public.virksomhet VALUES (84, '894329113', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894329113', '{adresse}', 'AKTIV', '2023-01-01', 894329114, '2023-09-26 08:41:10.883045', '2023-09-26 08:41:10.883045');
INSERT INTO public.virksomhet VALUES (85, '878105030', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878105030', '{adresse}', 'AKTIV', '2023-01-01', 878105031, '2023-09-26 08:41:10.8886', '2023-09-26 08:41:10.8886');
INSERT INTO public.virksomhet VALUES (86, '801615123', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801615123', '{adresse}', 'AKTIV', '2023-01-01', 801615124, '2023-09-26 08:41:10.896021', '2023-09-26 08:41:10.896021');
INSERT INTO public.virksomhet VALUES (87, '899812147', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899812147', '{adresse}', 'AKTIV', '2023-01-01', 899812148, '2023-09-26 08:41:10.915193', '2023-09-26 08:41:10.915193');
INSERT INTO public.virksomhet VALUES (88, '867355472', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867355472', '{adresse}', 'AKTIV', '2023-01-01', 867355473, '2023-09-26 08:41:10.925044', '2023-09-26 08:41:10.925044');
INSERT INTO public.virksomhet VALUES (89, '862566596', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862566596', '{adresse}', 'AKTIV', '2023-01-01', 862566597, '2023-09-26 08:41:10.939769', '2023-09-26 08:41:10.939769');
INSERT INTO public.virksomhet VALUES (90, '848711875', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848711875', '{adresse}', 'AKTIV', '2023-01-01', 848711876, '2023-09-26 08:41:10.951567', '2023-09-26 08:41:10.951567');
INSERT INTO public.virksomhet VALUES (91, '899871018', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899871018', '{adresse}', 'AKTIV', '2023-01-01', 899871019, '2023-09-26 08:41:10.955939', '2023-09-26 08:41:10.955939');
INSERT INTO public.virksomhet VALUES (92, '834231007', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834231007', '{adresse}', 'AKTIV', '2023-01-01', 834231008, '2023-09-26 08:41:10.961641', '2023-09-26 08:41:10.961641');
INSERT INTO public.virksomhet VALUES (93, '844851816', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844851816', '{adresse}', 'AKTIV', '2023-01-01', 844851817, '2023-09-26 08:41:10.972814', '2023-09-26 08:41:10.972814');
INSERT INTO public.virksomhet VALUES (94, '883686536', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883686536', '{adresse}', 'AKTIV', '2023-01-01', 883686537, '2023-09-26 08:41:10.985886', '2023-09-26 08:41:10.985886');
INSERT INTO public.virksomhet VALUES (95, '846917560', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846917560', '{adresse}', 'AKTIV', '2023-01-01', 846917561, '2023-09-26 08:41:10.994552', '2023-09-26 08:41:10.994552');
INSERT INTO public.virksomhet VALUES (96, '819849863', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819849863', '{adresse}', 'AKTIV', '2023-01-01', 819849864, '2023-09-26 08:41:11.001481', '2023-09-26 08:41:11.001481');
INSERT INTO public.virksomhet VALUES (97, '802805958', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802805958', '{adresse}', 'AKTIV', '2023-01-01', 802805959, '2023-09-26 08:41:11.007151', '2023-09-26 08:41:11.007151');
INSERT INTO public.virksomhet VALUES (98, '893385116', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893385116', '{adresse}', 'AKTIV', '2023-01-01', 893385117, '2023-09-26 08:41:11.017381', '2023-09-26 08:41:11.017381');
INSERT INTO public.virksomhet VALUES (99, '821342624', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821342624', '{adresse}', 'AKTIV', '2023-01-01', 821342625, '2023-09-26 08:41:11.02332', '2023-09-26 08:41:11.02332');
INSERT INTO public.virksomhet VALUES (100, '807688973', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807688973', '{adresse}', 'AKTIV', '2023-01-01', 807688974, '2023-09-26 08:41:11.031748', '2023-09-26 08:41:11.031748');
INSERT INTO public.virksomhet VALUES (101, '807482958', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807482958', '{adresse}', 'AKTIV', '2023-01-01', 807482959, '2023-09-26 08:41:11.038863', '2023-09-26 08:41:11.038863');
INSERT INTO public.virksomhet VALUES (102, '840247819', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840247819', '{adresse}', 'AKTIV', '2023-01-01', 840247820, '2023-09-26 08:41:11.044421', '2023-09-26 08:41:11.044421');
INSERT INTO public.virksomhet VALUES (103, '833662191', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833662191', '{adresse}', 'AKTIV', '2023-01-01', 833662192, '2023-09-26 08:41:11.050073', '2023-09-26 08:41:11.050073');
INSERT INTO public.virksomhet VALUES (104, '857600929', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857600929', '{adresse}', 'AKTIV', '2023-01-01', 857600930, '2023-09-26 08:41:11.059041', '2023-09-26 08:41:11.059041');
INSERT INTO public.virksomhet VALUES (105, '823595968', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823595968', '{adresse}', 'AKTIV', '2023-01-01', 823595969, '2023-09-26 08:41:11.065903', '2023-09-26 08:41:11.065903');
INSERT INTO public.virksomhet VALUES (106, '828176199', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828176199', '{adresse}', 'AKTIV', '2023-01-01', 828176200, '2023-09-26 08:41:11.070915', '2023-09-26 08:41:11.070915');
INSERT INTO public.virksomhet VALUES (107, '889592815', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889592815', '{adresse}', 'AKTIV', '2023-01-01', 889592816, '2023-09-26 08:41:11.073913', '2023-09-26 08:41:11.073913');
INSERT INTO public.virksomhet VALUES (108, '876326312', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876326312', '{adresse}', 'AKTIV', '2023-01-01', 876326313, '2023-09-26 08:41:11.078504', '2023-09-26 08:41:11.078504');
INSERT INTO public.virksomhet VALUES (109, '895656026', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895656026', '{adresse}', 'AKTIV', '2023-01-01', 895656027, '2023-09-26 08:41:11.086005', '2023-09-26 08:41:11.086005');
INSERT INTO public.virksomhet VALUES (110, '866550041', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866550041', '{adresse}', 'AKTIV', '2023-01-01', 866550042, '2023-09-26 08:41:11.0924', '2023-09-26 08:41:11.0924');
INSERT INTO public.virksomhet VALUES (111, '807148470', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807148470', '{adresse}', 'AKTIV', '2023-01-01', 807148471, '2023-09-26 08:41:11.101047', '2023-09-26 08:41:11.101047');
INSERT INTO public.virksomhet VALUES (112, '873480135', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873480135', '{adresse}', 'AKTIV', '2023-01-01', 873480136, '2023-09-26 08:41:11.10606', '2023-09-26 08:41:11.10606');
INSERT INTO public.virksomhet VALUES (113, '834244928', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834244928', '{adresse}', 'AKTIV', '2023-01-01', 834244929, '2023-09-26 08:41:11.115954', '2023-09-26 08:41:11.115954');
INSERT INTO public.virksomhet VALUES (114, '867599989', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867599989', '{adresse}', 'AKTIV', '2023-01-01', 867599990, '2023-09-26 08:41:11.123322', '2023-09-26 08:41:11.123322');
INSERT INTO public.virksomhet VALUES (115, '800799655', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800799655', '{adresse}', 'AKTIV', '2023-01-01', 800799656, '2023-09-26 08:41:11.131317', '2023-09-26 08:41:11.131317');
INSERT INTO public.virksomhet VALUES (116, '891901027', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891901027', '{adresse}', 'AKTIV', '2023-01-01', 891901028, '2023-09-26 08:41:11.137163', '2023-09-26 08:41:11.137163');
INSERT INTO public.virksomhet VALUES (117, '897759899', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897759899', '{adresse}', 'AKTIV', '2023-01-01', 897759900, '2023-09-26 08:41:11.143276', '2023-09-26 08:41:11.143276');
INSERT INTO public.virksomhet VALUES (118, '828451410', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828451410', '{adresse}', 'AKTIV', '2023-01-01', 828451411, '2023-09-26 08:41:11.150217', '2023-09-26 08:41:11.150217');
INSERT INTO public.virksomhet VALUES (119, '843216309', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843216309', '{adresse}', 'AKTIV', '2023-01-01', 843216310, '2023-09-26 08:41:11.155368', '2023-09-26 08:41:11.155368');
INSERT INTO public.virksomhet VALUES (120, '840322470', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840322470', '{adresse}', 'AKTIV', '2023-01-01', 840322471, '2023-09-26 08:41:11.160552', '2023-09-26 08:41:11.160552');
INSERT INTO public.virksomhet VALUES (121, '834850124', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834850124', '{adresse}', 'AKTIV', '2023-01-01', 834850125, '2023-09-26 08:41:11.169824', '2023-09-26 08:41:11.169824');
INSERT INTO public.virksomhet VALUES (122, '868514204', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868514204', '{adresse}', 'AKTIV', '2023-01-01', 868514205, '2023-09-26 08:41:11.178481', '2023-09-26 08:41:11.178481');
INSERT INTO public.virksomhet VALUES (123, '817793850', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817793850', '{adresse}', 'AKTIV', '2023-01-01', 817793851, '2023-09-26 08:41:11.185801', '2023-09-26 08:41:11.185801');
INSERT INTO public.virksomhet VALUES (124, '812101864', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812101864', '{adresse}', 'AKTIV', '2023-01-01', 812101865, '2023-09-26 08:41:11.193021', '2023-09-26 08:41:11.193021');
INSERT INTO public.virksomhet VALUES (125, '895076821', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895076821', '{adresse}', 'AKTIV', '2023-01-01', 895076822, '2023-09-26 08:41:11.199447', '2023-09-26 08:41:11.199447');
INSERT INTO public.virksomhet VALUES (126, '827110995', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827110995', '{adresse}', 'AKTIV', '2023-01-01', 827110996, '2023-09-26 08:41:11.207047', '2023-09-26 08:41:11.207047');
INSERT INTO public.virksomhet VALUES (127, '887902366', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887902366', '{adresse}', 'AKTIV', '2023-01-01', 887902367, '2023-09-26 08:41:11.225084', '2023-09-26 08:41:11.225084');
INSERT INTO public.virksomhet VALUES (128, '834720617', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834720617', '{adresse}', 'AKTIV', '2023-01-01', 834720618, '2023-09-26 08:41:11.233925', '2023-09-26 08:41:11.233925');
INSERT INTO public.virksomhet VALUES (129, '832815951', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832815951', '{adresse}', 'AKTIV', '2023-01-01', 832815952, '2023-09-26 08:41:11.241183', '2023-09-26 08:41:11.241183');
INSERT INTO public.virksomhet VALUES (130, '813087477', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813087477', '{adresse}', 'AKTIV', '2023-01-01', 813087478, '2023-09-26 08:41:11.24669', '2023-09-26 08:41:11.24669');
INSERT INTO public.virksomhet VALUES (131, '804157028', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804157028', '{adresse}', 'AKTIV', '2023-01-01', 804157029, '2023-09-26 08:41:11.262624', '2023-09-26 08:41:11.262624');
INSERT INTO public.virksomhet VALUES (132, '854866731', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854866731', '{adresse}', 'AKTIV', '2023-01-01', 854866732, '2023-09-26 08:41:11.266833', '2023-09-26 08:41:11.266833');
INSERT INTO public.virksomhet VALUES (133, '853500402', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853500402', '{adresse}', 'AKTIV', '2023-01-01', 853500403, '2023-09-26 08:41:11.27053', '2023-09-26 08:41:11.27053');
INSERT INTO public.virksomhet VALUES (134, '893413801', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893413801', '{adresse}', 'AKTIV', '2023-01-01', 893413802, '2023-09-26 08:41:11.288759', '2023-09-26 08:41:11.288759');
INSERT INTO public.virksomhet VALUES (135, '872692522', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872692522', '{adresse}', 'AKTIV', '2023-01-01', 872692523, '2023-09-26 08:41:11.294052', '2023-09-26 08:41:11.294052');
INSERT INTO public.virksomhet VALUES (136, '882405148', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882405148', '{adresse}', 'AKTIV', '2023-01-01', 882405149, '2023-09-26 08:41:11.299982', '2023-09-26 08:41:11.299982');
INSERT INTO public.virksomhet VALUES (137, '830563991', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830563991', '{adresse}', 'AKTIV', '2023-01-01', 830563992, '2023-09-26 08:41:11.305889', '2023-09-26 08:41:11.305889');
INSERT INTO public.virksomhet VALUES (138, '827455980', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827455980', '{adresse}', 'AKTIV', '2023-01-01', 827455981, '2023-09-26 08:41:11.309868', '2023-09-26 08:41:11.309868');
INSERT INTO public.virksomhet VALUES (139, '856160971', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856160971', '{adresse}', 'AKTIV', '2023-01-01', 856160972, '2023-09-26 08:41:11.313713', '2023-09-26 08:41:11.313713');
INSERT INTO public.virksomhet VALUES (140, '843873189', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843873189', '{adresse}', 'AKTIV', '2023-01-01', 843873190, '2023-09-26 08:41:11.3179', '2023-09-26 08:41:11.3179');
INSERT INTO public.virksomhet VALUES (141, '834748117', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834748117', '{adresse}', 'AKTIV', '2023-01-01', 834748118, '2023-09-26 08:41:11.322764', '2023-09-26 08:41:11.322764');
INSERT INTO public.virksomhet VALUES (142, '882432753', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882432753', '{adresse}', 'AKTIV', '2023-01-01', 882432754, '2023-09-26 08:41:11.32811', '2023-09-26 08:41:11.32811');
INSERT INTO public.virksomhet VALUES (143, '881809662', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881809662', '{adresse}', 'AKTIV', '2023-01-01', 881809663, '2023-09-26 08:41:11.33264', '2023-09-26 08:41:11.33264');
INSERT INTO public.virksomhet VALUES (144, '858896992', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858896992', '{adresse}', 'AKTIV', '2023-01-01', 858896993, '2023-09-26 08:41:11.351259', '2023-09-26 08:41:11.351259');
INSERT INTO public.virksomhet VALUES (145, '889927062', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889927062', '{adresse}', 'AKTIV', '2023-01-01', 889927063, '2023-09-26 08:41:11.353781', '2023-09-26 08:41:11.353781');
INSERT INTO public.virksomhet VALUES (146, '898258524', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898258524', '{adresse}', 'AKTIV', '2023-01-01', 898258525, '2023-09-26 08:41:11.357992', '2023-09-26 08:41:11.357992');
INSERT INTO public.virksomhet VALUES (147, '889622954', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889622954', '{adresse}', 'AKTIV', '2023-01-01', 889622955, '2023-09-26 08:41:11.362341', '2023-09-26 08:41:11.362341');
INSERT INTO public.virksomhet VALUES (148, '853241627', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853241627', '{adresse}', 'AKTIV', '2023-01-01', 853241628, '2023-09-26 08:41:11.368158', '2023-09-26 08:41:11.368158');
INSERT INTO public.virksomhet VALUES (149, '870014549', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870014549', '{adresse}', 'AKTIV', '2023-01-01', 870014550, '2023-09-26 08:41:11.37273', '2023-09-26 08:41:11.37273');
INSERT INTO public.virksomhet VALUES (150, '832059430', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832059430', '{adresse}', 'AKTIV', '2023-01-01', 832059431, '2023-09-26 08:41:11.378546', '2023-09-26 08:41:11.378546');
INSERT INTO public.virksomhet VALUES (151, '831960181', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831960181', '{adresse}', 'AKTIV', '2023-01-01', 831960182, '2023-09-26 08:41:11.383738', '2023-09-26 08:41:11.383738');
INSERT INTO public.virksomhet VALUES (152, '860954143', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860954143', '{adresse}', 'AKTIV', '2023-01-01', 860954144, '2023-09-26 08:41:11.387365', '2023-09-26 08:41:11.387365');
INSERT INTO public.virksomhet VALUES (153, '892104686', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892104686', '{adresse}', 'AKTIV', '2023-01-01', 892104687, '2023-09-26 08:41:11.393049', '2023-09-26 08:41:11.393049');
INSERT INTO public.virksomhet VALUES (154, '842058201', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842058201', '{adresse}', 'AKTIV', '2023-01-01', 842058202, '2023-09-26 08:41:11.40002', '2023-09-26 08:41:11.40002');
INSERT INTO public.virksomhet VALUES (155, '859203352', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859203352', '{adresse}', 'AKTIV', '2023-01-01', 859203353, '2023-09-26 08:41:11.40299', '2023-09-26 08:41:11.40299');
INSERT INTO public.virksomhet VALUES (156, '843485965', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843485965', '{adresse}', 'AKTIV', '2023-01-01', 843485966, '2023-09-26 08:41:11.40757', '2023-09-26 08:41:11.40757');
INSERT INTO public.virksomhet VALUES (157, '853657247', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853657247', '{adresse}', 'AKTIV', '2023-01-01', 853657248, '2023-09-26 08:41:11.41227', '2023-09-26 08:41:11.41227');
INSERT INTO public.virksomhet VALUES (158, '824447452', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824447452', '{adresse}', 'AKTIV', '2023-01-01', 824447453, '2023-09-26 08:41:11.416153', '2023-09-26 08:41:11.416153');
INSERT INTO public.virksomhet VALUES (159, '840050834', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840050834', '{adresse}', 'AKTIV', '2023-01-01', 840050835, '2023-09-26 08:41:11.419609', '2023-09-26 08:41:11.419609');
INSERT INTO public.virksomhet VALUES (160, '843326004', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843326004', '{adresse}', 'AKTIV', '2023-01-01', 843326005, '2023-09-26 08:41:11.422728', '2023-09-26 08:41:11.422728');
INSERT INTO public.virksomhet VALUES (161, '860914228', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860914228', '{adresse}', 'AKTIV', '2023-01-01', 860914229, '2023-09-26 08:41:11.429582', '2023-09-26 08:41:11.429582');
INSERT INTO public.virksomhet VALUES (162, '885643447', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885643447', '{adresse}', 'AKTIV', '2023-01-01', 885643448, '2023-09-26 08:41:11.433494', '2023-09-26 08:41:11.433494');
INSERT INTO public.virksomhet VALUES (163, '878852103', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878852103', '{adresse}', 'AKTIV', '2023-01-01', 878852104, '2023-09-26 08:41:11.445116', '2023-09-26 08:41:11.445116');
INSERT INTO public.virksomhet VALUES (164, '819613989', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819613989', '{adresse}', 'AKTIV', '2023-01-01', 819613990, '2023-09-26 08:41:11.450142', '2023-09-26 08:41:11.450142');
INSERT INTO public.virksomhet VALUES (165, '814874744', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814874744', '{adresse}', 'AKTIV', '2023-01-01', 814874745, '2023-09-26 08:41:11.457562', '2023-09-26 08:41:11.457562');
INSERT INTO public.virksomhet VALUES (166, '854547155', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854547155', '{adresse}', 'AKTIV', '2023-01-01', 854547156, '2023-09-26 08:41:11.467815', '2023-09-26 08:41:11.467815');
INSERT INTO public.virksomhet VALUES (167, '813690133', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813690133', '{adresse}', 'AKTIV', '2023-01-01', 813690134, '2023-09-26 08:41:11.473637', '2023-09-26 08:41:11.473637');
INSERT INTO public.virksomhet VALUES (168, '815692568', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815692568', '{adresse}', 'AKTIV', '2023-01-01', 815692569, '2023-09-26 08:41:11.482663', '2023-09-26 08:41:11.482663');
INSERT INTO public.virksomhet VALUES (169, '832104782', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832104782', '{adresse}', 'AKTIV', '2023-01-01', 832104783, '2023-09-26 08:41:11.489007', '2023-09-26 08:41:11.489007');
INSERT INTO public.virksomhet VALUES (170, '819546920', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819546920', '{adresse}', 'AKTIV', '2023-01-01', 819546921, '2023-09-26 08:41:11.500731', '2023-09-26 08:41:11.500731');
INSERT INTO public.virksomhet VALUES (171, '825401573', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825401573', '{adresse}', 'AKTIV', '2023-01-01', 825401574, '2023-09-26 08:41:11.504932', '2023-09-26 08:41:11.504932');
INSERT INTO public.virksomhet VALUES (172, '843866157', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843866157', '{adresse}', 'AKTIV', '2023-01-01', 843866158, '2023-09-26 08:41:11.510419', '2023-09-26 08:41:11.510419');
INSERT INTO public.virksomhet VALUES (173, '805658539', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805658539', '{adresse}', 'AKTIV', '2023-01-01', 805658540, '2023-09-26 08:41:11.523706', '2023-09-26 08:41:11.523706');
INSERT INTO public.virksomhet VALUES (174, '841224892', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841224892', '{adresse}', 'AKTIV', '2023-01-01', 841224893, '2023-09-26 08:41:11.54895', '2023-09-26 08:41:11.54895');
INSERT INTO public.virksomhet VALUES (175, '803022880', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803022880', '{adresse}', 'AKTIV', '2023-01-01', 803022881, '2023-09-26 08:41:11.552018', '2023-09-26 08:41:11.552018');
INSERT INTO public.virksomhet VALUES (176, '896518254', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896518254', '{adresse}', 'AKTIV', '2023-01-01', 896518255, '2023-09-26 08:41:11.555741', '2023-09-26 08:41:11.555741');
INSERT INTO public.virksomhet VALUES (177, '830643030', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830643030', '{adresse}', 'AKTIV', '2023-01-01', 830643031, '2023-09-26 08:41:11.560004', '2023-09-26 08:41:11.560004');
INSERT INTO public.virksomhet VALUES (178, '893338866', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893338866', '{adresse}', 'AKTIV', '2023-01-01', 893338867, '2023-09-26 08:41:11.564408', '2023-09-26 08:41:11.564408');
INSERT INTO public.virksomhet VALUES (179, '801530830', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801530830', '{adresse}', 'AKTIV', '2023-01-01', 801530831, '2023-09-26 08:41:11.568002', '2023-09-26 08:41:11.568002');
INSERT INTO public.virksomhet VALUES (180, '854116543', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854116543', '{adresse}', 'AKTIV', '2023-01-01', 854116544, '2023-09-26 08:41:11.572949', '2023-09-26 08:41:11.572949');
INSERT INTO public.virksomhet VALUES (181, '822163976', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822163976', '{adresse}', 'AKTIV', '2023-01-01', 822163977, '2023-09-26 08:41:11.577147', '2023-09-26 08:41:11.577147');
INSERT INTO public.virksomhet VALUES (182, '808933287', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808933287', '{adresse}', 'AKTIV', '2023-01-01', 808933288, '2023-09-26 08:41:11.582121', '2023-09-26 08:41:11.582121');
INSERT INTO public.virksomhet VALUES (183, '818050310', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818050310', '{adresse}', 'AKTIV', '2023-01-01', 818050311, '2023-09-26 08:41:11.587115', '2023-09-26 08:41:11.587115');
INSERT INTO public.virksomhet VALUES (184, '863716068', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863716068', '{adresse}', 'AKTIV', '2023-01-01', 863716069, '2023-09-26 08:41:11.590904', '2023-09-26 08:41:11.590904');
INSERT INTO public.virksomhet VALUES (185, '831760105', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831760105', '{adresse}', 'AKTIV', '2023-01-01', 831760106, '2023-09-26 08:41:11.597108', '2023-09-26 08:41:11.597108');
INSERT INTO public.virksomhet VALUES (186, '888564163', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888564163', '{adresse}', 'AKTIV', '2023-01-01', 888564164, '2023-09-26 08:41:11.603319', '2023-09-26 08:41:11.603319');
INSERT INTO public.virksomhet VALUES (187, '852309451', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852309451', '{adresse}', 'AKTIV', '2023-01-01', 852309452, '2023-09-26 08:41:11.607273', '2023-09-26 08:41:11.607273');
INSERT INTO public.virksomhet VALUES (188, '890371035', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890371035', '{adresse}', 'AKTIV', '2023-01-01', 890371036, '2023-09-26 08:41:11.612606', '2023-09-26 08:41:11.612606');
INSERT INTO public.virksomhet VALUES (189, '890925186', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890925186', '{adresse}', 'AKTIV', '2023-01-01', 890925187, '2023-09-26 08:41:11.617156', '2023-09-26 08:41:11.617156');
INSERT INTO public.virksomhet VALUES (190, '898920835', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898920835', '{adresse}', 'AKTIV', '2023-01-01', 898920836, '2023-09-26 08:41:11.622387', '2023-09-26 08:41:11.622387');
INSERT INTO public.virksomhet VALUES (191, '890663657', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890663657', '{adresse}', 'AKTIV', '2023-01-01', 890663658, '2023-09-26 08:41:11.626451', '2023-09-26 08:41:11.626451');
INSERT INTO public.virksomhet VALUES (192, '898784411', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898784411', '{adresse}', 'AKTIV', '2023-01-01', 898784412, '2023-09-26 08:41:11.634285', '2023-09-26 08:41:11.634285');
INSERT INTO public.virksomhet VALUES (193, '852322922', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852322922', '{adresse}', 'AKTIV', '2023-01-01', 852322923, '2023-09-26 08:41:11.637698', '2023-09-26 08:41:11.637698');
INSERT INTO public.virksomhet VALUES (194, '882706228', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882706228', '{adresse}', 'AKTIV', '2023-01-01', 882706229, '2023-09-26 08:41:11.641359', '2023-09-26 08:41:11.641359');
INSERT INTO public.virksomhet VALUES (195, '886131564', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886131564', '{adresse}', 'AKTIV', '2023-01-01', 886131565, '2023-09-26 08:41:11.647233', '2023-09-26 08:41:11.647233');
INSERT INTO public.virksomhet VALUES (196, '812662067', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812662067', '{adresse}', 'AKTIV', '2023-01-01', 812662068, '2023-09-26 08:41:11.651622', '2023-09-26 08:41:11.651622');
INSERT INTO public.virksomhet VALUES (197, '832810025', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832810025', '{adresse}', 'AKTIV', '2023-01-01', 832810026, '2023-09-26 08:41:11.654132', '2023-09-26 08:41:11.654132');
INSERT INTO public.virksomhet VALUES (198, '843127037', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843127037', '{adresse}', 'AKTIV', '2023-01-01', 843127038, '2023-09-26 08:41:11.657313', '2023-09-26 08:41:11.657313');
INSERT INTO public.virksomhet VALUES (199, '876218247', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876218247', '{adresse}', 'AKTIV', '2023-01-01', 876218248, '2023-09-26 08:41:11.681315', '2023-09-26 08:41:11.681315');
INSERT INTO public.virksomhet VALUES (200, '856802794', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856802794', '{adresse}', 'AKTIV', '2023-01-01', 856802795, '2023-09-26 08:41:11.684743', '2023-09-26 08:41:11.684743');
INSERT INTO public.virksomhet VALUES (201, '866003303', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866003303', '{adresse}', 'AKTIV', '2023-01-01', 866003304, '2023-09-26 08:41:11.697118', '2023-09-26 08:41:11.697118');
INSERT INTO public.virksomhet VALUES (202, '867493772', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867493772', '{adresse}', 'AKTIV', '2023-01-01', 867493773, '2023-09-26 08:41:11.707125', '2023-09-26 08:41:11.707125');
INSERT INTO public.virksomhet VALUES (203, '811617678', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811617678', '{adresse}', 'AKTIV', '2023-01-01', 811617679, '2023-09-26 08:41:11.717586', '2023-09-26 08:41:11.717586');
INSERT INTO public.virksomhet VALUES (204, '822556309', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822556309', '{adresse}', 'AKTIV', '2023-01-01', 822556310, '2023-09-26 08:41:11.73325', '2023-09-26 08:41:11.73325');
INSERT INTO public.virksomhet VALUES (205, '805926138', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805926138', '{adresse}', 'AKTIV', '2023-01-01', 805926139, '2023-09-26 08:41:11.736755', '2023-09-26 08:41:11.736755');
INSERT INTO public.virksomhet VALUES (206, '862023896', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862023896', '{adresse}', 'AKTIV', '2023-01-01', 862023897, '2023-09-26 08:41:11.744071', '2023-09-26 08:41:11.744071');
INSERT INTO public.virksomhet VALUES (207, '875893485', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875893485', '{adresse}', 'AKTIV', '2023-01-01', 875893486, '2023-09-26 08:41:11.747528', '2023-09-26 08:41:11.747528');
INSERT INTO public.virksomhet VALUES (208, '811788361', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811788361', '{adresse}', 'AKTIV', '2023-01-01', 811788362, '2023-09-26 08:41:11.750991', '2023-09-26 08:41:11.750991');
INSERT INTO public.virksomhet VALUES (209, '808215390', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808215390', '{adresse}', 'AKTIV', '2023-01-01', 808215391, '2023-09-26 08:41:11.756485', '2023-09-26 08:41:11.756485');
INSERT INTO public.virksomhet VALUES (210, '843297634', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843297634', '{adresse}', 'AKTIV', '2023-01-01', 843297635, '2023-09-26 08:41:11.760846', '2023-09-26 08:41:11.760846');
INSERT INTO public.virksomhet VALUES (211, '845197013', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845197013', '{adresse}', 'AKTIV', '2023-01-01', 845197014, '2023-09-26 08:41:11.764557', '2023-09-26 08:41:11.764557');
INSERT INTO public.virksomhet VALUES (212, '893637675', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893637675', '{adresse}', 'AKTIV', '2023-01-01', 893637676, '2023-09-26 08:41:11.767827', '2023-09-26 08:41:11.767827');
INSERT INTO public.virksomhet VALUES (213, '845548783', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845548783', '{adresse}', 'AKTIV', '2023-01-01', 845548784, '2023-09-26 08:41:11.771878', '2023-09-26 08:41:11.771878');
INSERT INTO public.virksomhet VALUES (214, '830539701', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830539701', '{adresse}', 'AKTIV', '2023-01-01', 830539702, '2023-09-26 08:41:11.793892', '2023-09-26 08:41:11.793892');
INSERT INTO public.virksomhet VALUES (215, '820563519', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820563519', '{adresse}', 'AKTIV', '2023-01-01', 820563520, '2023-09-26 08:41:11.801487', '2023-09-26 08:41:11.801487');
INSERT INTO public.virksomhet VALUES (216, '814765188', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814765188', '{adresse}', 'AKTIV', '2023-01-01', 814765189, '2023-09-26 08:41:11.806323', '2023-09-26 08:41:11.806323');
INSERT INTO public.virksomhet VALUES (217, '875814545', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875814545', '{adresse}', 'AKTIV', '2023-01-01', 875814546, '2023-09-26 08:41:11.811228', '2023-09-26 08:41:11.811228');
INSERT INTO public.virksomhet VALUES (218, '867296859', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867296859', '{adresse}', 'AKTIV', '2023-01-01', 867296860, '2023-09-26 08:41:11.814426', '2023-09-26 08:41:11.814426');
INSERT INTO public.virksomhet VALUES (219, '859376922', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859376922', '{adresse}', 'AKTIV', '2023-01-01', 859376923, '2023-09-26 08:41:11.817936', '2023-09-26 08:41:11.817936');
INSERT INTO public.virksomhet VALUES (220, '890692239', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890692239', '{adresse}', 'AKTIV', '2023-01-01', 890692240, '2023-09-26 08:41:11.822445', '2023-09-26 08:41:11.822445');
INSERT INTO public.virksomhet VALUES (221, '845661814', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845661814', '{adresse}', 'AKTIV', '2023-01-01', 845661815, '2023-09-26 08:41:11.826768', '2023-09-26 08:41:11.826768');
INSERT INTO public.virksomhet VALUES (222, '876092060', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876092060', '{adresse}', 'AKTIV', '2023-01-01', 876092061, '2023-09-26 08:41:11.83054', '2023-09-26 08:41:11.83054');
INSERT INTO public.virksomhet VALUES (223, '823313186', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823313186', '{adresse}', 'AKTIV', '2023-01-01', 823313187, '2023-09-26 08:41:11.834197', '2023-09-26 08:41:11.834197');
INSERT INTO public.virksomhet VALUES (224, '854791028', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854791028', '{adresse}', 'AKTIV', '2023-01-01', 854791029, '2023-09-26 08:41:11.837535', '2023-09-26 08:41:11.837535');
INSERT INTO public.virksomhet VALUES (225, '848270274', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848270274', '{adresse}', 'AKTIV', '2023-01-01', 848270275, '2023-09-26 08:41:11.842948', '2023-09-26 08:41:11.842948');
INSERT INTO public.virksomhet VALUES (226, '864247136', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864247136', '{adresse}', 'AKTIV', '2023-01-01', 864247137, '2023-09-26 08:41:11.847754', '2023-09-26 08:41:11.847754');
INSERT INTO public.virksomhet VALUES (227, '891403785', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891403785', '{adresse}', 'AKTIV', '2023-01-01', 891403786, '2023-09-26 08:41:11.851544', '2023-09-26 08:41:11.851544');
INSERT INTO public.virksomhet VALUES (228, '814939601', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814939601', '{adresse}', 'AKTIV', '2023-01-01', 814939602, '2023-09-26 08:41:11.85718', '2023-09-26 08:41:11.85718');
INSERT INTO public.virksomhet VALUES (229, '854703179', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854703179', '{adresse}', 'AKTIV', '2023-01-01', 854703180, '2023-09-26 08:41:11.861315', '2023-09-26 08:41:11.861315');
INSERT INTO public.virksomhet VALUES (230, '849166780', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849166780', '{adresse}', 'AKTIV', '2023-01-01', 849166781, '2023-09-26 08:41:11.864869', '2023-09-26 08:41:11.864869');
INSERT INTO public.virksomhet VALUES (231, '809533904', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809533904', '{adresse}', 'AKTIV', '2023-01-01', 809533905, '2023-09-26 08:41:11.868929', '2023-09-26 08:41:11.868929');
INSERT INTO public.virksomhet VALUES (232, '839802289', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839802289', '{adresse}', 'AKTIV', '2023-01-01', 839802290, '2023-09-26 08:41:11.872484', '2023-09-26 08:41:11.872484');
INSERT INTO public.virksomhet VALUES (233, '858870327', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858870327', '{adresse}', 'AKTIV', '2023-01-01', 858870328, '2023-09-26 08:41:11.876354', '2023-09-26 08:41:11.876354');
INSERT INTO public.virksomhet VALUES (234, '814625362', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814625362', '{adresse}', 'AKTIV', '2023-01-01', 814625363, '2023-09-26 08:41:11.880894', '2023-09-26 08:41:11.880894');
INSERT INTO public.virksomhet VALUES (235, '869274174', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869274174', '{adresse}', 'AKTIV', '2023-01-01', 869274175, '2023-09-26 08:41:11.884375', '2023-09-26 08:41:11.884375');
INSERT INTO public.virksomhet VALUES (236, '862679562', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862679562', '{adresse}', 'AKTIV', '2023-01-01', 862679563, '2023-09-26 08:41:11.89044', '2023-09-26 08:41:11.89044');
INSERT INTO public.virksomhet VALUES (237, '855263203', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855263203', '{adresse}', 'AKTIV', '2023-01-01', 855263204, '2023-09-26 08:41:11.895644', '2023-09-26 08:41:11.895644');
INSERT INTO public.virksomhet VALUES (238, '807947468', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807947468', '{adresse}', 'AKTIV', '2023-01-01', 807947469, '2023-09-26 08:41:11.901563', '2023-09-26 08:41:11.901563');
INSERT INTO public.virksomhet VALUES (239, '899140832', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899140832', '{adresse}', 'AKTIV', '2023-01-01', 899140833, '2023-09-26 08:41:11.907298', '2023-09-26 08:41:11.907298');
INSERT INTO public.virksomhet VALUES (240, '814995115', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814995115', '{adresse}', 'AKTIV', '2023-01-01', 814995116, '2023-09-26 08:41:11.913295', '2023-09-26 08:41:11.913295');
INSERT INTO public.virksomhet VALUES (241, '840627940', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840627940', '{adresse}', 'AKTIV', '2023-01-01', 840627941, '2023-09-26 08:41:11.917135', '2023-09-26 08:41:11.917135');
INSERT INTO public.virksomhet VALUES (242, '822409793', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822409793', '{adresse}', 'AKTIV', '2023-01-01', 822409794, '2023-09-26 08:41:11.920847', '2023-09-26 08:41:11.920847');
INSERT INTO public.virksomhet VALUES (243, '829598728', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829598728', '{adresse}', 'AKTIV', '2023-01-01', 829598729, '2023-09-26 08:41:11.924214', '2023-09-26 08:41:11.924214');
INSERT INTO public.virksomhet VALUES (244, '811487041', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811487041', '{adresse}', 'AKTIV', '2023-01-01', 811487042, '2023-09-26 08:41:11.929388', '2023-09-26 08:41:11.929388');
INSERT INTO public.virksomhet VALUES (245, '873219637', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873219637', '{adresse}', 'AKTIV', '2023-01-01', 873219638, '2023-09-26 08:41:11.934504', '2023-09-26 08:41:11.934504');
INSERT INTO public.virksomhet VALUES (246, '891248584', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891248584', '{adresse}', 'AKTIV', '2023-01-01', 891248585, '2023-09-26 08:41:11.941285', '2023-09-26 08:41:11.941285');
INSERT INTO public.virksomhet VALUES (247, '858042253', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858042253', '{adresse}', 'AKTIV', '2023-01-01', 858042254, '2023-09-26 08:41:11.947151', '2023-09-26 08:41:11.947151');
INSERT INTO public.virksomhet VALUES (248, '804035361', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804035361', '{adresse}', 'AKTIV', '2023-01-01', 804035362, '2023-09-26 08:41:11.954202', '2023-09-26 08:41:11.954202');
INSERT INTO public.virksomhet VALUES (249, '856940194', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856940194', '{adresse}', 'AKTIV', '2023-01-01', 856940195, '2023-09-26 08:41:11.961802', '2023-09-26 08:41:11.961802');
INSERT INTO public.virksomhet VALUES (250, '832595872', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832595872', '{adresse}', 'AKTIV', '2023-01-01', 832595873, '2023-09-26 08:41:11.970573', '2023-09-26 08:41:11.970573');
INSERT INTO public.virksomhet VALUES (251, '843931110', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843931110', '{adresse}', 'AKTIV', '2023-01-01', 843931111, '2023-09-26 08:41:11.98118', '2023-09-26 08:41:11.98118');
INSERT INTO public.virksomhet VALUES (252, '844627392', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844627392', '{adresse}', 'AKTIV', '2023-01-01', 844627393, '2023-09-26 08:41:11.98843', '2023-09-26 08:41:11.98843');
INSERT INTO public.virksomhet VALUES (253, '837280530', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837280530', '{adresse}', 'AKTIV', '2023-01-01', 837280531, '2023-09-26 08:41:12.008845', '2023-09-26 08:41:12.008845');
INSERT INTO public.virksomhet VALUES (254, '861895351', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861895351', '{adresse}', 'AKTIV', '2023-01-01', 861895352, '2023-09-26 08:41:12.01865', '2023-09-26 08:41:12.01865');
INSERT INTO public.virksomhet VALUES (255, '862752393', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862752393', '{adresse}', 'AKTIV', '2023-01-01', 862752394, '2023-09-26 08:41:12.024481', '2023-09-26 08:41:12.024481');
INSERT INTO public.virksomhet VALUES (256, '876901137', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876901137', '{adresse}', 'AKTIV', '2023-01-01', 876901138, '2023-09-26 08:41:12.037623', '2023-09-26 08:41:12.037623');
INSERT INTO public.virksomhet VALUES (257, '841908141', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841908141', '{adresse}', 'AKTIV', '2023-01-01', 841908142, '2023-09-26 08:41:12.041695', '2023-09-26 08:41:12.041695');
INSERT INTO public.virksomhet VALUES (258, '835693750', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835693750', '{adresse}', 'AKTIV', '2023-01-01', 835693751, '2023-09-26 08:41:12.045413', '2023-09-26 08:41:12.045413');
INSERT INTO public.virksomhet VALUES (259, '843856841', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843856841', '{adresse}', 'AKTIV', '2023-01-01', 843856842, '2023-09-26 08:41:12.049701', '2023-09-26 08:41:12.049701');
INSERT INTO public.virksomhet VALUES (260, '816506380', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816506380', '{adresse}', 'AKTIV', '2023-01-01', 816506381, '2023-09-26 08:41:12.0536', '2023-09-26 08:41:12.0536');
INSERT INTO public.virksomhet VALUES (261, '867068412', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867068412', '{adresse}', 'AKTIV', '2023-01-01', 867068413, '2023-09-26 08:41:12.057098', '2023-09-26 08:41:12.057098');
INSERT INTO public.virksomhet VALUES (262, '880009250', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880009250', '{adresse}', 'AKTIV', '2023-01-01', 880009251, '2023-09-26 08:41:12.061473', '2023-09-26 08:41:12.061473');
INSERT INTO public.virksomhet VALUES (263, '812011848', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812011848', '{adresse}', 'AKTIV', '2023-01-01', 812011849, '2023-09-26 08:41:12.065886', '2023-09-26 08:41:12.065886');
INSERT INTO public.virksomhet VALUES (264, '888273755', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888273755', '{adresse}', 'AKTIV', '2023-01-01', 888273756, '2023-09-26 08:41:12.070351', '2023-09-26 08:41:12.070351');
INSERT INTO public.virksomhet VALUES (265, '846393436', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846393436', '{adresse}', 'AKTIV', '2023-01-01', 846393437, '2023-09-26 08:41:12.073682', '2023-09-26 08:41:12.073682');
INSERT INTO public.virksomhet VALUES (266, '831113163', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831113163', '{adresse}', 'AKTIV', '2023-01-01', 831113164, '2023-09-26 08:41:12.077732', '2023-09-26 08:41:12.077732');
INSERT INTO public.virksomhet VALUES (267, '841116951', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841116951', '{adresse}', 'AKTIV', '2023-01-01', 841116952, '2023-09-26 08:41:12.083007', '2023-09-26 08:41:12.083007');
INSERT INTO public.virksomhet VALUES (268, '869607779', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869607779', '{adresse}', 'AKTIV', '2023-01-01', 869607780, '2023-09-26 08:41:12.086945', '2023-09-26 08:41:12.086945');
INSERT INTO public.virksomhet VALUES (269, '835030409', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835030409', '{adresse}', 'AKTIV', '2023-01-01', 835030410, '2023-09-26 08:41:12.091203', '2023-09-26 08:41:12.091203');
INSERT INTO public.virksomhet VALUES (270, '822263497', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822263497', '{adresse}', 'AKTIV', '2023-01-01', 822263498, '2023-09-26 08:41:12.095258', '2023-09-26 08:41:12.095258');
INSERT INTO public.virksomhet VALUES (271, '875126680', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875126680', '{adresse}', 'AKTIV', '2023-01-01', 875126681, '2023-09-26 08:41:12.098542', '2023-09-26 08:41:12.098542');
INSERT INTO public.virksomhet VALUES (272, '885953705', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885953705', '{adresse}', 'AKTIV', '2023-01-01', 885953706, '2023-09-26 08:41:12.102601', '2023-09-26 08:41:12.102601');
INSERT INTO public.virksomhet VALUES (273, '891596153', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891596153', '{adresse}', 'AKTIV', '2023-01-01', 891596154, '2023-09-26 08:41:12.106758', '2023-09-26 08:41:12.106758');
INSERT INTO public.virksomhet VALUES (274, '836503490', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836503490', '{adresse}', 'AKTIV', '2023-01-01', 836503491, '2023-09-26 08:41:12.122658', '2023-09-26 08:41:12.122658');
INSERT INTO public.virksomhet VALUES (275, '805201745', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805201745', '{adresse}', 'AKTIV', '2023-01-01', 805201746, '2023-09-26 08:41:12.126212', '2023-09-26 08:41:12.126212');
INSERT INTO public.virksomhet VALUES (276, '836133320', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836133320', '{adresse}', 'AKTIV', '2023-01-01', 836133321, '2023-09-26 08:41:12.130955', '2023-09-26 08:41:12.130955');
INSERT INTO public.virksomhet VALUES (277, '826668465', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826668465', '{adresse}', 'AKTIV', '2023-01-01', 826668466, '2023-09-26 08:41:12.135599', '2023-09-26 08:41:12.135599');
INSERT INTO public.virksomhet VALUES (278, '895148808', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895148808', '{adresse}', 'AKTIV', '2023-01-01', 895148809, '2023-09-26 08:41:12.140257', '2023-09-26 08:41:12.140257');
INSERT INTO public.virksomhet VALUES (279, '827397411', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827397411', '{adresse}', 'AKTIV', '2023-01-01', 827397412, '2023-09-26 08:41:12.144449', '2023-09-26 08:41:12.144449');
INSERT INTO public.virksomhet VALUES (280, '865680414', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865680414', '{adresse}', 'AKTIV', '2023-01-01', 865680415, '2023-09-26 08:41:12.148317', '2023-09-26 08:41:12.148317');
INSERT INTO public.virksomhet VALUES (281, '882526380', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882526380', '{adresse}', 'AKTIV', '2023-01-01', 882526381, '2023-09-26 08:41:12.152374', '2023-09-26 08:41:12.152374');
INSERT INTO public.virksomhet VALUES (282, '893639860', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893639860', '{adresse}', 'AKTIV', '2023-01-01', 893639861, '2023-09-26 08:41:12.156051', '2023-09-26 08:41:12.156051');
INSERT INTO public.virksomhet VALUES (283, '849959569', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849959569', '{adresse}', 'AKTIV', '2023-01-01', 849959570, '2023-09-26 08:41:12.160374', '2023-09-26 08:41:12.160374');
INSERT INTO public.virksomhet VALUES (284, '822591872', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822591872', '{adresse}', 'AKTIV', '2023-01-01', 822591873, '2023-09-26 08:41:12.163622', '2023-09-26 08:41:12.163622');
INSERT INTO public.virksomhet VALUES (285, '815923187', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815923187', '{adresse}', 'AKTIV', '2023-01-01', 815923188, '2023-09-26 08:41:12.168112', '2023-09-26 08:41:12.168112');
INSERT INTO public.virksomhet VALUES (286, '874451949', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874451949', '{adresse}', 'AKTIV', '2023-01-01', 874451950, '2023-09-26 08:41:12.173613', '2023-09-26 08:41:12.173613');
INSERT INTO public.virksomhet VALUES (287, '875847357', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875847357', '{adresse}', 'AKTIV', '2023-01-01', 875847358, '2023-09-26 08:41:12.176819', '2023-09-26 08:41:12.176819');
INSERT INTO public.virksomhet VALUES (288, '883621424', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883621424', '{adresse}', 'AKTIV', '2023-01-01', 883621425, '2023-09-26 08:41:12.180202', '2023-09-26 08:41:12.180202');
INSERT INTO public.virksomhet VALUES (289, '828700673', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828700673', '{adresse}', 'AKTIV', '2023-01-01', 828700674, '2023-09-26 08:41:12.184128', '2023-09-26 08:41:12.184128');
INSERT INTO public.virksomhet VALUES (290, '834669073', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834669073', '{adresse}', 'AKTIV', '2023-01-01', 834669074, '2023-09-26 08:41:12.187949', '2023-09-26 08:41:12.187949');
INSERT INTO public.virksomhet VALUES (291, '863315976', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863315976', '{adresse}', 'AKTIV', '2023-01-01', 863315977, '2023-09-26 08:41:12.190929', '2023-09-26 08:41:12.190929');
INSERT INTO public.virksomhet VALUES (292, '877546819', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877546819', '{adresse}', 'AKTIV', '2023-01-01', 877546820, '2023-09-26 08:41:12.210119', '2023-09-26 08:41:12.210119');
INSERT INTO public.virksomhet VALUES (293, '871751721', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871751721', '{adresse}', 'AKTIV', '2023-01-01', 871751722, '2023-09-26 08:41:12.216443', '2023-09-26 08:41:12.216443');
INSERT INTO public.virksomhet VALUES (294, '822812612', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822812612', '{adresse}', 'AKTIV', '2023-01-01', 822812613, '2023-09-26 08:41:12.220093', '2023-09-26 08:41:12.220093');
INSERT INTO public.virksomhet VALUES (295, '858966616', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858966616', '{adresse}', 'AKTIV', '2023-01-01', 858966617, '2023-09-26 08:41:12.223632', '2023-09-26 08:41:12.223632');
INSERT INTO public.virksomhet VALUES (296, '875705265', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875705265', '{adresse}', 'AKTIV', '2023-01-01', 875705266, '2023-09-26 08:41:12.22802', '2023-09-26 08:41:12.22802');
INSERT INTO public.virksomhet VALUES (297, '882907789', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882907789', '{adresse}', 'AKTIV', '2023-01-01', 882907790, '2023-09-26 08:41:12.232371', '2023-09-26 08:41:12.232371');
INSERT INTO public.virksomhet VALUES (298, '849707551', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849707551', '{adresse}', 'AKTIV', '2023-01-01', 849707552, '2023-09-26 08:41:12.234498', '2023-09-26 08:41:12.234498');
INSERT INTO public.virksomhet VALUES (299, '859103042', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859103042', '{adresse}', 'AKTIV', '2023-01-01', 859103043, '2023-09-26 08:41:12.239164', '2023-09-26 08:41:12.239164');
INSERT INTO public.virksomhet VALUES (300, '830359834', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830359834', '{adresse}', 'AKTIV', '2023-01-01', 830359835, '2023-09-26 08:41:12.243833', '2023-09-26 08:41:12.243833');
INSERT INTO public.virksomhet VALUES (301, '880967607', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880967607', '{adresse}', 'AKTIV', '2023-01-01', 880967608, '2023-09-26 08:41:12.248228', '2023-09-26 08:41:12.248228');
INSERT INTO public.virksomhet VALUES (302, '818786135', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818786135', '{adresse}', 'AKTIV', '2023-01-01', 818786136, '2023-09-26 08:41:12.252109', '2023-09-26 08:41:12.252109');
INSERT INTO public.virksomhet VALUES (303, '842810467', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842810467', '{adresse}', 'AKTIV', '2023-01-01', 842810468, '2023-09-26 08:41:12.256092', '2023-09-26 08:41:12.256092');
INSERT INTO public.virksomhet VALUES (304, '869146460', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869146460', '{adresse}', 'AKTIV', '2023-01-01', 869146461, '2023-09-26 08:41:12.26066', '2023-09-26 08:41:12.26066');
INSERT INTO public.virksomhet VALUES (305, '811235604', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811235604', '{adresse}', 'AKTIV', '2023-01-01', 811235605, '2023-09-26 08:41:12.265852', '2023-09-26 08:41:12.265852');
INSERT INTO public.virksomhet VALUES (306, '875345141', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875345141', '{adresse}', 'AKTIV', '2023-01-01', 875345142, '2023-09-26 08:41:12.270365', '2023-09-26 08:41:12.270365');
INSERT INTO public.virksomhet VALUES (307, '880013472', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880013472', '{adresse}', 'AKTIV', '2023-01-01', 880013473, '2023-09-26 08:41:12.275103', '2023-09-26 08:41:12.275103');
INSERT INTO public.virksomhet VALUES (308, '833759078', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833759078', '{adresse}', 'AKTIV', '2023-01-01', 833759079, '2023-09-26 08:41:12.278676', '2023-09-26 08:41:12.278676');
INSERT INTO public.virksomhet VALUES (309, '888464361', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888464361', '{adresse}', 'AKTIV', '2023-01-01', 888464362, '2023-09-26 08:41:12.283092', '2023-09-26 08:41:12.283092');
INSERT INTO public.virksomhet VALUES (310, '854339829', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854339829', '{adresse}', 'AKTIV', '2023-01-01', 854339830, '2023-09-26 08:41:12.286557', '2023-09-26 08:41:12.286557');
INSERT INTO public.virksomhet VALUES (311, '894571142', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894571142', '{adresse}', 'AKTIV', '2023-01-01', 894571143, '2023-09-26 08:41:12.289948', '2023-09-26 08:41:12.289948');
INSERT INTO public.virksomhet VALUES (312, '887905822', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887905822', '{adresse}', 'AKTIV', '2023-01-01', 887905823, '2023-09-26 08:41:12.294452', '2023-09-26 08:41:12.294452');
INSERT INTO public.virksomhet VALUES (313, '833756981', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833756981', '{adresse}', 'AKTIV', '2023-01-01', 833756982, '2023-09-26 08:41:12.298102', '2023-09-26 08:41:12.298102');
INSERT INTO public.virksomhet VALUES (314, '826330385', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826330385', '{adresse}', 'AKTIV', '2023-01-01', 826330386, '2023-09-26 08:41:12.302156', '2023-09-26 08:41:12.302156');
INSERT INTO public.virksomhet VALUES (315, '891555439', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891555439', '{adresse}', 'AKTIV', '2023-01-01', 891555440, '2023-09-26 08:41:12.305958', '2023-09-26 08:41:12.305958');
INSERT INTO public.virksomhet VALUES (316, '896920834', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896920834', '{adresse}', 'AKTIV', '2023-01-01', 896920835, '2023-09-26 08:41:12.311488', '2023-09-26 08:41:12.311488');
INSERT INTO public.virksomhet VALUES (317, '879564751', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879564751', '{adresse}', 'AKTIV', '2023-01-01', 879564752, '2023-09-26 08:41:12.31601', '2023-09-26 08:41:12.31601');
INSERT INTO public.virksomhet VALUES (318, '836530672', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836530672', '{adresse}', 'AKTIV', '2023-01-01', 836530673, '2023-09-26 08:41:12.321346', '2023-09-26 08:41:12.321346');
INSERT INTO public.virksomhet VALUES (319, '892324905', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892324905', '{adresse}', 'AKTIV', '2023-01-01', 892324906, '2023-09-26 08:41:12.32782', '2023-09-26 08:41:12.32782');
INSERT INTO public.virksomhet VALUES (320, '822582670', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822582670', '{adresse}', 'AKTIV', '2023-01-01', 822582671, '2023-09-26 08:41:12.332928', '2023-09-26 08:41:12.332928');
INSERT INTO public.virksomhet VALUES (321, '844004408', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844004408', '{adresse}', 'AKTIV', '2023-01-01', 844004409, '2023-09-26 08:41:12.336139', '2023-09-26 08:41:12.336139');
INSERT INTO public.virksomhet VALUES (322, '806868172', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806868172', '{adresse}', 'AKTIV', '2023-01-01', 806868173, '2023-09-26 08:41:12.340518', '2023-09-26 08:41:12.340518');
INSERT INTO public.virksomhet VALUES (323, '809808915', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809808915', '{adresse}', 'AKTIV', '2023-01-01', 809808916, '2023-09-26 08:41:12.344934', '2023-09-26 08:41:12.344934');
INSERT INTO public.virksomhet VALUES (324, '804710758', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804710758', '{adresse}', 'AKTIV', '2023-01-01', 804710759, '2023-09-26 08:41:12.34788', '2023-09-26 08:41:12.34788');
INSERT INTO public.virksomhet VALUES (325, '851371456', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851371456', '{adresse}', 'AKTIV', '2023-01-01', 851371457, '2023-09-26 08:41:12.351398', '2023-09-26 08:41:12.351398');
INSERT INTO public.virksomhet VALUES (326, '890797411', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890797411', '{adresse}', 'AKTIV', '2023-01-01', 890797412, '2023-09-26 08:41:12.35503', '2023-09-26 08:41:12.35503');
INSERT INTO public.virksomhet VALUES (327, '834730925', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834730925', '{adresse}', 'AKTIV', '2023-01-01', 834730926, '2023-09-26 08:41:12.358991', '2023-09-26 08:41:12.358991');
INSERT INTO public.virksomhet VALUES (328, '879694468', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879694468', '{adresse}', 'AKTIV', '2023-01-01', 879694469, '2023-09-26 08:41:12.365912', '2023-09-26 08:41:12.365912');
INSERT INTO public.virksomhet VALUES (329, '878491400', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878491400', '{adresse}', 'AKTIV', '2023-01-01', 878491401, '2023-09-26 08:41:12.374248', '2023-09-26 08:41:12.374248');
INSERT INTO public.virksomhet VALUES (330, '887695198', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887695198', '{adresse}', 'AKTIV', '2023-01-01', 887695199, '2023-09-26 08:41:12.379488', '2023-09-26 08:41:12.379488');
INSERT INTO public.virksomhet VALUES (331, '817754837', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817754837', '{adresse}', 'AKTIV', '2023-01-01', 817754838, '2023-09-26 08:41:12.3835', '2023-09-26 08:41:12.3835');
INSERT INTO public.virksomhet VALUES (332, '817592892', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817592892', '{adresse}', 'AKTIV', '2023-01-01', 817592893, '2023-09-26 08:41:12.386946', '2023-09-26 08:41:12.386946');
INSERT INTO public.virksomhet VALUES (333, '839628252', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839628252', '{adresse}', 'AKTIV', '2023-01-01', 839628253, '2023-09-26 08:41:12.391116', '2023-09-26 08:41:12.391116');
INSERT INTO public.virksomhet VALUES (334, '881133468', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881133468', '{adresse}', 'AKTIV', '2023-01-01', 881133469, '2023-09-26 08:41:12.395011', '2023-09-26 08:41:12.395011');
INSERT INTO public.virksomhet VALUES (335, '851076314', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851076314', '{adresse}', 'AKTIV', '2023-01-01', 851076315, '2023-09-26 08:41:12.402768', '2023-09-26 08:41:12.402768');
INSERT INTO public.virksomhet VALUES (336, '812785759', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812785759', '{adresse}', 'AKTIV', '2023-01-01', 812785760, '2023-09-26 08:41:12.406365', '2023-09-26 08:41:12.406365');
INSERT INTO public.virksomhet VALUES (337, '884442635', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884442635', '{adresse}', 'AKTIV', '2023-01-01', 884442636, '2023-09-26 08:41:12.411141', '2023-09-26 08:41:12.411141');
INSERT INTO public.virksomhet VALUES (338, '845307946', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845307946', '{adresse}', 'AKTIV', '2023-01-01', 845307947, '2023-09-26 08:41:12.4158', '2023-09-26 08:41:12.4158');
INSERT INTO public.virksomhet VALUES (339, '866583348', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866583348', '{adresse}', 'AKTIV', '2023-01-01', 866583349, '2023-09-26 08:41:12.420955', '2023-09-26 08:41:12.420955');
INSERT INTO public.virksomhet VALUES (340, '875467294', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875467294', '{adresse}', 'AKTIV', '2023-01-01', 875467295, '2023-09-26 08:41:12.423087', '2023-09-26 08:41:12.423087');
INSERT INTO public.virksomhet VALUES (341, '845360782', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845360782', '{adresse}', 'AKTIV', '2023-01-01', 845360783, '2023-09-26 08:41:12.4281', '2023-09-26 08:41:12.4281');
INSERT INTO public.virksomhet VALUES (342, '864718167', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864718167', '{adresse}', 'AKTIV', '2023-01-01', 864718168, '2023-09-26 08:41:12.432929', '2023-09-26 08:41:12.432929');
INSERT INTO public.virksomhet VALUES (343, '812375313', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 812375313', '{adresse}', 'AKTIV', '2023-01-01', 812375314, '2023-09-26 08:41:12.438041', '2023-09-26 08:41:12.438041');
INSERT INTO public.virksomhet VALUES (344, '824153216', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824153216', '{adresse}', 'AKTIV', '2023-01-01', 824153217, '2023-09-26 08:41:12.444482', '2023-09-26 08:41:12.444482');
INSERT INTO public.virksomhet VALUES (345, '844481790', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844481790', '{adresse}', 'AKTIV', '2023-01-01', 844481791, '2023-09-26 08:41:12.450131', '2023-09-26 08:41:12.450131');
INSERT INTO public.virksomhet VALUES (346, '883251195', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883251195', '{adresse}', 'AKTIV', '2023-01-01', 883251196, '2023-09-26 08:41:12.456834', '2023-09-26 08:41:12.456834');
INSERT INTO public.virksomhet VALUES (347, '847393696', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847393696', '{adresse}', 'AKTIV', '2023-01-01', 847393697, '2023-09-26 08:41:12.463219', '2023-09-26 08:41:12.463219');
INSERT INTO public.virksomhet VALUES (348, '877551828', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877551828', '{adresse}', 'AKTIV', '2023-01-01', 877551829, '2023-09-26 08:41:12.468675', '2023-09-26 08:41:12.468675');
INSERT INTO public.virksomhet VALUES (349, '824151314', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824151314', '{adresse}', 'AKTIV', '2023-01-01', 824151315, '2023-09-26 08:41:12.473184', '2023-09-26 08:41:12.473184');
INSERT INTO public.virksomhet VALUES (350, '868625646', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868625646', '{adresse}', 'AKTIV', '2023-01-01', 868625647, '2023-09-26 08:41:12.478766', '2023-09-26 08:41:12.478766');
INSERT INTO public.virksomhet VALUES (351, '801041781', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801041781', '{adresse}', 'AKTIV', '2023-01-01', 801041782, '2023-09-26 08:41:12.483131', '2023-09-26 08:41:12.483131');
INSERT INTO public.virksomhet VALUES (352, '833522111', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833522111', '{adresse}', 'AKTIV', '2023-01-01', 833522112, '2023-09-26 08:41:12.490394', '2023-09-26 08:41:12.490394');
INSERT INTO public.virksomhet VALUES (353, '838724757', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838724757', '{adresse}', 'AKTIV', '2023-01-01', 838724758, '2023-09-26 08:41:12.506878', '2023-09-26 08:41:12.506878');
INSERT INTO public.virksomhet VALUES (354, '873142509', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873142509', '{adresse}', 'AKTIV', '2023-01-01', 873142510, '2023-09-26 08:41:12.511926', '2023-09-26 08:41:12.511926');
INSERT INTO public.virksomhet VALUES (355, '819095643', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819095643', '{adresse}', 'AKTIV', '2023-01-01', 819095644, '2023-09-26 08:41:12.519211', '2023-09-26 08:41:12.519211');
INSERT INTO public.virksomhet VALUES (356, '839805308', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839805308', '{adresse}', 'AKTIV', '2023-01-01', 839805309, '2023-09-26 08:41:12.52254', '2023-09-26 08:41:12.52254');
INSERT INTO public.virksomhet VALUES (357, '864530414', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864530414', '{adresse}', 'AKTIV', '2023-01-01', 864530415, '2023-09-26 08:41:12.544513', '2023-09-26 08:41:12.544513');
INSERT INTO public.virksomhet VALUES (358, '876334530', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876334530', '{adresse}', 'AKTIV', '2023-01-01', 876334531, '2023-09-26 08:41:12.548518', '2023-09-26 08:41:12.548518');
INSERT INTO public.virksomhet VALUES (359, '806839656', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806839656', '{adresse}', 'AKTIV', '2023-01-01', 806839657, '2023-09-26 08:41:12.553731', '2023-09-26 08:41:12.553731');
INSERT INTO public.virksomhet VALUES (360, '846015259', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846015259', '{adresse}', 'AKTIV', '2023-01-01', 846015260, '2023-09-26 08:41:12.557973', '2023-09-26 08:41:12.557973');
INSERT INTO public.virksomhet VALUES (361, '814345054', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814345054', '{adresse}', 'AKTIV', '2023-01-01', 814345055, '2023-09-26 08:41:12.5626', '2023-09-26 08:41:12.5626');
INSERT INTO public.virksomhet VALUES (362, '873748492', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873748492', '{adresse}', 'AKTIV', '2023-01-01', 873748493, '2023-09-26 08:41:12.566637', '2023-09-26 08:41:12.566637');
INSERT INTO public.virksomhet VALUES (363, '870830126', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870830126', '{adresse}', 'AKTIV', '2023-01-01', 870830127, '2023-09-26 08:41:12.572117', '2023-09-26 08:41:12.572117');
INSERT INTO public.virksomhet VALUES (364, '855694962', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855694962', '{adresse}', 'AKTIV', '2023-01-01', 855694963, '2023-09-26 08:41:12.5771', '2023-09-26 08:41:12.5771');
INSERT INTO public.virksomhet VALUES (365, '816957144', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816957144', '{adresse}', 'AKTIV', '2023-01-01', 816957145, '2023-09-26 08:41:12.580768', '2023-09-26 08:41:12.580768');
INSERT INTO public.virksomhet VALUES (366, '879958734', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879958734', '{adresse}', 'AKTIV', '2023-01-01', 879958735, '2023-09-26 08:41:12.584309', '2023-09-26 08:41:12.584309');
INSERT INTO public.virksomhet VALUES (367, '854997907', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854997907', '{adresse}', 'AKTIV', '2023-01-01', 854997908, '2023-09-26 08:41:12.587191', '2023-09-26 08:41:12.587191');
INSERT INTO public.virksomhet VALUES (368, '840090931', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840090931', '{adresse}', 'AKTIV', '2023-01-01', 840090932, '2023-09-26 08:41:12.592339', '2023-09-26 08:41:12.592339');
INSERT INTO public.virksomhet VALUES (369, '896336814', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896336814', '{adresse}', 'AKTIV', '2023-01-01', 896336815, '2023-09-26 08:41:12.59561', '2023-09-26 08:41:12.59561');
INSERT INTO public.virksomhet VALUES (370, '829763599', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829763599', '{adresse}', 'AKTIV', '2023-01-01', 829763600, '2023-09-26 08:41:12.598768', '2023-09-26 08:41:12.598768');
INSERT INTO public.virksomhet VALUES (371, '804813050', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804813050', '{adresse}', 'AKTIV', '2023-01-01', 804813051, '2023-09-26 08:41:12.60359', '2023-09-26 08:41:12.60359');
INSERT INTO public.virksomhet VALUES (372, '821982479', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821982479', '{adresse}', 'AKTIV', '2023-01-01', 821982480, '2023-09-26 08:41:12.609813', '2023-09-26 08:41:12.609813');
INSERT INTO public.virksomhet VALUES (373, '801590421', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801590421', '{adresse}', 'AKTIV', '2023-01-01', 801590422, '2023-09-26 08:41:12.614047', '2023-09-26 08:41:12.614047');
INSERT INTO public.virksomhet VALUES (374, '880244637', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880244637', '{adresse}', 'AKTIV', '2023-01-01', 880244638, '2023-09-26 08:41:12.617044', '2023-09-26 08:41:12.617044');
INSERT INTO public.virksomhet VALUES (375, '886923382', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886923382', '{adresse}', 'AKTIV', '2023-01-01', 886923383, '2023-09-26 08:41:12.638012', '2023-09-26 08:41:12.638012');
INSERT INTO public.virksomhet VALUES (376, '835178070', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835178070', '{adresse}', 'AKTIV', '2023-01-01', 835178071, '2023-09-26 08:41:12.64215', '2023-09-26 08:41:12.64215');
INSERT INTO public.virksomhet VALUES (377, '878399690', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878399690', '{adresse}', 'AKTIV', '2023-01-01', 878399691, '2023-09-26 08:41:12.64486', '2023-09-26 08:41:12.64486');
INSERT INTO public.virksomhet VALUES (378, '821233692', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821233692', '{adresse}', 'AKTIV', '2023-01-01', 821233693, '2023-09-26 08:41:12.647452', '2023-09-26 08:41:12.647452');
INSERT INTO public.virksomhet VALUES (379, '834703013', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834703013', '{adresse}', 'AKTIV', '2023-01-01', 834703014, '2023-09-26 08:41:12.651234', '2023-09-26 08:41:12.651234');
INSERT INTO public.virksomhet VALUES (380, '875419244', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875419244', '{adresse}', 'AKTIV', '2023-01-01', 875419245, '2023-09-26 08:41:12.65737', '2023-09-26 08:41:12.65737');
INSERT INTO public.virksomhet VALUES (381, '875524887', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875524887', '{adresse}', 'AKTIV', '2023-01-01', 875524888, '2023-09-26 08:41:12.661333', '2023-09-26 08:41:12.661333');
INSERT INTO public.virksomhet VALUES (382, '808577852', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808577852', '{adresse}', 'AKTIV', '2023-01-01', 808577853, '2023-09-26 08:41:12.666384', '2023-09-26 08:41:12.666384');
INSERT INTO public.virksomhet VALUES (383, '855976007', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855976007', '{adresse}', 'AKTIV', '2023-01-01', 855976008, '2023-09-26 08:41:12.675107', '2023-09-26 08:41:12.675107');
INSERT INTO public.virksomhet VALUES (384, '805668045', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805668045', '{adresse}', 'AKTIV', '2023-01-01', 805668046, '2023-09-26 08:41:12.682123', '2023-09-26 08:41:12.682123');
INSERT INTO public.virksomhet VALUES (385, '866053344', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866053344', '{adresse}', 'AKTIV', '2023-01-01', 866053345, '2023-09-26 08:41:12.687558', '2023-09-26 08:41:12.687558');
INSERT INTO public.virksomhet VALUES (386, '826675802', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826675802', '{adresse}', 'AKTIV', '2023-01-01', 826675803, '2023-09-26 08:41:12.691267', '2023-09-26 08:41:12.691267');
INSERT INTO public.virksomhet VALUES (387, '891178398', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891178398', '{adresse}', 'AKTIV', '2023-01-01', 891178399, '2023-09-26 08:41:12.695104', '2023-09-26 08:41:12.695104');
INSERT INTO public.virksomhet VALUES (388, '827246869', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827246869', '{adresse}', 'AKTIV', '2023-01-01', 827246870, '2023-09-26 08:41:12.70127', '2023-09-26 08:41:12.70127');
INSERT INTO public.virksomhet VALUES (389, '884866232', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884866232', '{adresse}', 'AKTIV', '2023-01-01', 884866233, '2023-09-26 08:41:12.70612', '2023-09-26 08:41:12.70612');
INSERT INTO public.virksomhet VALUES (390, '832999354', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832999354', '{adresse}', 'AKTIV', '2023-01-01', 832999355, '2023-09-26 08:41:12.710718', '2023-09-26 08:41:12.710718');
INSERT INTO public.virksomhet VALUES (391, '804217825', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804217825', '{adresse}', 'AKTIV', '2023-01-01', 804217826, '2023-09-26 08:41:12.71461', '2023-09-26 08:41:12.71461');
INSERT INTO public.virksomhet VALUES (392, '877885837', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877885837', '{adresse}', 'AKTIV', '2023-01-01', 877885838, '2023-09-26 08:41:12.717749', '2023-09-26 08:41:12.717749');
INSERT INTO public.virksomhet VALUES (393, '845650116', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845650116', '{adresse}', 'AKTIV', '2023-01-01', 845650117, '2023-09-26 08:41:12.72186', '2023-09-26 08:41:12.72186');
INSERT INTO public.virksomhet VALUES (394, '825243256', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825243256', '{adresse}', 'AKTIV', '2023-01-01', 825243257, '2023-09-26 08:41:12.724973', '2023-09-26 08:41:12.724973');
INSERT INTO public.virksomhet VALUES (395, '868231650', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868231650', '{adresse}', 'AKTIV', '2023-01-01', 868231651, '2023-09-26 08:41:12.729624', '2023-09-26 08:41:12.729624');
INSERT INTO public.virksomhet VALUES (396, '891495802', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891495802', '{adresse}', 'AKTIV', '2023-01-01', 891495803, '2023-09-26 08:41:12.733343', '2023-09-26 08:41:12.733343');
INSERT INTO public.virksomhet VALUES (397, '803071765', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803071765', '{adresse}', 'AKTIV', '2023-01-01', 803071766, '2023-09-26 08:41:12.737689', '2023-09-26 08:41:12.737689');
INSERT INTO public.virksomhet VALUES (398, '813392223', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813392223', '{adresse}', 'AKTIV', '2023-01-01', 813392224, '2023-09-26 08:41:12.741079', '2023-09-26 08:41:12.741079');
INSERT INTO public.virksomhet VALUES (399, '838837456', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838837456', '{adresse}', 'AKTIV', '2023-01-01', 838837457, '2023-09-26 08:41:12.745407', '2023-09-26 08:41:12.745407');
INSERT INTO public.virksomhet VALUES (400, '832925912', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832925912', '{adresse}', 'AKTIV', '2023-01-01', 832925913, '2023-09-26 08:41:12.749436', '2023-09-26 08:41:12.749436');
INSERT INTO public.virksomhet VALUES (401, '879984059', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879984059', '{adresse}', 'AKTIV', '2023-01-01', 879984060, '2023-09-26 08:41:12.753299', '2023-09-26 08:41:12.753299');
INSERT INTO public.virksomhet VALUES (402, '876194824', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876194824', '{adresse}', 'AKTIV', '2023-01-01', 876194825, '2023-09-26 08:41:12.756638', '2023-09-26 08:41:12.756638');
INSERT INTO public.virksomhet VALUES (403, '869960927', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869960927', '{adresse}', 'AKTIV', '2023-01-01', 869960928, '2023-09-26 08:41:12.760716', '2023-09-26 08:41:12.760716');
INSERT INTO public.virksomhet VALUES (404, '864924121', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864924121', '{adresse}', 'AKTIV', '2023-01-01', 864924122, '2023-09-26 08:41:12.765284', '2023-09-26 08:41:12.765284');
INSERT INTO public.virksomhet VALUES (405, '889871834', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889871834', '{adresse}', 'AKTIV', '2023-01-01', 889871835, '2023-09-26 08:41:12.770046', '2023-09-26 08:41:12.770046');
INSERT INTO public.virksomhet VALUES (406, '888941725', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888941725', '{adresse}', 'AKTIV', '2023-01-01', 888941726, '2023-09-26 08:41:12.773693', '2023-09-26 08:41:12.773693');
INSERT INTO public.virksomhet VALUES (407, '864451386', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864451386', '{adresse}', 'AKTIV', '2023-01-01', 864451387, '2023-09-26 08:41:12.777557', '2023-09-26 08:41:12.777557');
INSERT INTO public.virksomhet VALUES (408, '805409250', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805409250', '{adresse}', 'AKTIV', '2023-01-01', 805409251, '2023-09-26 08:41:12.781004', '2023-09-26 08:41:12.781004');
INSERT INTO public.virksomhet VALUES (409, '885909306', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885909306', '{adresse}', 'AKTIV', '2023-01-01', 885909307, '2023-09-26 08:41:12.785458', '2023-09-26 08:41:12.785458');
INSERT INTO public.virksomhet VALUES (410, '882842016', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882842016', '{adresse}', 'AKTIV', '2023-01-01', 882842017, '2023-09-26 08:41:12.789494', '2023-09-26 08:41:12.789494');
INSERT INTO public.virksomhet VALUES (411, '828800154', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828800154', '{adresse}', 'AKTIV', '2023-01-01', 828800155, '2023-09-26 08:41:12.794543', '2023-09-26 08:41:12.794543');
INSERT INTO public.virksomhet VALUES (412, '865165378', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865165378', '{adresse}', 'AKTIV', '2023-01-01', 865165379, '2023-09-26 08:41:12.798067', '2023-09-26 08:41:12.798067');
INSERT INTO public.virksomhet VALUES (413, '802468370', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802468370', '{adresse}', 'AKTIV', '2023-01-01', 802468371, '2023-09-26 08:41:12.803859', '2023-09-26 08:41:12.803859');
INSERT INTO public.virksomhet VALUES (414, '866720470', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866720470', '{adresse}', 'AKTIV', '2023-01-01', 866720471, '2023-09-26 08:41:12.807783', '2023-09-26 08:41:12.807783');
INSERT INTO public.virksomhet VALUES (415, '837254716', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837254716', '{adresse}', 'AKTIV', '2023-01-01', 837254717, '2023-09-26 08:41:12.81207', '2023-09-26 08:41:12.81207');
INSERT INTO public.virksomhet VALUES (416, '822693795', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822693795', '{adresse}', 'AKTIV', '2023-01-01', 822693796, '2023-09-26 08:41:12.817028', '2023-09-26 08:41:12.817028');
INSERT INTO public.virksomhet VALUES (417, '824924346', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824924346', '{adresse}', 'AKTIV', '2023-01-01', 824924347, '2023-09-26 08:41:12.82062', '2023-09-26 08:41:12.82062');
INSERT INTO public.virksomhet VALUES (418, '840023586', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840023586', '{adresse}', 'AKTIV', '2023-01-01', 840023587, '2023-09-26 08:41:12.824237', '2023-09-26 08:41:12.824237');
INSERT INTO public.virksomhet VALUES (419, '864991464', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864991464', '{adresse}', 'AKTIV', '2023-01-01', 864991465, '2023-09-26 08:41:12.828168', '2023-09-26 08:41:12.828168');
INSERT INTO public.virksomhet VALUES (420, '859153568', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859153568', '{adresse}', 'AKTIV', '2023-01-01', 859153569, '2023-09-26 08:41:12.831997', '2023-09-26 08:41:12.831997');
INSERT INTO public.virksomhet VALUES (421, '844114779', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844114779', '{adresse}', 'AKTIV', '2023-01-01', 844114780, '2023-09-26 08:41:12.834807', '2023-09-26 08:41:12.834807');
INSERT INTO public.virksomhet VALUES (422, '838791317', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838791317', '{adresse}', 'AKTIV', '2023-01-01', 838791318, '2023-09-26 08:41:12.842288', '2023-09-26 08:41:12.842288');
INSERT INTO public.virksomhet VALUES (423, '896532159', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896532159', '{adresse}', 'AKTIV', '2023-01-01', 896532160, '2023-09-26 08:41:12.845999', '2023-09-26 08:41:12.845999');
INSERT INTO public.virksomhet VALUES (424, '856413108', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856413108', '{adresse}', 'AKTIV', '2023-01-01', 856413109, '2023-09-26 08:41:12.850187', '2023-09-26 08:41:12.850187');
INSERT INTO public.virksomhet VALUES (425, '809698080', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809698080', '{adresse}', 'AKTIV', '2023-01-01', 809698081, '2023-09-26 08:41:12.853257', '2023-09-26 08:41:12.853257');
INSERT INTO public.virksomhet VALUES (426, '817684378', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817684378', '{adresse}', 'AKTIV', '2023-01-01', 817684379, '2023-09-26 08:41:12.85666', '2023-09-26 08:41:12.85666');
INSERT INTO public.virksomhet VALUES (427, '832196578', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832196578', '{adresse}', 'AKTIV', '2023-01-01', 832196579, '2023-09-26 08:41:12.860808', '2023-09-26 08:41:12.860808');
INSERT INTO public.virksomhet VALUES (428, '893850387', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893850387', '{adresse}', 'AKTIV', '2023-01-01', 893850388, '2023-09-26 08:41:12.864089', '2023-09-26 08:41:12.864089');
INSERT INTO public.virksomhet VALUES (429, '817356166', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817356166', '{adresse}', 'AKTIV', '2023-01-01', 817356167, '2023-09-26 08:41:12.868081', '2023-09-26 08:41:12.868081');
INSERT INTO public.virksomhet VALUES (430, '851432294', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851432294', '{adresse}', 'AKTIV', '2023-01-01', 851432295, '2023-09-26 08:41:12.872208', '2023-09-26 08:41:12.872208');
INSERT INTO public.virksomhet VALUES (431, '864392250', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864392250', '{adresse}', 'AKTIV', '2023-01-01', 864392251, '2023-09-26 08:41:12.876358', '2023-09-26 08:41:12.876358');
INSERT INTO public.virksomhet VALUES (432, '825803329', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825803329', '{adresse}', 'AKTIV', '2023-01-01', 825803330, '2023-09-26 08:41:12.880713', '2023-09-26 08:41:12.880713');
INSERT INTO public.virksomhet VALUES (433, '819673352', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819673352', '{adresse}', 'AKTIV', '2023-01-01', 819673353, '2023-09-26 08:41:12.884298', '2023-09-26 08:41:12.884298');
INSERT INTO public.virksomhet VALUES (434, '813294486', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813294486', '{adresse}', 'AKTIV', '2023-01-01', 813294487, '2023-09-26 08:41:12.888185', '2023-09-26 08:41:12.888185');
INSERT INTO public.virksomhet VALUES (435, '878831599', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878831599', '{adresse}', 'AKTIV', '2023-01-01', 878831600, '2023-09-26 08:41:12.917863', '2023-09-26 08:41:12.917863');
INSERT INTO public.virksomhet VALUES (436, '864960497', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864960497', '{adresse}', 'AKTIV', '2023-01-01', 864960498, '2023-09-26 08:41:12.933575', '2023-09-26 08:41:12.933575');
INSERT INTO public.virksomhet VALUES (437, '802850140', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802850140', '{adresse}', 'AKTIV', '2023-01-01', 802850141, '2023-09-26 08:41:12.941105', '2023-09-26 08:41:12.941105');
INSERT INTO public.virksomhet VALUES (438, '888167848', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888167848', '{adresse}', 'AKTIV', '2023-01-01', 888167849, '2023-09-26 08:41:12.947484', '2023-09-26 08:41:12.947484');
INSERT INTO public.virksomhet VALUES (439, '842330504', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842330504', '{adresse}', 'AKTIV', '2023-01-01', 842330505, '2023-09-26 08:41:12.95182', '2023-09-26 08:41:12.95182');
INSERT INTO public.virksomhet VALUES (440, '858424081', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858424081', '{adresse}', 'AKTIV', '2023-01-01', 858424082, '2023-09-26 08:41:12.956081', '2023-09-26 08:41:12.956081');
INSERT INTO public.virksomhet VALUES (441, '815207424', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815207424', '{adresse}', 'AKTIV', '2023-01-01', 815207425, '2023-09-26 08:41:12.962495', '2023-09-26 08:41:12.962495');
INSERT INTO public.virksomhet VALUES (442, '865941162', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865941162', '{adresse}', 'AKTIV', '2023-01-01', 865941163, '2023-09-26 08:41:12.966625', '2023-09-26 08:41:12.966625');
INSERT INTO public.virksomhet VALUES (443, '831686801', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831686801', '{adresse}', 'AKTIV', '2023-01-01', 831686802, '2023-09-26 08:41:12.972372', '2023-09-26 08:41:12.972372');
INSERT INTO public.virksomhet VALUES (444, '895905384', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895905384', '{adresse}', 'AKTIV', '2023-01-01', 895905385, '2023-09-26 08:41:12.977764', '2023-09-26 08:41:12.977764');
INSERT INTO public.virksomhet VALUES (445, '872009291', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872009291', '{adresse}', 'AKTIV', '2023-01-01', 872009292, '2023-09-26 08:41:12.982667', '2023-09-26 08:41:12.982667');
INSERT INTO public.virksomhet VALUES (446, '863269152', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863269152', '{adresse}', 'AKTIV', '2023-01-01', 863269153, '2023-09-26 08:41:12.986428', '2023-09-26 08:41:12.986428');
INSERT INTO public.virksomhet VALUES (447, '849547937', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849547937', '{adresse}', 'AKTIV', '2023-01-01', 849547938, '2023-09-26 08:41:12.992134', '2023-09-26 08:41:12.992134');
INSERT INTO public.virksomhet VALUES (448, '873304362', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873304362', '{adresse}', 'AKTIV', '2023-01-01', 873304363, '2023-09-26 08:41:12.996666', '2023-09-26 08:41:12.996666');
INSERT INTO public.virksomhet VALUES (449, '876387118', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876387118', '{adresse}', 'AKTIV', '2023-01-01', 876387119, '2023-09-26 08:41:13.001185', '2023-09-26 08:41:13.001185');
INSERT INTO public.virksomhet VALUES (450, '857272488', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857272488', '{adresse}', 'AKTIV', '2023-01-01', 857272489, '2023-09-26 08:41:13.005013', '2023-09-26 08:41:13.005013');
INSERT INTO public.virksomhet VALUES (451, '822221695', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822221695', '{adresse}', 'AKTIV', '2023-01-01', 822221696, '2023-09-26 08:41:13.010624', '2023-09-26 08:41:13.010624');
INSERT INTO public.virksomhet VALUES (452, '819638427', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819638427', '{adresse}', 'AKTIV', '2023-01-01', 819638428, '2023-09-26 08:41:13.013509', '2023-09-26 08:41:13.013509');
INSERT INTO public.virksomhet VALUES (453, '866895965', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866895965', '{adresse}', 'AKTIV', '2023-01-01', 866895966, '2023-09-26 08:41:13.018918', '2023-09-26 08:41:13.018918');
INSERT INTO public.virksomhet VALUES (454, '861193841', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861193841', '{adresse}', 'AKTIV', '2023-01-01', 861193842, '2023-09-26 08:41:13.021621', '2023-09-26 08:41:13.021621');
INSERT INTO public.virksomhet VALUES (455, '874977279', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874977279', '{adresse}', 'AKTIV', '2023-01-01', 874977280, '2023-09-26 08:41:13.025398', '2023-09-26 08:41:13.025398');
INSERT INTO public.virksomhet VALUES (456, '889745877', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889745877', '{adresse}', 'AKTIV', '2023-01-01', 889745878, '2023-09-26 08:41:13.030283', '2023-09-26 08:41:13.030283');
INSERT INTO public.virksomhet VALUES (457, '820698548', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820698548', '{adresse}', 'AKTIV', '2023-01-01', 820698549, '2023-09-26 08:41:13.046073', '2023-09-26 08:41:13.046073');
INSERT INTO public.virksomhet VALUES (458, '809296618', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809296618', '{adresse}', 'AKTIV', '2023-01-01', 809296619, '2023-09-26 08:41:13.052201', '2023-09-26 08:41:13.052201');
INSERT INTO public.virksomhet VALUES (459, '863705831', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863705831', '{adresse}', 'AKTIV', '2023-01-01', 863705832, '2023-09-26 08:41:13.055405', '2023-09-26 08:41:13.055405');
INSERT INTO public.virksomhet VALUES (460, '811014768', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811014768', '{adresse}', 'AKTIV', '2023-01-01', 811014769, '2023-09-26 08:41:13.058955', '2023-09-26 08:41:13.058955');
INSERT INTO public.virksomhet VALUES (461, '865854422', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865854422', '{adresse}', 'AKTIV', '2023-01-01', 865854423, '2023-09-26 08:41:13.061832', '2023-09-26 08:41:13.061832');
INSERT INTO public.virksomhet VALUES (462, '820448483', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820448483', '{adresse}', 'AKTIV', '2023-01-01', 820448484, '2023-09-26 08:41:13.065211', '2023-09-26 08:41:13.065211');
INSERT INTO public.virksomhet VALUES (463, '821667661', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821667661', '{adresse}', 'AKTIV', '2023-01-01', 821667662, '2023-09-26 08:41:13.068711', '2023-09-26 08:41:13.068711');
INSERT INTO public.virksomhet VALUES (464, '889542390', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889542390', '{adresse}', 'AKTIV', '2023-01-01', 889542391, '2023-09-26 08:41:13.071907', '2023-09-26 08:41:13.071907');
INSERT INTO public.virksomhet VALUES (465, '835409486', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835409486', '{adresse}', 'AKTIV', '2023-01-01', 835409487, '2023-09-26 08:41:13.074562', '2023-09-26 08:41:13.074562');
INSERT INTO public.virksomhet VALUES (466, '814346717', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814346717', '{adresse}', 'AKTIV', '2023-01-01', 814346718, '2023-09-26 08:41:13.07776', '2023-09-26 08:41:13.07776');
INSERT INTO public.virksomhet VALUES (467, '815413004', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815413004', '{adresse}', 'AKTIV', '2023-01-01', 815413005, '2023-09-26 08:41:13.081284', '2023-09-26 08:41:13.081284');
INSERT INTO public.virksomhet VALUES (468, '818895804', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818895804', '{adresse}', 'AKTIV', '2023-01-01', 818895805, '2023-09-26 08:41:13.084756', '2023-09-26 08:41:13.084756');
INSERT INTO public.virksomhet VALUES (469, '861204923', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861204923', '{adresse}', 'AKTIV', '2023-01-01', 861204924, '2023-09-26 08:41:13.087157', '2023-09-26 08:41:13.087157');
INSERT INTO public.virksomhet VALUES (470, '879555072', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879555072', '{adresse}', 'AKTIV', '2023-01-01', 879555073, '2023-09-26 08:41:13.091721', '2023-09-26 08:41:13.091721');
INSERT INTO public.virksomhet VALUES (471, '855772393', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855772393', '{adresse}', 'AKTIV', '2023-01-01', 855772394, '2023-09-26 08:41:13.095568', '2023-09-26 08:41:13.095568');
INSERT INTO public.virksomhet VALUES (472, '837201486', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837201486', '{adresse}', 'AKTIV', '2023-01-01', 837201487, '2023-09-26 08:41:13.098454', '2023-09-26 08:41:13.098454');
INSERT INTO public.virksomhet VALUES (473, '843460808', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843460808', '{adresse}', 'AKTIV', '2023-01-01', 843460809, '2023-09-26 08:41:13.101627', '2023-09-26 08:41:13.101627');
INSERT INTO public.virksomhet VALUES (474, '877968358', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877968358', '{adresse}', 'AKTIV', '2023-01-01', 877968359, '2023-09-26 08:41:13.105039', '2023-09-26 08:41:13.105039');
INSERT INTO public.virksomhet VALUES (475, '874838097', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874838097', '{adresse}', 'AKTIV', '2023-01-01', 874838098, '2023-09-26 08:41:13.107984', '2023-09-26 08:41:13.107984');
INSERT INTO public.virksomhet VALUES (476, '805560200', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805560200', '{adresse}', 'AKTIV', '2023-01-01', 805560201, '2023-09-26 08:41:13.111115', '2023-09-26 08:41:13.111115');
INSERT INTO public.virksomhet VALUES (477, '881593144', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881593144', '{adresse}', 'AKTIV', '2023-01-01', 881593145, '2023-09-26 08:41:13.113489', '2023-09-26 08:41:13.113489');
INSERT INTO public.virksomhet VALUES (478, '842206021', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842206021', '{adresse}', 'AKTIV', '2023-01-01', 842206022, '2023-09-26 08:41:13.117913', '2023-09-26 08:41:13.117913');
INSERT INTO public.virksomhet VALUES (479, '809539154', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809539154', '{adresse}', 'AKTIV', '2023-01-01', 809539155, '2023-09-26 08:41:13.121511', '2023-09-26 08:41:13.121511');
INSERT INTO public.virksomhet VALUES (480, '881462374', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881462374', '{adresse}', 'AKTIV', '2023-01-01', 881462375, '2023-09-26 08:41:13.123981', '2023-09-26 08:41:13.123981');
INSERT INTO public.virksomhet VALUES (481, '829262952', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829262952', '{adresse}', 'AKTIV', '2023-01-01', 829262953, '2023-09-26 08:41:13.12664', '2023-09-26 08:41:13.12664');
INSERT INTO public.virksomhet VALUES (482, '824601665', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824601665', '{adresse}', 'AKTIV', '2023-01-01', 824601666, '2023-09-26 08:41:13.1301', '2023-09-26 08:41:13.1301');
INSERT INTO public.virksomhet VALUES (483, '862526144', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862526144', '{adresse}', 'AKTIV', '2023-01-01', 862526145, '2023-09-26 08:41:13.134278', '2023-09-26 08:41:13.134278');
INSERT INTO public.virksomhet VALUES (484, '839613883', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839613883', '{adresse}', 'AKTIV', '2023-01-01', 839613884, '2023-09-26 08:41:13.137021', '2023-09-26 08:41:13.137021');
INSERT INTO public.virksomhet VALUES (485, '888715789', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888715789', '{adresse}', 'AKTIV', '2023-01-01', 888715790, '2023-09-26 08:41:13.139658', '2023-09-26 08:41:13.139658');
INSERT INTO public.virksomhet VALUES (486, '832828782', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832828782', '{adresse}', 'AKTIV', '2023-01-01', 832828783, '2023-09-26 08:41:13.147661', '2023-09-26 08:41:13.147661');
INSERT INTO public.virksomhet VALUES (487, '816554836', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816554836', '{adresse}', 'AKTIV', '2023-01-01', 816554837, '2023-09-26 08:41:13.151398', '2023-09-26 08:41:13.151398');
INSERT INTO public.virksomhet VALUES (488, '856843871', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856843871', '{adresse}', 'AKTIV', '2023-01-01', 856843872, '2023-09-26 08:41:13.155152', '2023-09-26 08:41:13.155152');
INSERT INTO public.virksomhet VALUES (489, '885789588', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885789588', '{adresse}', 'AKTIV', '2023-01-01', 885789589, '2023-09-26 08:41:13.15797', '2023-09-26 08:41:13.15797');
INSERT INTO public.virksomhet VALUES (490, '884813924', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884813924', '{adresse}', 'AKTIV', '2023-01-01', 884813925, '2023-09-26 08:41:13.160928', '2023-09-26 08:41:13.160928');
INSERT INTO public.virksomhet VALUES (491, '890898121', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890898121', '{adresse}', 'AKTIV', '2023-01-01', 890898122, '2023-09-26 08:41:13.16342', '2023-09-26 08:41:13.16342');
INSERT INTO public.virksomhet VALUES (492, '800950247', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800950247', '{adresse}', 'AKTIV', '2023-01-01', 800950248, '2023-09-26 08:41:13.16651', '2023-09-26 08:41:13.16651');
INSERT INTO public.virksomhet VALUES (493, '837591913', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837591913', '{adresse}', 'AKTIV', '2023-01-01', 837591914, '2023-09-26 08:41:13.170034', '2023-09-26 08:41:13.170034');
INSERT INTO public.virksomhet VALUES (494, '860767128', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 860767128', '{adresse}', 'AKTIV', '2023-01-01', 860767129, '2023-09-26 08:41:13.17287', '2023-09-26 08:41:13.17287');
INSERT INTO public.virksomhet VALUES (495, '838144492', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838144492', '{adresse}', 'AKTIV', '2023-01-01', 838144493, '2023-09-26 08:41:13.17571', '2023-09-26 08:41:13.17571');
INSERT INTO public.virksomhet VALUES (496, '855490226', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855490226', '{adresse}', 'AKTIV', '2023-01-01', 855490227, '2023-09-26 08:41:13.178351', '2023-09-26 08:41:13.178351');
INSERT INTO public.virksomhet VALUES (497, '850967552', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850967552', '{adresse}', 'AKTIV', '2023-01-01', 850967553, '2023-09-26 08:41:13.181748', '2023-09-26 08:41:13.181748');
INSERT INTO public.virksomhet VALUES (498, '840025249', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840025249', '{adresse}', 'AKTIV', '2023-01-01', 840025250, '2023-09-26 08:41:13.184186', '2023-09-26 08:41:13.184186');
INSERT INTO public.virksomhet VALUES (499, '836815368', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836815368', '{adresse}', 'AKTIV', '2023-01-01', 836815369, '2023-09-26 08:41:13.186904', '2023-09-26 08:41:13.186904');
INSERT INTO public.virksomhet VALUES (500, '819212825', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819212825', '{adresse}', 'AKTIV', '2023-01-01', 819212826, '2023-09-26 08:41:13.19108', '2023-09-26 08:41:13.19108');
INSERT INTO public.virksomhet VALUES (501, '868485136', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868485136', '{adresse}', 'AKTIV', '2023-01-01', 868485137, '2023-09-26 08:41:13.194095', '2023-09-26 08:41:13.194095');
INSERT INTO public.virksomhet VALUES (502, '895904953', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895904953', '{adresse}', 'AKTIV', '2023-01-01', 895904954, '2023-09-26 08:41:13.197313', '2023-09-26 08:41:13.197313');
INSERT INTO public.virksomhet VALUES (503, '879844455', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879844455', '{adresse}', 'AKTIV', '2023-01-01', 879844456, '2023-09-26 08:41:13.200825', '2023-09-26 08:41:13.200825');
INSERT INTO public.virksomhet VALUES (504, '843762828', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843762828', '{adresse}', 'AKTIV', '2023-01-01', 843762829, '2023-09-26 08:41:13.204208', '2023-09-26 08:41:13.204208');
INSERT INTO public.virksomhet VALUES (505, '816273549', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816273549', '{adresse}', 'AKTIV', '2023-01-01', 816273550, '2023-09-26 08:41:13.20864', '2023-09-26 08:41:13.20864');
INSERT INTO public.virksomhet VALUES (506, '841533906', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841533906', '{adresse}', 'AKTIV', '2023-01-01', 841533907, '2023-09-26 08:41:13.212567', '2023-09-26 08:41:13.212567');
INSERT INTO public.virksomhet VALUES (507, '888102873', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888102873', '{adresse}', 'AKTIV', '2023-01-01', 888102874, '2023-09-26 08:41:13.218665', '2023-09-26 08:41:13.218665');
INSERT INTO public.virksomhet VALUES (508, '834489694', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834489694', '{adresse}', 'AKTIV', '2023-01-01', 834489695, '2023-09-26 08:41:13.222728', '2023-09-26 08:41:13.222728');
INSERT INTO public.virksomhet VALUES (509, '839054362', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839054362', '{adresse}', 'AKTIV', '2023-01-01', 839054363, '2023-09-26 08:41:13.226008', '2023-09-26 08:41:13.226008');
INSERT INTO public.virksomhet VALUES (510, '802825378', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802825378', '{adresse}', 'AKTIV', '2023-01-01', 802825379, '2023-09-26 08:41:13.228529', '2023-09-26 08:41:13.228529');


--
-- Data for Name: virksomhet_naringsundergrupper; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet_naringsundergrupper VALUES (1, 1, '90.012', NULL, NULL, '2023-09-26 08:41:10.130499', '2023-09-26 08:41:10.130499');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (2, 2, '70.220', '90.012', NULL, '2023-09-26 08:41:10.164349', '2023-09-26 08:41:10.164349');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (3, 3, '90.012', '70.220', NULL, '2023-09-26 08:41:10.171722', '2023-09-26 08:41:10.171722');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (4, 4, '90.012', NULL, NULL, '2023-09-26 08:41:10.179443', '2023-09-26 08:41:10.179443');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (5, 5, '01.120', NULL, NULL, '2023-09-26 08:41:10.233655', '2023-09-26 08:41:10.233655');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (6, 6, '01.120', NULL, NULL, '2023-09-26 08:41:10.240716', '2023-09-26 08:41:10.240716');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (7, 7, '01.120', NULL, NULL, '2023-09-26 08:41:10.248459', '2023-09-26 08:41:10.248459');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (8, 8, '01.120', '90.012', NULL, '2023-09-26 08:41:10.25523', '2023-09-26 08:41:10.25523');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (9, 9, '01.120', NULL, NULL, '2023-09-26 08:41:10.26084', '2023-09-26 08:41:10.26084');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (10, 10, '01.120', NULL, NULL, '2023-09-26 08:41:10.26669', '2023-09-26 08:41:10.26669');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (11, 11, '01.120', NULL, NULL, '2023-09-26 08:41:10.272156', '2023-09-26 08:41:10.272156');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (12, 12, '01.120', '90.012', NULL, '2023-09-26 08:41:10.28045', '2023-09-26 08:41:10.28045');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (13, 13, '01.120', '90.012', '70.220', '2023-09-26 08:41:10.285283', '2023-09-26 08:41:10.285283');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (14, 14, '01.120', NULL, NULL, '2023-09-26 08:41:10.289365', '2023-09-26 08:41:10.289365');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (15, 15, '01.120', '90.012', '70.220', '2023-09-26 08:41:10.299686', '2023-09-26 08:41:10.299686');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (16, 16, '01.120', '90.012', NULL, '2023-09-26 08:41:10.314896', '2023-09-26 08:41:10.314896');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (17, 17, '01.120', '90.012', '70.220', '2023-09-26 08:41:10.319694', '2023-09-26 08:41:10.319694');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (18, 18, '01.120', NULL, NULL, '2023-09-26 08:41:10.323505', '2023-09-26 08:41:10.323505');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (19, 19, '01.120', '90.012', NULL, '2023-09-26 08:41:10.328285', '2023-09-26 08:41:10.328285');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (20, 20, '01.120', '90.012', NULL, '2023-09-26 08:41:10.334701', '2023-09-26 08:41:10.334701');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (21, 21, '01.120', NULL, NULL, '2023-09-26 08:41:10.341022', '2023-09-26 08:41:10.341022');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (22, 22, '01.120', NULL, NULL, '2023-09-26 08:41:10.34948', '2023-09-26 08:41:10.34948');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (23, 23, '01.120', '90.012', NULL, '2023-09-26 08:41:10.355923', '2023-09-26 08:41:10.355923');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (24, 24, '01.120', NULL, NULL, '2023-09-26 08:41:10.3628', '2023-09-26 08:41:10.3628');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (25, 25, '01.120', NULL, NULL, '2023-09-26 08:41:10.368257', '2023-09-26 08:41:10.368257');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (26, 26, '01.120', '90.012', NULL, '2023-09-26 08:41:10.372475', '2023-09-26 08:41:10.372475');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (27, 27, '01.120', '90.012', NULL, '2023-09-26 08:41:10.376625', '2023-09-26 08:41:10.376625');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (28, 28, '01.120', NULL, NULL, '2023-09-26 08:41:10.386977', '2023-09-26 08:41:10.386977');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (29, 29, '01.120', '90.012', NULL, '2023-09-26 08:41:10.39446', '2023-09-26 08:41:10.39446');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (30, 30, '01.120', '90.012', NULL, '2023-09-26 08:41:10.40075', '2023-09-26 08:41:10.40075');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (31, 31, '01.120', '90.012', NULL, '2023-09-26 08:41:10.41008', '2023-09-26 08:41:10.41008');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (32, 32, '01.120', '90.012', '70.220', '2023-09-26 08:41:10.48613', '2023-09-26 08:41:10.48613');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (33, 33, '01.120', '90.012', NULL, '2023-09-26 08:41:10.494695', '2023-09-26 08:41:10.494695');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (34, 34, '01.120', NULL, NULL, '2023-09-26 08:41:10.50594', '2023-09-26 08:41:10.50594');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (35, 35, '01.120', NULL, NULL, '2023-09-26 08:41:10.516499', '2023-09-26 08:41:10.516499');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (36, 36, '01.120', '90.012', NULL, '2023-09-26 08:41:10.526703', '2023-09-26 08:41:10.526703');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (37, 37, '01.120', '90.012', NULL, '2023-09-26 08:41:10.535157', '2023-09-26 08:41:10.535157');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (38, 38, '01.120', NULL, NULL, '2023-09-26 08:41:10.559477', '2023-09-26 08:41:10.559477');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (39, 39, '01.120', NULL, NULL, '2023-09-26 08:41:10.570569', '2023-09-26 08:41:10.570569');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (40, 40, '01.120', '90.012', NULL, '2023-09-26 08:41:10.576353', '2023-09-26 08:41:10.576353');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (41, 41, '01.120', NULL, NULL, '2023-09-26 08:41:10.58525', '2023-09-26 08:41:10.58525');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (42, 42, '01.120', '90.012', NULL, '2023-09-26 08:41:10.591072', '2023-09-26 08:41:10.591072');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (43, 43, '01.120', '90.012', NULL, '2023-09-26 08:41:10.596537', '2023-09-26 08:41:10.596537');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (44, 44, '01.120', '90.012', NULL, '2023-09-26 08:41:10.603929', '2023-09-26 08:41:10.603929');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (45, 45, '01.120', '90.012', NULL, '2023-09-26 08:41:10.609632', '2023-09-26 08:41:10.609632');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (46, 46, '01.120', '90.012', '70.220', '2023-09-26 08:41:10.620589', '2023-09-26 08:41:10.620589');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (47, 47, '01.120', '90.012', '70.220', '2023-09-26 08:41:10.625061', '2023-09-26 08:41:10.625061');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (48, 48, '01.120', '90.012', '70.220', '2023-09-26 08:41:10.632041', '2023-09-26 08:41:10.632041');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (49, 49, '01.120', NULL, NULL, '2023-09-26 08:41:10.635877', '2023-09-26 08:41:10.635877');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (50, 50, '01.120', NULL, NULL, '2023-09-26 08:41:10.641645', '2023-09-26 08:41:10.641645');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (51, 51, '01.120', '90.012', NULL, '2023-09-26 08:41:10.650778', '2023-09-26 08:41:10.650778');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (52, 52, '01.120', NULL, NULL, '2023-09-26 08:41:10.654228', '2023-09-26 08:41:10.654228');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (53, 53, '01.120', '90.012', '70.220', '2023-09-26 08:41:10.658266', '2023-09-26 08:41:10.658266');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (54, 54, '01.120', '90.012', NULL, '2023-09-26 08:41:10.66665', '2023-09-26 08:41:10.66665');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (55, 55, '01.120', '90.012', '70.220', '2023-09-26 08:41:10.669552', '2023-09-26 08:41:10.669552');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (56, 56, '01.120', '90.012', NULL, '2023-09-26 08:41:10.680375', '2023-09-26 08:41:10.680375');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (57, 57, '01.120', NULL, NULL, '2023-09-26 08:41:10.685297', '2023-09-26 08:41:10.685297');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (58, 58, '01.120', '90.012', NULL, '2023-09-26 08:41:10.693451', '2023-09-26 08:41:10.693451');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (59, 59, '01.120', NULL, NULL, '2023-09-26 08:41:10.69813', '2023-09-26 08:41:10.69813');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (60, 60, '01.120', '90.012', NULL, '2023-09-26 08:41:10.701713', '2023-09-26 08:41:10.701713');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (61, 61, '01.120', '90.012', NULL, '2023-09-26 08:41:10.705121', '2023-09-26 08:41:10.705121');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (62, 62, '01.120', NULL, NULL, '2023-09-26 08:41:10.714677', '2023-09-26 08:41:10.714677');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (63, 63, '01.120', '90.012', NULL, '2023-09-26 08:41:10.719185', '2023-09-26 08:41:10.719185');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (64, 64, '01.120', '90.012', NULL, '2023-09-26 08:41:10.727413', '2023-09-26 08:41:10.727413');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (65, 65, '01.120', NULL, NULL, '2023-09-26 08:41:10.734356', '2023-09-26 08:41:10.734356');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (66, 66, '01.120', '90.012', '70.220', '2023-09-26 08:41:10.738018', '2023-09-26 08:41:10.738018');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (67, 67, '01.120', '90.012', '70.220', '2023-09-26 08:41:10.744888', '2023-09-26 08:41:10.744888');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (68, 68, '01.120', NULL, NULL, '2023-09-26 08:41:10.752464', '2023-09-26 08:41:10.752464');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (69, 69, '01.120', '90.012', '70.220', '2023-09-26 08:41:10.757271', '2023-09-26 08:41:10.757271');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (70, 70, '01.120', '90.012', NULL, '2023-09-26 08:41:10.762692', '2023-09-26 08:41:10.762692');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (71, 71, '01.120', '90.012', NULL, '2023-09-26 08:41:10.768089', '2023-09-26 08:41:10.768089');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (72, 72, '01.120', '90.012', NULL, '2023-09-26 08:41:10.778296', '2023-09-26 08:41:10.778296');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (73, 73, '01.120', NULL, NULL, '2023-09-26 08:41:10.787488', '2023-09-26 08:41:10.787488');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (74, 74, '01.120', '90.012', '70.220', '2023-09-26 08:41:10.794916', '2023-09-26 08:41:10.794916');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (75, 75, '01.120', NULL, NULL, '2023-09-26 08:41:10.810335', '2023-09-26 08:41:10.810335');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (76, 76, '01.120', NULL, NULL, '2023-09-26 08:41:10.820088', '2023-09-26 08:41:10.820088');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (77, 77, '01.120', '90.012', NULL, '2023-09-26 08:41:10.828477', '2023-09-26 08:41:10.828477');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (78, 78, '01.120', NULL, NULL, '2023-09-26 08:41:10.834355', '2023-09-26 08:41:10.834355');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (79, 79, '01.120', NULL, NULL, '2023-09-26 08:41:10.853657', '2023-09-26 08:41:10.853657');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (80, 80, '01.120', NULL, NULL, '2023-09-26 08:41:10.86013', '2023-09-26 08:41:10.86013');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (81, 81, '01.120', NULL, NULL, '2023-09-26 08:41:10.867195', '2023-09-26 08:41:10.867195');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (82, 82, '01.120', NULL, NULL, '2023-09-26 08:41:10.875199', '2023-09-26 08:41:10.875199');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (83, 83, '01.120', NULL, NULL, '2023-09-26 08:41:10.878764', '2023-09-26 08:41:10.878764');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (84, 84, '01.120', NULL, NULL, '2023-09-26 08:41:10.884954', '2023-09-26 08:41:10.884954');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (85, 85, '01.120', NULL, NULL, '2023-09-26 08:41:10.891458', '2023-09-26 08:41:10.891458');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (86, 86, '01.120', '90.012', NULL, '2023-09-26 08:41:10.89775', '2023-09-26 08:41:10.89775');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (87, 87, '01.120', NULL, NULL, '2023-09-26 08:41:10.918836', '2023-09-26 08:41:10.918836');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (88, 88, '01.120', NULL, NULL, '2023-09-26 08:41:10.931938', '2023-09-26 08:41:10.931938');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (89, 89, '01.120', '90.012', NULL, '2023-09-26 08:41:10.945742', '2023-09-26 08:41:10.945742');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (90, 90, '01.120', NULL, NULL, '2023-09-26 08:41:10.953804', '2023-09-26 08:41:10.953804');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (91, 91, '01.120', '90.012', NULL, '2023-09-26 08:41:10.957959', '2023-09-26 08:41:10.957959');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (92, 92, '01.120', '90.012', NULL, '2023-09-26 08:41:10.968134', '2023-09-26 08:41:10.968134');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (93, 93, '01.120', NULL, NULL, '2023-09-26 08:41:10.975259', '2023-09-26 08:41:10.975259');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (94, 94, '01.120', '90.012', '70.220', '2023-09-26 08:41:10.989468', '2023-09-26 08:41:10.989468');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (95, 95, '01.120', NULL, NULL, '2023-09-26 08:41:10.996746', '2023-09-26 08:41:10.996746');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (96, 96, '01.120', '90.012', NULL, '2023-09-26 08:41:11.00406', '2023-09-26 08:41:11.00406');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (97, 97, '01.120', NULL, NULL, '2023-09-26 08:41:11.010925', '2023-09-26 08:41:11.010925');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (98, 98, '01.120', '90.012', '70.220', '2023-09-26 08:41:11.020046', '2023-09-26 08:41:11.020046');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (99, 99, '01.120', '90.012', NULL, '2023-09-26 08:41:11.028193', '2023-09-26 08:41:11.028193');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (100, 100, '01.120', '90.012', NULL, '2023-09-26 08:41:11.034244', '2023-09-26 08:41:11.034244');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (101, 101, '01.120', '90.012', '70.220', '2023-09-26 08:41:11.041528', '2023-09-26 08:41:11.041528');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (102, 102, '01.120', '90.012', NULL, '2023-09-26 08:41:11.046611', '2023-09-26 08:41:11.046611');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (103, 103, '01.120', NULL, NULL, '2023-09-26 08:41:11.052204', '2023-09-26 08:41:11.052204');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (104, 104, '01.120', NULL, NULL, '2023-09-26 08:41:11.06127', '2023-09-26 08:41:11.06127');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (105, 105, '01.120', NULL, NULL, '2023-09-26 08:41:11.06709', '2023-09-26 08:41:11.06709');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (106, 106, '01.120', '90.012', NULL, '2023-09-26 08:41:11.072118', '2023-09-26 08:41:11.072118');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (107, 107, '01.120', NULL, NULL, '2023-09-26 08:41:11.076729', '2023-09-26 08:41:11.076729');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (108, 108, '01.120', '90.012', NULL, '2023-09-26 08:41:11.082558', '2023-09-26 08:41:11.082558');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (109, 109, '01.120', NULL, NULL, '2023-09-26 08:41:11.089501', '2023-09-26 08:41:11.089501');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (110, 110, '01.120', NULL, NULL, '2023-09-26 08:41:11.096746', '2023-09-26 08:41:11.096746');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (111, 111, '01.120', '90.012', NULL, '2023-09-26 08:41:11.103092', '2023-09-26 08:41:11.103092');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (112, 112, '01.120', NULL, NULL, '2023-09-26 08:41:11.109726', '2023-09-26 08:41:11.109726');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (113, 113, '01.120', NULL, NULL, '2023-09-26 08:41:11.118173', '2023-09-26 08:41:11.118173');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (114, 114, '01.120', '90.012', '70.220', '2023-09-26 08:41:11.124475', '2023-09-26 08:41:11.124475');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (115, 115, '01.120', '90.012', '70.220', '2023-09-26 08:41:11.133462', '2023-09-26 08:41:11.133462');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (116, 116, '01.120', '90.012', '70.220', '2023-09-26 08:41:11.138049', '2023-09-26 08:41:11.138049');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (117, 117, '01.120', NULL, NULL, '2023-09-26 08:41:11.145174', '2023-09-26 08:41:11.145174');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (118, 118, '01.120', NULL, NULL, '2023-09-26 08:41:11.153194', '2023-09-26 08:41:11.153194');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (119, 119, '01.120', '90.012', NULL, '2023-09-26 08:41:11.157268', '2023-09-26 08:41:11.157268');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (120, 120, '01.120', '90.012', '70.220', '2023-09-26 08:41:11.163232', '2023-09-26 08:41:11.163232');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (121, 121, '01.120', NULL, NULL, '2023-09-26 08:41:11.175565', '2023-09-26 08:41:11.175565');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (122, 122, '01.120', '90.012', NULL, '2023-09-26 08:41:11.181189', '2023-09-26 08:41:11.181189');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (123, 123, '01.120', '90.012', NULL, '2023-09-26 08:41:11.188373', '2023-09-26 08:41:11.188373');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (124, 124, '01.120', '90.012', NULL, '2023-09-26 08:41:11.195497', '2023-09-26 08:41:11.195497');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (125, 125, '01.120', '90.012', '70.220', '2023-09-26 08:41:11.202444', '2023-09-26 08:41:11.202444');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (126, 126, '01.120', NULL, NULL, '2023-09-26 08:41:11.221464', '2023-09-26 08:41:11.221464');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (127, 127, '01.120', '90.012', '70.220', '2023-09-26 08:41:11.228071', '2023-09-26 08:41:11.228071');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (128, 128, '01.120', NULL, NULL, '2023-09-26 08:41:11.23721', '2023-09-26 08:41:11.23721');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (129, 129, '01.120', '90.012', NULL, '2023-09-26 08:41:11.244382', '2023-09-26 08:41:11.244382');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (130, 130, '01.120', NULL, NULL, '2023-09-26 08:41:11.248376', '2023-09-26 08:41:11.248376');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (131, 131, '01.120', '90.012', NULL, '2023-09-26 08:41:11.264154', '2023-09-26 08:41:11.264154');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (132, 132, '01.120', NULL, NULL, '2023-09-26 08:41:11.268452', '2023-09-26 08:41:11.268452');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (133, 133, '01.120', NULL, NULL, '2023-09-26 08:41:11.272678', '2023-09-26 08:41:11.272678');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (134, 134, '01.120', NULL, NULL, '2023-09-26 08:41:11.291533', '2023-09-26 08:41:11.291533');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (135, 135, '01.120', NULL, NULL, '2023-09-26 08:41:11.296852', '2023-09-26 08:41:11.296852');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (136, 136, '01.120', NULL, NULL, '2023-09-26 08:41:11.301501', '2023-09-26 08:41:11.301501');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (137, 137, '01.120', '90.012', '70.220', '2023-09-26 08:41:11.308132', '2023-09-26 08:41:11.308132');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (138, 138, '01.120', NULL, NULL, '2023-09-26 08:41:11.311367', '2023-09-26 08:41:11.311367');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (139, 139, '01.120', '90.012', NULL, '2023-09-26 08:41:11.315234', '2023-09-26 08:41:11.315234');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (140, 140, '01.120', '90.012', NULL, '2023-09-26 08:41:11.320134', '2023-09-26 08:41:11.320134');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (141, 141, '01.120', NULL, NULL, '2023-09-26 08:41:11.324964', '2023-09-26 08:41:11.324964');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (142, 142, '01.120', '90.012', NULL, '2023-09-26 08:41:11.330799', '2023-09-26 08:41:11.330799');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (143, 143, '01.120', NULL, NULL, '2023-09-26 08:41:11.334649', '2023-09-26 08:41:11.334649');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (144, 144, '01.120', NULL, NULL, '2023-09-26 08:41:11.352172', '2023-09-26 08:41:11.352172');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (145, 145, '01.120', '90.012', NULL, '2023-09-26 08:41:11.356209', '2023-09-26 08:41:11.356209');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (146, 146, '01.120', NULL, NULL, '2023-09-26 08:41:11.359686', '2023-09-26 08:41:11.359686');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (147, 147, '01.120', '90.012', NULL, '2023-09-26 08:41:11.365188', '2023-09-26 08:41:11.365188');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (148, 148, '01.120', '90.012', NULL, '2023-09-26 08:41:11.370036', '2023-09-26 08:41:11.370036');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (149, 149, '01.120', NULL, NULL, '2023-09-26 08:41:11.376096', '2023-09-26 08:41:11.376096');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (150, 150, '01.120', '90.012', NULL, '2023-09-26 08:41:11.380609', '2023-09-26 08:41:11.380609');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (151, 151, '01.120', NULL, NULL, '2023-09-26 08:41:11.385595', '2023-09-26 08:41:11.385595');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (152, 152, '01.120', '90.012', NULL, '2023-09-26 08:41:11.388663', '2023-09-26 08:41:11.388663');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (153, 153, '01.120', '90.012', '70.220', '2023-09-26 08:41:11.396716', '2023-09-26 08:41:11.396716');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (154, 154, '01.120', NULL, NULL, '2023-09-26 08:41:11.401351', '2023-09-26 08:41:11.401351');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (155, 155, '01.120', '90.012', '70.220', '2023-09-26 08:41:11.404993', '2023-09-26 08:41:11.404993');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (156, 156, '01.120', '90.012', NULL, '2023-09-26 08:41:11.409902', '2023-09-26 08:41:11.409902');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (157, 157, '01.120', NULL, NULL, '2023-09-26 08:41:11.41417', '2023-09-26 08:41:11.41417');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (158, 158, '01.120', NULL, NULL, '2023-09-26 08:41:11.417354', '2023-09-26 08:41:11.417354');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (159, 159, '01.120', '90.012', '70.220', '2023-09-26 08:41:11.420646', '2023-09-26 08:41:11.420646');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (160, 160, '01.120', '90.012', NULL, '2023-09-26 08:41:11.425569', '2023-09-26 08:41:11.425569');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (161, 161, '01.120', '90.012', '70.220', '2023-09-26 08:41:11.431365', '2023-09-26 08:41:11.431365');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (162, 162, '01.120', '90.012', NULL, '2023-09-26 08:41:11.436066', '2023-09-26 08:41:11.436066');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (163, 163, '01.120', NULL, NULL, '2023-09-26 08:41:11.446472', '2023-09-26 08:41:11.446472');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (164, 164, '01.120', NULL, NULL, '2023-09-26 08:41:11.451978', '2023-09-26 08:41:11.451978');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (165, 165, '01.120', '90.012', NULL, '2023-09-26 08:41:11.463793', '2023-09-26 08:41:11.463793');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (166, 166, '01.120', NULL, NULL, '2023-09-26 08:41:11.470923', '2023-09-26 08:41:11.470923');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (167, 167, '01.120', NULL, NULL, '2023-09-26 08:41:11.477654', '2023-09-26 08:41:11.477654');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (168, 168, '01.120', NULL, NULL, '2023-09-26 08:41:11.485393', '2023-09-26 08:41:11.485393');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (169, 169, '01.120', '90.012', '70.220', '2023-09-26 08:41:11.493819', '2023-09-26 08:41:11.493819');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (170, 170, '01.120', NULL, NULL, '2023-09-26 08:41:11.502288', '2023-09-26 08:41:11.502288');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (171, 171, '01.120', '90.012', NULL, '2023-09-26 08:41:11.506465', '2023-09-26 08:41:11.506465');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (172, 172, '01.120', NULL, NULL, '2023-09-26 08:41:11.513552', '2023-09-26 08:41:11.513552');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (173, 173, '01.120', NULL, NULL, '2023-09-26 08:41:11.536455', '2023-09-26 08:41:11.536455');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (174, 174, '01.120', '90.012', NULL, '2023-09-26 08:41:11.549978', '2023-09-26 08:41:11.549978');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (175, 175, '01.120', '90.012', '70.220', '2023-09-26 08:41:11.553653', '2023-09-26 08:41:11.553653');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (176, 176, '01.120', NULL, NULL, '2023-09-26 08:41:11.55732', '2023-09-26 08:41:11.55732');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (177, 177, '01.120', '90.012', NULL, '2023-09-26 08:41:11.561533', '2023-09-26 08:41:11.561533');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (178, 178, '01.120', NULL, NULL, '2023-09-26 08:41:11.566063', '2023-09-26 08:41:11.566063');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (179, 179, '01.120', '90.012', NULL, '2023-09-26 08:41:11.570218', '2023-09-26 08:41:11.570218');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (180, 180, '01.120', NULL, NULL, '2023-09-26 08:41:11.574646', '2023-09-26 08:41:11.574646');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (181, 181, '01.120', '90.012', NULL, '2023-09-26 08:41:11.579892', '2023-09-26 08:41:11.579892');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (182, 182, '01.120', '90.012', '70.220', '2023-09-26 08:41:11.584105', '2023-09-26 08:41:11.584105');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (183, 183, '01.120', '90.012', NULL, '2023-09-26 08:41:11.588533', '2023-09-26 08:41:11.588533');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (184, 184, '01.120', NULL, NULL, '2023-09-26 08:41:11.592873', '2023-09-26 08:41:11.592873');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (185, 185, '01.120', NULL, NULL, '2023-09-26 08:41:11.599367', '2023-09-26 08:41:11.599367');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (186, 186, '01.120', '90.012', NULL, '2023-09-26 08:41:11.604772', '2023-09-26 08:41:11.604772');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (187, 187, '01.120', NULL, NULL, '2023-09-26 08:41:11.609332', '2023-09-26 08:41:11.609332');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (188, 188, '01.120', NULL, NULL, '2023-09-26 08:41:11.61475', '2023-09-26 08:41:11.61475');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (189, 189, '01.120', NULL, NULL, '2023-09-26 08:41:11.620067', '2023-09-26 08:41:11.620067');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (190, 190, '01.120', '90.012', NULL, '2023-09-26 08:41:11.623938', '2023-09-26 08:41:11.623938');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (191, 191, '01.120', '90.012', NULL, '2023-09-26 08:41:11.628238', '2023-09-26 08:41:11.628238');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (192, 192, '01.120', NULL, NULL, '2023-09-26 08:41:11.63647', '2023-09-26 08:41:11.63647');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (193, 193, '01.120', NULL, NULL, '2023-09-26 08:41:11.63917', '2023-09-26 08:41:11.63917');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (194, 194, '01.120', NULL, NULL, '2023-09-26 08:41:11.6453', '2023-09-26 08:41:11.6453');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (195, 195, '01.120', NULL, NULL, '2023-09-26 08:41:11.649547', '2023-09-26 08:41:11.649547');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (196, 196, '01.120', '90.012', NULL, '2023-09-26 08:41:11.652667', '2023-09-26 08:41:11.652667');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (197, 197, '01.120', '90.012', '70.220', '2023-09-26 08:41:11.655587', '2023-09-26 08:41:11.655587');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (198, 198, '01.120', NULL, NULL, '2023-09-26 08:41:11.660572', '2023-09-26 08:41:11.660572');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (199, 199, '01.120', '90.012', NULL, '2023-09-26 08:41:11.682884', '2023-09-26 08:41:11.682884');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (200, 200, '01.120', NULL, NULL, '2023-09-26 08:41:11.686822', '2023-09-26 08:41:11.686822');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (201, 201, '01.120', NULL, NULL, '2023-09-26 08:41:11.701632', '2023-09-26 08:41:11.701632');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (202, 202, '01.120', NULL, NULL, '2023-09-26 08:41:11.709861', '2023-09-26 08:41:11.709861');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (203, 203, '01.120', NULL, NULL, '2023-09-26 08:41:11.721191', '2023-09-26 08:41:11.721191');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (204, 204, '01.120', '90.012', NULL, '2023-09-26 08:41:11.734605', '2023-09-26 08:41:11.734605');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (205, 205, '01.120', '90.012', NULL, '2023-09-26 08:41:11.739432', '2023-09-26 08:41:11.739432');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (206, 206, '01.120', NULL, NULL, '2023-09-26 08:41:11.745205', '2023-09-26 08:41:11.745205');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (207, 207, '01.120', '90.012', NULL, '2023-09-26 08:41:11.748958', '2023-09-26 08:41:11.748958');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (208, 208, '01.120', NULL, NULL, '2023-09-26 08:41:11.754478', '2023-09-26 08:41:11.754478');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (209, 209, '01.120', '90.012', NULL, '2023-09-26 08:41:11.758743', '2023-09-26 08:41:11.758743');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (210, 210, '01.120', '90.012', NULL, '2023-09-26 08:41:11.76262', '2023-09-26 08:41:11.76262');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (211, 211, '01.120', NULL, NULL, '2023-09-26 08:41:11.766067', '2023-09-26 08:41:11.766067');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (212, 212, '01.120', '90.012', NULL, '2023-09-26 08:41:11.770088', '2023-09-26 08:41:11.770088');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (213, 213, '01.120', '90.012', NULL, '2023-09-26 08:41:11.773409', '2023-09-26 08:41:11.773409');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (214, 214, '01.120', NULL, NULL, '2023-09-26 08:41:11.798181', '2023-09-26 08:41:11.798181');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (215, 215, '01.120', NULL, NULL, '2023-09-26 08:41:11.803816', '2023-09-26 08:41:11.803816');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (216, 216, '01.120', NULL, NULL, '2023-09-26 08:41:11.80872', '2023-09-26 08:41:11.80872');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (217, 217, '01.120', '90.012', NULL, '2023-09-26 08:41:11.812753', '2023-09-26 08:41:11.812753');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (218, 218, '01.120', '90.012', NULL, '2023-09-26 08:41:11.816077', '2023-09-26 08:41:11.816077');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (219, 219, '01.120', '90.012', '70.220', '2023-09-26 08:41:11.820496', '2023-09-26 08:41:11.820496');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (220, 220, '01.120', '90.012', '70.220', '2023-09-26 08:41:11.823644', '2023-09-26 08:41:11.823644');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (221, 221, '01.120', '90.012', '70.220', '2023-09-26 08:41:11.828295', '2023-09-26 08:41:11.828295');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (222, 222, '01.120', NULL, NULL, '2023-09-26 08:41:11.831973', '2023-09-26 08:41:11.831973');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (223, 223, '01.120', '90.012', NULL, '2023-09-26 08:41:11.835486', '2023-09-26 08:41:11.835486');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (224, 224, '01.120', NULL, NULL, '2023-09-26 08:41:11.839593', '2023-09-26 08:41:11.839593');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (225, 225, '01.120', NULL, NULL, '2023-09-26 08:41:11.844627', '2023-09-26 08:41:11.844627');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (226, 226, '01.120', NULL, NULL, '2023-09-26 08:41:11.849453', '2023-09-26 08:41:11.849453');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (227, 227, '01.120', NULL, NULL, '2023-09-26 08:41:11.854537', '2023-09-26 08:41:11.854537');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (228, 228, '01.120', '90.012', NULL, '2023-09-26 08:41:11.858766', '2023-09-26 08:41:11.858766');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (229, 229, '01.120', '90.012', NULL, '2023-09-26 08:41:11.863054', '2023-09-26 08:41:11.863054');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (230, 230, '01.120', '90.012', NULL, '2023-09-26 08:41:11.866633', '2023-09-26 08:41:11.866633');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (231, 231, '01.120', NULL, NULL, '2023-09-26 08:41:11.870433', '2023-09-26 08:41:11.870433');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (232, 232, '01.120', '90.012', '70.220', '2023-09-26 08:41:11.874227', '2023-09-26 08:41:11.874227');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (233, 233, '01.120', '90.012', NULL, '2023-09-26 08:41:11.878464', '2023-09-26 08:41:11.878464');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (234, 234, '01.120', '90.012', '70.220', '2023-09-26 08:41:11.882652', '2023-09-26 08:41:11.882652');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (235, 235, '01.120', '90.012', NULL, '2023-09-26 08:41:11.887055', '2023-09-26 08:41:11.887055');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (236, 236, '01.120', NULL, NULL, '2023-09-26 08:41:11.893403', '2023-09-26 08:41:11.893403');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (237, 237, '01.120', NULL, NULL, '2023-09-26 08:41:11.897644', '2023-09-26 08:41:11.897644');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (238, 238, '01.120', '90.012', NULL, '2023-09-26 08:41:11.904465', '2023-09-26 08:41:11.904465');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (239, 239, '01.120', '90.012', NULL, '2023-09-26 08:41:11.910322', '2023-09-26 08:41:11.910322');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (240, 240, '01.120', '90.012', NULL, '2023-09-26 08:41:11.91526', '2023-09-26 08:41:11.91526');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (241, 241, '01.120', NULL, NULL, '2023-09-26 08:41:11.919164', '2023-09-26 08:41:11.919164');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (242, 242, '01.120', '90.012', NULL, '2023-09-26 08:41:11.922244', '2023-09-26 08:41:11.922244');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (243, 243, '01.120', NULL, NULL, '2023-09-26 08:41:11.926736', '2023-09-26 08:41:11.926736');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (244, 244, '01.120', NULL, NULL, '2023-09-26 08:41:11.930894', '2023-09-26 08:41:11.930894');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (245, 245, '01.120', NULL, NULL, '2023-09-26 08:41:11.936691', '2023-09-26 08:41:11.936691');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (246, 246, '01.120', NULL, NULL, '2023-09-26 08:41:11.943868', '2023-09-26 08:41:11.943868');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (247, 247, '01.120', '90.012', '70.220', '2023-09-26 08:41:11.950476', '2023-09-26 08:41:11.950476');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (248, 248, '01.120', NULL, NULL, '2023-09-26 08:41:11.95782', '2023-09-26 08:41:11.95782');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (249, 249, '01.120', NULL, NULL, '2023-09-26 08:41:11.967703', '2023-09-26 08:41:11.967703');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (250, 250, '01.120', '90.012', NULL, '2023-09-26 08:41:11.97618', '2023-09-26 08:41:11.97618');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (251, 251, '01.120', NULL, NULL, '2023-09-26 08:41:11.984524', '2023-09-26 08:41:11.984524');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (252, 252, '01.120', '90.012', NULL, '2023-09-26 08:41:12.002814', '2023-09-26 08:41:12.002814');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (253, 253, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.012204', '2023-09-26 08:41:12.012204');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (254, 254, '01.120', '90.012', NULL, '2023-09-26 08:41:12.020033', '2023-09-26 08:41:12.020033');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (255, 255, '01.120', NULL, NULL, '2023-09-26 08:41:12.031537', '2023-09-26 08:41:12.031537');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (256, 256, '01.120', '90.012', NULL, '2023-09-26 08:41:12.039457', '2023-09-26 08:41:12.039457');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (257, 257, '01.120', '90.012', NULL, '2023-09-26 08:41:12.042908', '2023-09-26 08:41:12.042908');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (258, 258, '01.120', NULL, NULL, '2023-09-26 08:41:12.046693', '2023-09-26 08:41:12.046693');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (259, 259, '01.120', NULL, NULL, '2023-09-26 08:41:12.0521', '2023-09-26 08:41:12.0521');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (260, 260, '01.120', NULL, NULL, '2023-09-26 08:41:12.055131', '2023-09-26 08:41:12.055131');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (261, 261, '01.120', NULL, NULL, '2023-09-26 08:41:12.059134', '2023-09-26 08:41:12.059134');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (262, 262, '01.120', '90.012', NULL, '2023-09-26 08:41:12.063503', '2023-09-26 08:41:12.063503');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (263, 263, '01.120', NULL, NULL, '2023-09-26 08:41:12.06802', '2023-09-26 08:41:12.06802');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (264, 264, '01.120', '90.012', NULL, '2023-09-26 08:41:12.071881', '2023-09-26 08:41:12.071881');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (265, 265, '01.120', '90.012', NULL, '2023-09-26 08:41:12.075556', '2023-09-26 08:41:12.075556');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (266, 266, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.080043', '2023-09-26 08:41:12.080043');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (267, 267, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.084769', '2023-09-26 08:41:12.084769');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (268, 268, '01.120', NULL, NULL, '2023-09-26 08:41:12.088995', '2023-09-26 08:41:12.088995');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (269, 269, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.093114', '2023-09-26 08:41:12.093114');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (270, 270, '01.120', '90.012', NULL, '2023-09-26 08:41:12.096487', '2023-09-26 08:41:12.096487');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (271, 271, '01.120', NULL, NULL, '2023-09-26 08:41:12.100487', '2023-09-26 08:41:12.100487');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (272, 272, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.104546', '2023-09-26 08:41:12.104546');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (273, 273, '01.120', NULL, NULL, '2023-09-26 08:41:12.108703', '2023-09-26 08:41:12.108703');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (274, 274, '01.120', NULL, NULL, '2023-09-26 08:41:12.123944', '2023-09-26 08:41:12.123944');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (275, 275, '01.120', '90.012', NULL, '2023-09-26 08:41:12.128099', '2023-09-26 08:41:12.128099');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (276, 276, '01.120', NULL, NULL, '2023-09-26 08:41:12.132537', '2023-09-26 08:41:12.132537');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (277, 277, '01.120', '90.012', NULL, '2023-09-26 08:41:12.137599', '2023-09-26 08:41:12.137599');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (278, 278, '01.120', NULL, NULL, '2023-09-26 08:41:12.142128', '2023-09-26 08:41:12.142128');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (279, 279, '01.120', '90.012', NULL, '2023-09-26 08:41:12.146511', '2023-09-26 08:41:12.146511');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (280, 280, '01.120', '90.012', NULL, '2023-09-26 08:41:12.150611', '2023-09-26 08:41:12.150611');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (281, 281, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.154109', '2023-09-26 08:41:12.154109');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (282, 282, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.158428', '2023-09-26 08:41:12.158428');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (283, 283, '01.120', '90.012', NULL, '2023-09-26 08:41:12.161446', '2023-09-26 08:41:12.161446');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (284, 284, '01.120', NULL, NULL, '2023-09-26 08:41:12.166209', '2023-09-26 08:41:12.166209');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (285, 285, '01.120', '90.012', NULL, '2023-09-26 08:41:12.170798', '2023-09-26 08:41:12.170798');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (286, 286, '01.120', NULL, NULL, '2023-09-26 08:41:12.175211', '2023-09-26 08:41:12.175211');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (287, 287, '01.120', '90.012', NULL, '2023-09-26 08:41:12.178379', '2023-09-26 08:41:12.178379');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (288, 288, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.1817', '2023-09-26 08:41:12.1817');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (289, 289, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.185692', '2023-09-26 08:41:12.185692');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (290, 290, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.189323', '2023-09-26 08:41:12.189323');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (291, 291, '01.120', '90.012', NULL, '2023-09-26 08:41:12.192091', '2023-09-26 08:41:12.192091');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (292, 292, '01.120', '90.012', NULL, '2023-09-26 08:41:12.213427', '2023-09-26 08:41:12.213427');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (293, 293, '01.120', NULL, NULL, '2023-09-26 08:41:12.21801', '2023-09-26 08:41:12.21801');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (294, 294, '01.120', '90.012', NULL, '2023-09-26 08:41:12.221197', '2023-09-26 08:41:12.221197');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (295, 295, '01.120', NULL, NULL, '2023-09-26 08:41:12.225807', '2023-09-26 08:41:12.225807');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (296, 296, '01.120', NULL, NULL, '2023-09-26 08:41:12.230472', '2023-09-26 08:41:12.230472');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (297, 297, '01.120', '90.012', NULL, '2023-09-26 08:41:12.233161', '2023-09-26 08:41:12.233161');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (298, 298, '01.120', NULL, NULL, '2023-09-26 08:41:12.235876', '2023-09-26 08:41:12.235876');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (299, 299, '01.120', NULL, NULL, '2023-09-26 08:41:12.240868', '2023-09-26 08:41:12.240868');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (300, 300, '01.120', '90.012', NULL, '2023-09-26 08:41:12.24567', '2023-09-26 08:41:12.24567');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (301, 301, '01.120', '90.012', NULL, '2023-09-26 08:41:12.250276', '2023-09-26 08:41:12.250276');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (302, 302, '01.120', NULL, NULL, '2023-09-26 08:41:12.253949', '2023-09-26 08:41:12.253949');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (303, 303, '01.120', '90.012', NULL, '2023-09-26 08:41:12.257573', '2023-09-26 08:41:12.257573');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (304, 304, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.26207', '2023-09-26 08:41:12.26207');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (305, 305, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.268088', '2023-09-26 08:41:12.268088');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (306, 306, '01.120', '90.012', NULL, '2023-09-26 08:41:12.272394', '2023-09-26 08:41:12.272394');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (307, 307, '01.120', NULL, NULL, '2023-09-26 08:41:12.276947', '2023-09-26 08:41:12.276947');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (308, 308, '01.120', NULL, NULL, '2023-09-26 08:41:12.280801', '2023-09-26 08:41:12.280801');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (309, 309, '01.120', NULL, NULL, '2023-09-26 08:41:12.284598', '2023-09-26 08:41:12.284598');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (310, 310, '01.120', NULL, NULL, '2023-09-26 08:41:12.288126', '2023-09-26 08:41:12.288126');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (311, 311, '01.120', NULL, NULL, '2023-09-26 08:41:12.291905', '2023-09-26 08:41:12.291905');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (312, 312, '01.120', '90.012', NULL, '2023-09-26 08:41:12.295501', '2023-09-26 08:41:12.295501');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (313, 313, '01.120', NULL, NULL, '2023-09-26 08:41:12.299996', '2023-09-26 08:41:12.299996');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (314, 314, '01.120', NULL, NULL, '2023-09-26 08:41:12.303704', '2023-09-26 08:41:12.303704');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (315, 315, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.307614', '2023-09-26 08:41:12.307614');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (316, 316, '01.120', '90.012', NULL, '2023-09-26 08:41:12.313658', '2023-09-26 08:41:12.313658');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (317, 317, '01.120', '90.012', NULL, '2023-09-26 08:41:12.318232', '2023-09-26 08:41:12.318232');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (318, 318, '01.120', '90.012', NULL, '2023-09-26 08:41:12.32288', '2023-09-26 08:41:12.32288');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (319, 319, '01.120', NULL, NULL, '2023-09-26 08:41:12.33062', '2023-09-26 08:41:12.33062');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (320, 320, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.334309', '2023-09-26 08:41:12.334309');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (321, 321, '01.120', '90.012', NULL, '2023-09-26 08:41:12.337817', '2023-09-26 08:41:12.337817');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (322, 322, '01.120', '90.012', NULL, '2023-09-26 08:41:12.342107', '2023-09-26 08:41:12.342107');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (323, 323, '01.120', NULL, NULL, '2023-09-26 08:41:12.346345', '2023-09-26 08:41:12.346345');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (324, 324, '01.120', NULL, NULL, '2023-09-26 08:41:12.349678', '2023-09-26 08:41:12.349678');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (325, 325, '01.120', NULL, NULL, '2023-09-26 08:41:12.353044', '2023-09-26 08:41:12.353044');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (326, 326, '01.120', '90.012', NULL, '2023-09-26 08:41:12.356977', '2023-09-26 08:41:12.356977');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (327, 327, '01.120', '90.012', NULL, '2023-09-26 08:41:12.360855', '2023-09-26 08:41:12.360855');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (328, 328, '01.120', NULL, NULL, '2023-09-26 08:41:12.368692', '2023-09-26 08:41:12.368692');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (329, 329, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.37611', '2023-09-26 08:41:12.37611');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (330, 330, '01.120', NULL, NULL, '2023-09-26 08:41:12.381284', '2023-09-26 08:41:12.381284');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (331, 331, '01.120', NULL, NULL, '2023-09-26 08:41:12.38484', '2023-09-26 08:41:12.38484');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (332, 332, '01.120', NULL, NULL, '2023-09-26 08:41:12.388053', '2023-09-26 08:41:12.388053');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (333, 333, '01.120', NULL, NULL, '2023-09-26 08:41:12.393376', '2023-09-26 08:41:12.393376');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (334, 334, '01.120', '90.012', NULL, '2023-09-26 08:41:12.397859', '2023-09-26 08:41:12.397859');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (335, 335, '01.120', NULL, NULL, '2023-09-26 08:41:12.403798', '2023-09-26 08:41:12.403798');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (336, 336, '01.120', NULL, NULL, '2023-09-26 08:41:12.408199', '2023-09-26 08:41:12.408199');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (337, 337, '01.120', '90.012', NULL, '2023-09-26 08:41:12.41368', '2023-09-26 08:41:12.41368');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (338, 338, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.417473', '2023-09-26 08:41:12.417473');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (339, 339, '01.120', '90.012', NULL, '2023-09-26 08:41:12.421859', '2023-09-26 08:41:12.421859');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (340, 340, '01.120', '90.012', NULL, '2023-09-26 08:41:12.424427', '2023-09-26 08:41:12.424427');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (341, 341, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.430075', '2023-09-26 08:41:12.430075');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (342, 342, '01.120', NULL, NULL, '2023-09-26 08:41:12.434552', '2023-09-26 08:41:12.434552');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (343, 343, '01.120', NULL, NULL, '2023-09-26 08:41:12.441425', '2023-09-26 08:41:12.441425');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (344, 344, '01.120', NULL, NULL, '2023-09-26 08:41:12.446767', '2023-09-26 08:41:12.446767');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (345, 345, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.453115', '2023-09-26 08:41:12.453115');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (346, 346, '01.120', '90.012', NULL, '2023-09-26 08:41:12.460297', '2023-09-26 08:41:12.460297');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (347, 347, '01.120', '90.012', NULL, '2023-09-26 08:41:12.465449', '2023-09-26 08:41:12.465449');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (348, 348, '01.120', NULL, NULL, '2023-09-26 08:41:12.471078', '2023-09-26 08:41:12.471078');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (349, 349, '01.120', NULL, NULL, '2023-09-26 08:41:12.476574', '2023-09-26 08:41:12.476574');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (350, 350, '01.120', '90.012', NULL, '2023-09-26 08:41:12.480971', '2023-09-26 08:41:12.480971');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (351, 351, '01.120', '90.012', NULL, '2023-09-26 08:41:12.485651', '2023-09-26 08:41:12.485651');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (352, 352, '01.120', NULL, NULL, '2023-09-26 08:41:12.497599', '2023-09-26 08:41:12.497599');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (353, 353, '01.120', NULL, NULL, '2023-09-26 08:41:12.510743', '2023-09-26 08:41:12.510743');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (354, 354, '01.120', '90.012', NULL, '2023-09-26 08:41:12.513261', '2023-09-26 08:41:12.513261');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (355, 355, '01.120', NULL, NULL, '2023-09-26 08:41:12.520406', '2023-09-26 08:41:12.520406');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (356, 356, '01.120', NULL, NULL, '2023-09-26 08:41:12.524399', '2023-09-26 08:41:12.524399');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (357, 357, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.546346', '2023-09-26 08:41:12.546346');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (358, 358, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.551074', '2023-09-26 08:41:12.551074');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (359, 359, '01.120', NULL, NULL, '2023-09-26 08:41:12.555897', '2023-09-26 08:41:12.555897');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (360, 360, '01.120', NULL, NULL, '2023-09-26 08:41:12.560399', '2023-09-26 08:41:12.560399');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (361, 361, '01.120', '90.012', NULL, '2023-09-26 08:41:12.563892', '2023-09-26 08:41:12.563892');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (362, 362, '01.120', '90.012', NULL, '2023-09-26 08:41:12.568747', '2023-09-26 08:41:12.568747');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (363, 363, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.574214', '2023-09-26 08:41:12.574214');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (364, 364, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.578516', '2023-09-26 08:41:12.578516');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (365, 365, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.582141', '2023-09-26 08:41:12.582141');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (366, 366, '01.120', '90.012', NULL, '2023-09-26 08:41:12.585551', '2023-09-26 08:41:12.585551');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (367, 367, '01.120', '90.012', NULL, '2023-09-26 08:41:12.58838', '2023-09-26 08:41:12.58838');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (368, 368, '01.120', NULL, NULL, '2023-09-26 08:41:12.594084', '2023-09-26 08:41:12.594084');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (369, 369, '01.120', '90.012', NULL, '2023-09-26 08:41:12.597054', '2023-09-26 08:41:12.597054');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (370, 370, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.60055', '2023-09-26 08:41:12.60055');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (371, 371, '01.120', NULL, NULL, '2023-09-26 08:41:12.605207', '2023-09-26 08:41:12.605207');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (372, 372, '01.120', NULL, NULL, '2023-09-26 08:41:12.611319', '2023-09-26 08:41:12.611319');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (373, 373, '01.120', '90.012', NULL, '2023-09-26 08:41:12.615121', '2023-09-26 08:41:12.615121');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (374, 374, '01.120', '90.012', NULL, '2023-09-26 08:41:12.618404', '2023-09-26 08:41:12.618404');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (375, 375, '01.120', NULL, NULL, '2023-09-26 08:41:12.640086', '2023-09-26 08:41:12.640086');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (376, 376, '01.120', NULL, NULL, '2023-09-26 08:41:12.643558', '2023-09-26 08:41:12.643558');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (377, 377, '01.120', NULL, NULL, '2023-09-26 08:41:12.645688', '2023-09-26 08:41:12.645688');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (378, 378, '01.120', '90.012', NULL, '2023-09-26 08:41:12.64921', '2023-09-26 08:41:12.64921');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (379, 379, '01.120', NULL, NULL, '2023-09-26 08:41:12.65499', '2023-09-26 08:41:12.65499');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (380, 380, '01.120', NULL, NULL, '2023-09-26 08:41:12.659922', '2023-09-26 08:41:12.659922');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (381, 381, '01.120', NULL, NULL, '2023-09-26 08:41:12.662136', '2023-09-26 08:41:12.662136');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (382, 382, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.67166', '2023-09-26 08:41:12.67166');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (383, 383, '01.120', NULL, NULL, '2023-09-26 08:41:12.680185', '2023-09-26 08:41:12.680185');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (384, 384, '01.120', '90.012', NULL, '2023-09-26 08:41:12.684856', '2023-09-26 08:41:12.684856');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (385, 385, '01.120', '90.012', NULL, '2023-09-26 08:41:12.689468', '2023-09-26 08:41:12.689468');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (386, 386, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.692786', '2023-09-26 08:41:12.692786');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (387, 387, '01.120', '90.012', NULL, '2023-09-26 08:41:12.697985', '2023-09-26 08:41:12.697985');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (388, 388, '01.120', NULL, NULL, '2023-09-26 08:41:12.703453', '2023-09-26 08:41:12.703453');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (389, 389, '01.120', NULL, NULL, '2023-09-26 08:41:12.708195', '2023-09-26 08:41:12.708195');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (390, 390, '01.120', NULL, NULL, '2023-09-26 08:41:12.711826', '2023-09-26 08:41:12.711826');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (391, 391, '01.120', NULL, NULL, '2023-09-26 08:41:12.716499', '2023-09-26 08:41:12.716499');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (392, 392, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.719956', '2023-09-26 08:41:12.719956');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (393, 393, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.723323', '2023-09-26 08:41:12.723323');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (394, 394, '01.120', '90.012', NULL, '2023-09-26 08:41:12.726437', '2023-09-26 08:41:12.726437');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (395, 395, '01.120', '90.012', NULL, '2023-09-26 08:41:12.73087', '2023-09-26 08:41:12.73087');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (396, 396, '01.120', NULL, NULL, '2023-09-26 08:41:12.735323', '2023-09-26 08:41:12.735323');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (397, 397, '01.120', NULL, NULL, '2023-09-26 08:41:12.739933', '2023-09-26 08:41:12.739933');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (398, 398, '01.120', '90.012', NULL, '2023-09-26 08:41:12.743712', '2023-09-26 08:41:12.743712');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (399, 399, '01.120', NULL, NULL, '2023-09-26 08:41:12.74746', '2023-09-26 08:41:12.74746');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (400, 400, '01.120', NULL, NULL, '2023-09-26 08:41:12.751241', '2023-09-26 08:41:12.751241');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (401, 401, '01.120', NULL, NULL, '2023-09-26 08:41:12.754556', '2023-09-26 08:41:12.754556');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (402, 402, '01.120', NULL, NULL, '2023-09-26 08:41:12.757823', '2023-09-26 08:41:12.757823');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (403, 403, '01.120', '90.012', NULL, '2023-09-26 08:41:12.762665', '2023-09-26 08:41:12.762665');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (404, 404, '01.120', '90.012', NULL, '2023-09-26 08:41:12.767711', '2023-09-26 08:41:12.767711');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (405, 405, '01.120', NULL, NULL, '2023-09-26 08:41:12.771582', '2023-09-26 08:41:12.771582');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (406, 406, '01.120', NULL, NULL, '2023-09-26 08:41:12.776092', '2023-09-26 08:41:12.776092');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (407, 407, '01.120', NULL, NULL, '2023-09-26 08:41:12.779036', '2023-09-26 08:41:12.779036');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (408, 408, '01.120', NULL, NULL, '2023-09-26 08:41:12.783037', '2023-09-26 08:41:12.783037');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (409, 409, '01.120', '90.012', NULL, '2023-09-26 08:41:12.787462', '2023-09-26 08:41:12.787462');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (410, 410, '01.120', NULL, NULL, '2023-09-26 08:41:12.792122', '2023-09-26 08:41:12.792122');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (411, 411, '01.120', '90.012', NULL, '2023-09-26 08:41:12.795867', '2023-09-26 08:41:12.795867');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (412, 412, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.80102', '2023-09-26 08:41:12.80102');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (413, 413, '01.120', NULL, NULL, '2023-09-26 08:41:12.805243', '2023-09-26 08:41:12.805243');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (414, 414, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.80998', '2023-09-26 08:41:12.80998');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (415, 415, '01.120', NULL, NULL, '2023-09-26 08:41:12.814249', '2023-09-26 08:41:12.814249');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (416, 416, '01.120', NULL, NULL, '2023-09-26 08:41:12.818549', '2023-09-26 08:41:12.818549');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (417, 417, '01.120', '90.012', NULL, '2023-09-26 08:41:12.822017', '2023-09-26 08:41:12.822017');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (418, 418, '01.120', NULL, NULL, '2023-09-26 08:41:12.826563', '2023-09-26 08:41:12.826563');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (419, 419, '01.120', '90.012', NULL, '2023-09-26 08:41:12.829984', '2023-09-26 08:41:12.829984');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (420, 420, '01.120', NULL, NULL, '2023-09-26 08:41:12.833369', '2023-09-26 08:41:12.833369');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (421, 421, '01.120', NULL, NULL, '2023-09-26 08:41:12.838603', '2023-09-26 08:41:12.838603');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (422, 422, '01.120', '90.012', NULL, '2023-09-26 08:41:12.844066', '2023-09-26 08:41:12.844066');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (423, 423, '01.120', NULL, NULL, '2023-09-26 08:41:12.847828', '2023-09-26 08:41:12.847828');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (424, 424, '01.120', '90.012', NULL, '2023-09-26 08:41:12.851671', '2023-09-26 08:41:12.851671');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (425, 425, '01.120', NULL, NULL, '2023-09-26 08:41:12.854856', '2023-09-26 08:41:12.854856');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (426, 426, '01.120', '90.012', NULL, '2023-09-26 08:41:12.858171', '2023-09-26 08:41:12.858171');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (427, 427, '01.120', '90.012', NULL, '2023-09-26 08:41:12.862315', '2023-09-26 08:41:12.862315');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (428, 428, '01.120', NULL, NULL, '2023-09-26 08:41:12.865777', '2023-09-26 08:41:12.865777');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (429, 429, '01.120', NULL, NULL, '2023-09-26 08:41:12.869845', '2023-09-26 08:41:12.869845');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (430, 430, '01.120', NULL, NULL, '2023-09-26 08:41:12.873396', '2023-09-26 08:41:12.873396');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (431, 431, '01.120', NULL, NULL, '2023-09-26 08:41:12.877997', '2023-09-26 08:41:12.877997');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (432, 432, '01.120', NULL, NULL, '2023-09-26 08:41:12.882667', '2023-09-26 08:41:12.882667');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (433, 433, '01.120', '90.012', NULL, '2023-09-26 08:41:12.885252', '2023-09-26 08:41:12.885252');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (434, 434, '01.120', NULL, NULL, '2023-09-26 08:41:12.915823', '2023-09-26 08:41:12.915823');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (435, 435, '01.120', NULL, NULL, '2023-09-26 08:41:12.919822', '2023-09-26 08:41:12.919822');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (436, 436, '01.120', NULL, NULL, '2023-09-26 08:41:12.935509', '2023-09-26 08:41:12.935509');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (437, 437, '01.120', NULL, NULL, '2023-09-26 08:41:12.945211', '2023-09-26 08:41:12.945211');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (438, 438, '01.120', NULL, NULL, '2023-09-26 08:41:12.949872', '2023-09-26 08:41:12.949872');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (439, 439, '01.120', NULL, NULL, '2023-09-26 08:41:12.953952', '2023-09-26 08:41:12.953952');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (440, 440, '01.120', '90.012', '70.220', '2023-09-26 08:41:12.958183', '2023-09-26 08:41:12.958183');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (441, 441, '01.120', '90.012', NULL, '2023-09-26 08:41:12.964856', '2023-09-26 08:41:12.964856');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (442, 442, '01.120', '90.012', NULL, '2023-09-26 08:41:12.968235', '2023-09-26 08:41:12.968235');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (443, 443, '01.120', '90.012', NULL, '2023-09-26 08:41:12.974533', '2023-09-26 08:41:12.974533');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (444, 444, '01.120', '90.012', NULL, '2023-09-26 08:41:12.98021', '2023-09-26 08:41:12.98021');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (445, 445, '01.120', NULL, NULL, '2023-09-26 08:41:12.984144', '2023-09-26 08:41:12.984144');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (446, 446, '01.120', '90.012', NULL, '2023-09-26 08:41:12.989754', '2023-09-26 08:41:12.989754');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (447, 447, '01.120', '90.012', NULL, '2023-09-26 08:41:12.994481', '2023-09-26 08:41:12.994481');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (448, 448, '01.120', '90.012', NULL, '2023-09-26 08:41:12.99847', '2023-09-26 08:41:12.99847');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (449, 449, '01.120', NULL, NULL, '2023-09-26 08:41:13.003196', '2023-09-26 08:41:13.003196');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (450, 450, '01.120', NULL, NULL, '2023-09-26 08:41:13.006781', '2023-09-26 08:41:13.006781');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (451, 451, '01.120', '90.012', NULL, '2023-09-26 08:41:13.011708', '2023-09-26 08:41:13.011708');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (452, 452, '01.120', '90.012', NULL, '2023-09-26 08:41:13.015548', '2023-09-26 08:41:13.015548');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (453, 453, '01.120', '90.012', NULL, '2023-09-26 08:41:13.020273', '2023-09-26 08:41:13.020273');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (454, 454, '01.120', '90.012', NULL, '2023-09-26 08:41:13.023708', '2023-09-26 08:41:13.023708');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (455, 455, '01.120', '90.012', NULL, '2023-09-26 08:41:13.026536', '2023-09-26 08:41:13.026536');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (456, 456, '01.120', NULL, NULL, '2023-09-26 08:41:13.031418', '2023-09-26 08:41:13.031418');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (457, 457, '01.120', NULL, NULL, '2023-09-26 08:41:13.048768', '2023-09-26 08:41:13.048768');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (458, 458, '01.120', NULL, NULL, '2023-09-26 08:41:13.054063', '2023-09-26 08:41:13.054063');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (459, 459, '01.120', '90.012', '70.220', '2023-09-26 08:41:13.056879', '2023-09-26 08:41:13.056879');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (460, 460, '01.120', '90.012', NULL, '2023-09-26 08:41:13.060464', '2023-09-26 08:41:13.060464');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (461, 461, '01.120', '90.012', NULL, '2023-09-26 08:41:13.063329', '2023-09-26 08:41:13.063329');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (462, 462, '01.120', '90.012', '70.220', '2023-09-26 08:41:13.066883', '2023-09-26 08:41:13.066883');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (463, 463, '01.120', '90.012', NULL, '2023-09-26 08:41:13.070415', '2023-09-26 08:41:13.070415');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (464, 464, '01.120', '90.012', NULL, '2023-09-26 08:41:13.072972', '2023-09-26 08:41:13.072972');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (465, 465, '01.120', '90.012', NULL, '2023-09-26 08:41:13.076088', '2023-09-26 08:41:13.076088');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (466, 466, '01.120', NULL, NULL, '2023-09-26 08:41:13.07957', '2023-09-26 08:41:13.07957');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (467, 467, '01.120', NULL, NULL, '2023-09-26 08:41:13.082677', '2023-09-26 08:41:13.082677');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (468, 468, '01.120', NULL, NULL, '2023-09-26 08:41:13.085877', '2023-09-26 08:41:13.085877');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (469, 469, '01.120', '90.012', '70.220', '2023-09-26 08:41:13.0893', '2023-09-26 08:41:13.0893');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (470, 470, '01.120', NULL, NULL, '2023-09-26 08:41:13.093772', '2023-09-26 08:41:13.093772');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (471, 471, '01.120', '90.012', NULL, '2023-09-26 08:41:13.097051', '2023-09-26 08:41:13.097051');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (472, 472, '01.120', NULL, NULL, '2023-09-26 08:41:13.100058', '2023-09-26 08:41:13.100058');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (473, 473, '01.120', '90.012', '70.220', '2023-09-26 08:41:13.103019', '2023-09-26 08:41:13.103019');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (474, 474, '01.120', '90.012', '70.220', '2023-09-26 08:41:13.106315', '2023-09-26 08:41:13.106315');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (475, 475, '01.120', '90.012', '70.220', '2023-09-26 08:41:13.10916', '2023-09-26 08:41:13.10916');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (476, 476, '01.120', '90.012', '70.220', '2023-09-26 08:41:13.112212', '2023-09-26 08:41:13.112212');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (477, 477, '01.120', NULL, NULL, '2023-09-26 08:41:13.115143', '2023-09-26 08:41:13.115143');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (478, 478, '01.120', '90.012', NULL, '2023-09-26 08:41:13.119628', '2023-09-26 08:41:13.119628');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (479, 479, '01.120', NULL, NULL, '2023-09-26 08:41:13.122603', '2023-09-26 08:41:13.122603');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (480, 480, '01.120', '90.012', '70.220', '2023-09-26 08:41:13.125283', '2023-09-26 08:41:13.125283');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (481, 481, '01.120', '90.012', '70.220', '2023-09-26 08:41:13.128032', '2023-09-26 08:41:13.128032');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (482, 482, '01.120', NULL, NULL, '2023-09-26 08:41:13.132594', '2023-09-26 08:41:13.132594');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (483, 483, '01.120', NULL, NULL, '2023-09-26 08:41:13.135396', '2023-09-26 08:41:13.135396');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (484, 484, '01.120', NULL, NULL, '2023-09-26 08:41:13.138161', '2023-09-26 08:41:13.138161');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (485, 485, '01.120', NULL, NULL, '2023-09-26 08:41:13.141014', '2023-09-26 08:41:13.141014');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (486, 486, '01.120', NULL, NULL, '2023-09-26 08:41:13.149872', '2023-09-26 08:41:13.149872');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (487, 487, '01.120', '90.012', '70.220', '2023-09-26 08:41:13.1526', '2023-09-26 08:41:13.1526');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (488, 488, '01.120', NULL, NULL, '2023-09-26 08:41:13.156782', '2023-09-26 08:41:13.156782');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (489, 489, '01.120', '90.012', '70.220', '2023-09-26 08:41:13.159346', '2023-09-26 08:41:13.159346');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (490, 490, '01.120', NULL, NULL, '2023-09-26 08:41:13.161938', '2023-09-26 08:41:13.161938');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (491, 491, '01.120', '90.012', NULL, '2023-09-26 08:41:13.164594', '2023-09-26 08:41:13.164594');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (492, 492, '01.120', NULL, NULL, '2023-09-26 08:41:13.167811', '2023-09-26 08:41:13.167811');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (493, 493, '01.120', '90.012', '70.220', '2023-09-26 08:41:13.171504', '2023-09-26 08:41:13.171504');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (494, 494, '01.120', NULL, NULL, '2023-09-26 08:41:13.17405', '2023-09-26 08:41:13.17405');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (495, 495, '01.120', '90.012', '70.220', '2023-09-26 08:41:13.176929', '2023-09-26 08:41:13.176929');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (496, 496, '01.120', '90.012', '70.220', '2023-09-26 08:41:13.179879', '2023-09-26 08:41:13.179879');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (497, 497, '01.120', NULL, NULL, '2023-09-26 08:41:13.183251', '2023-09-26 08:41:13.183251');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (498, 498, '01.120', '90.012', NULL, '2023-09-26 08:41:13.184972', '2023-09-26 08:41:13.184972');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (499, 499, '01.120', NULL, NULL, '2023-09-26 08:41:13.188864', '2023-09-26 08:41:13.188864');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (500, 500, '01.120', '90.012', '70.220', '2023-09-26 08:41:13.192475', '2023-09-26 08:41:13.192475');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (501, 501, '01.120', '90.012', NULL, '2023-09-26 08:41:13.195605', '2023-09-26 08:41:13.195605');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (502, 502, '01.120', '90.012', '70.220', '2023-09-26 08:41:13.198885', '2023-09-26 08:41:13.198885');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (503, 503, '01.120', NULL, NULL, '2023-09-26 08:41:13.202596', '2023-09-26 08:41:13.202596');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (504, 504, '01.120', '90.012', NULL, '2023-09-26 08:41:13.20506', '2023-09-26 08:41:13.20506');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (505, 505, '01.120', NULL, NULL, '2023-09-26 08:41:13.210548', '2023-09-26 08:41:13.210548');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (506, 506, '01.120', '90.012', NULL, '2023-09-26 08:41:13.214391', '2023-09-26 08:41:13.214391');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (507, 507, '01.120', '90.012', '70.220', '2023-09-26 08:41:13.221191', '2023-09-26 08:41:13.221191');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (508, 508, '01.120', '90.012', '70.220', '2023-09-26 08:41:13.224242', '2023-09-26 08:41:13.224242');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (509, 509, '01.120', NULL, NULL, '2023-09-26 08:41:13.226806', '2023-09-26 08:41:13.226806');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (510, 510, '01.120', NULL, NULL, '2023-09-26 08:41:13.239098', '2023-09-26 08:41:13.239098');


--
-- Data for Name: virksomhet_statistikk_metadata; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet_statistikk_metadata VALUES (1, '987654321', 'VIRKSOMHET', '1', '2023-09-26 08:41:16.741525');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (3, '123456789', 'VIRKSOMHET', '1', '2023-09-26 08:41:16.779857');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (23, '555555555', 'VIRKSOMHET', '1', '2023-09-26 08:41:16.872481');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (24, '857241581', 'VIRKSOMHET', '1', '2023-09-26 08:41:16.885821');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (26, '867365117', 'VIRKSOMHET', '1', '2023-09-26 08:41:16.900478');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (28, '881114246', 'VIRKSOMHET', '1', '2023-09-26 08:41:16.900478');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (30, '891771817', 'VIRKSOMHET', '1', '2023-09-26 08:41:16.918099');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (32, '898525058', 'VIRKSOMHET', '1', '2023-09-26 08:41:16.918099');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (33, '835220383', 'VIRKSOMHET', '3', '2023-09-26 08:41:16.92985');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (34, '878746520', 'VIRKSOMHET', '2', '2023-09-26 08:41:16.92985');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (35, '883329944', 'VIRKSOMHET', '3', '2023-09-26 08:41:16.92985');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (36, '852437928', 'VIRKSOMHET', '1', '2023-09-26 08:41:16.942664');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (37, '895309223', 'VIRKSOMHET', '9', '2023-09-26 08:41:16.942664');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (38, '835031049', 'VIRKSOMHET', '9', '2023-09-26 08:41:16.942664');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (39, '873220998', 'VIRKSOMHET', '1', '2023-09-26 08:41:16.962789');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (40, '835774114', 'VIRKSOMHET', '2', '2023-09-26 08:41:16.962789');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (41, '862164924', 'VIRKSOMHET', '1', '2023-09-26 08:41:16.962789');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (42, '896270090', 'VIRKSOMHET', '2', '2023-09-26 08:41:16.985351');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (43, '897255882', 'VIRKSOMHET', '9', '2023-09-26 08:41:16.985351');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (44, '848363736', 'VIRKSOMHET', '9', '2023-09-26 08:41:16.985351');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (45, '882275284', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.00734');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (46, '834436066', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.00734');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (47, '829040586', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.00734');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (48, '816209538', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.00734');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (49, '831787072', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.00734');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (50, '877257237', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.030008');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (51, '889355886', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.030008');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (52, '895626556', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.030008');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (53, '821709008', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.030008');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (54, '804237955', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.052996');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (55, '872367868', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.052996');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (56, '803742463', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.052996');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (57, '892845353', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.068055');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (58, '861622901', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.068055');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (59, '881875590', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.068055');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (60, '801835452', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.068055');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (61, '875258326', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.088489');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (62, '845784470', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.088489');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (63, '859440331', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.102354');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (64, '819479903', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.102354');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (65, '890551762', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.102354');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (66, '861778194', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.102354');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (67, '805339854', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.12662');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (68, '815390484', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.12662');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (69, '850462341', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.139825');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (70, '874452140', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.139825');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (71, '811851790', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.139825');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (72, '873515591', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.151371');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (73, '836279558', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.151371');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (74, '809727399', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.166389');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (75, '824470634', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.166389');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (76, '836516461', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.166389');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (77, '837159750', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.180548');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (78, '811866664', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.196846');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (79, '851277727', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.196846');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (80, '842226671', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.196846');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (81, '821968574', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.196846');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (82, '824580761', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.211309');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (83, '889367910', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.211309');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (84, '840237611', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.211309');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (85, '800908366', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.223791');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (86, '822930437', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.223791');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (87, '814250450', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.245132');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (88, '808744432', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.245132');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (89, '857826950', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.245132');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (90, '870623580', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.258468');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (91, '810733872', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.258468');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (92, '827935929', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.258468');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (93, '863730729', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.277658');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (94, '857184109', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.277658');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (95, '852734859', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.277658');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (96, '853594439', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.291089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (97, '818803358', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.291089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (98, '853653063', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.291089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (99, '841238334', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.304381');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (100, '813169303', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.304381');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (101, '839551215', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.304381');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (102, '880193321', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.318744');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (103, '833735069', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.318744');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (104, '859513692', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.318744');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (105, '842466076', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.333987');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (106, '894329113', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.333987');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (107, '878105030', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.351997');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (108, '801615123', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.351997');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (109, '899812147', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.369544');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (110, '867355472', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.369544');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (111, '862566596', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.369544');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (112, '848711875', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.406348');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (113, '899871018', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.406348');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (114, '834231007', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.406348');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (115, '844851816', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.406348');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (116, '883686536', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.427251');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (117, '846917560', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.427251');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (118, '819849863', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.427251');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (119, '802805958', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.427251');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (120, '893385116', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.427251');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (121, '821342624', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.427251');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (122, '807688973', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.427251');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (123, '807482958', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.427251');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (124, '840247819', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.446633');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (125, '833662191', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.446633');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (126, '857600929', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.446633');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (127, '823595968', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.470124');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (128, '828176199', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.470124');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (129, '889592815', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.5071');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (130, '876326312', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.5071');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (131, '895656026', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.5071');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (132, '866550041', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.533814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (133, '807148470', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.533814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (134, '873480135', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.533814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (135, '834244928', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.533814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (136, '867599989', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.533814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (137, '800799655', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.533814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (138, '891901027', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.533814');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (139, '897759899', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.563243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (140, '828451410', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.563243');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (141, '843216309', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.582332');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (142, '840322470', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.582332');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (143, '834850124', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.582332');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (144, '868514204', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.582332');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (145, '817793850', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.605162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (146, '812101864', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.605162');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (147, '895076821', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.623064');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (148, '827110995', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.623064');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (149, '887902366', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.640944');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (150, '834720617', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.640944');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (151, '832815951', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.655553');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (152, '813087477', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.655553');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (153, '804157028', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.655553');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (154, '854866731', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.670796');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (155, '853500402', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.670796');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (156, '893413801', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.688273');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (157, '872692522', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.688273');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (158, '882405148', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.688273');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (159, '830563991', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.71392');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (160, '827455980', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.72973');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (161, '856160971', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.72973');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (162, '843873189', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.72973');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (163, '834748117', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.753622');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (164, '882432753', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.753622');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (165, '881809662', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.774468');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (166, '858896992', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.774468');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (167, '889927062', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.792519');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (168, '898258524', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.792519');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (169, '889622954', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.792519');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (170, '853241627', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.792519');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (171, '870014549', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.840597');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (172, '832059430', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.840597');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (173, '831960181', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.867562');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (174, '860954143', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.867562');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (175, '892104686', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.867562');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (176, '842058201', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.867562');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (177, '859203352', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.894775');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (178, '843485965', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.894775');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (179, '853657247', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.894775');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (180, '824447452', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.894775');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (181, '840050834', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.894775');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (182, '843326004', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.894775');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (183, '860914228', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.894775');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (184, '885643447', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (185, '878852103', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (186, '819613989', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (187, '814874744', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (188, '854547155', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (189, '813690133', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (190, '815692568', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.940089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (191, '832104782', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.940089');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (192, '819546920', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.952642');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (193, '825401573', 'VIRKSOMHET', '1', '2023-09-26 08:41:17.952642');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (194, '843866157', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.952642');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (195, '805658539', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.972926');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (196, '841224892', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.972926');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (197, '803022880', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.972926');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (198, '896518254', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.996556');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (199, '830643030', 'VIRKSOMHET', '9', '2023-09-26 08:41:17.996556');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (200, '893338866', 'VIRKSOMHET', '2', '2023-09-26 08:41:17.996556');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (201, '801530830', 'VIRKSOMHET', '3', '2023-09-26 08:41:17.996556');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (202, '854116543', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.022058');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (203, '822163976', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.022058');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (204, '808933287', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.022058');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (205, '818050310', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.040593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (206, '863716068', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.040593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (207, '831760105', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.040593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (208, '888564163', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.061336');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (209, '852309451', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.088014');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (210, '890371035', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.088014');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (211, '890925186', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.088014');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (212, '898920835', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.10354');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (213, '890663657', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.10354');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (214, '898784411', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.10354');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (215, '852322922', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.10354');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (216, '882706228', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.127637');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (217, '886131564', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.127637');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (218, '812662067', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.127637');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (219, '832810025', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.140843');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (220, '843127037', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.140843');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (221, '876218247', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.140843');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (222, '856802794', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.140843');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (223, '866003303', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.156801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (224, '867493772', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.156801');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (225, '811617678', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.172399');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (226, '822556309', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.172399');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (227, '805926138', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.172399');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (228, '862023896', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.172399');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (229, '875893485', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.185691');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (230, '811788361', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.185691');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (231, '808215390', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.185691');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (232, '843297634', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.197717');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (233, '845197013', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.197717');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (234, '893637675', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.197717');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (235, '845548783', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.197717');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (236, '830539701', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.213764');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (237, '820563519', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.213764');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (238, '814765188', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.225426');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (239, '875814545', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.225426');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (240, '867296859', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.225426');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (241, '859376922', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.241646');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (242, '890692239', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.241646');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (243, '845661814', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.241646');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (244, '876092060', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.241646');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (245, '823313186', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.256513');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (246, '854791028', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.256513');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (247, '848270274', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.268559');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (248, '864247136', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.268559');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (249, '891403785', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.268559');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (250, '814939601', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.286001');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (251, '854703179', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.286001');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (252, '849166780', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.296924');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (253, '809533904', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.296924');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (254, '839802289', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.296924');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (255, '858870327', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.312922');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (256, '814625362', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.332743');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (257, '869274174', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.332743');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (258, '862679562', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.332743');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (259, '855263203', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.353642');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (260, '807947468', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.353642');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (261, '899140832', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.353642');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (262, '814995115', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.353642');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (263, '840627940', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.371319');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (264, '822409793', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.371319');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (265, '829598728', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.371319');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (266, '811487041', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.398502');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (267, '873219637', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.398502');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (268, '891248584', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.398502');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (269, '858042253', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.409423');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (270, '804035361', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.409423');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (271, '856940194', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.409423');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (272, '832595872', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.409423');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (273, '843931110', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.426583');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (274, '844627392', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.426583');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (275, '837280530', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.426583');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (276, '861895351', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.439832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (277, '862752393', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.439832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (278, '876901137', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.439832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (279, '841908141', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.439832');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (280, '835693750', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.451882');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (281, '843856841', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.451882');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (282, '816506380', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.451882');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (283, '867068412', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.463347');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (284, '880009250', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.463347');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (285, '812011848', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.484179');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (286, '888273755', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.484179');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (287, '846393436', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.507651');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (288, '831113163', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.507651');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (289, '841116951', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.507651');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (290, '869607779', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.532144');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (291, '835030409', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.532144');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (292, '822263497', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.532144');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (293, '875126680', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.552675');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (294, '885953705', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.552675');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (295, '891596153', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.552675');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (296, '836503490', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.552675');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (297, '805201745', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.552675');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (298, '836133320', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.571817');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (299, '826668465', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.571817');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (300, '895148808', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.590876');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (301, '827397411', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.590876');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (302, '865680414', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.602809');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (303, '882526380', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.602809');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (304, '893639860', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.602809');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (305, '849959569', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.616901');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (306, '822591872', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.616901');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (307, '815923187', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.63325');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (308, '874451949', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.63325');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (309, '875847357', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.652867');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (310, '883621424', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.652867');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (311, '828700673', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.652867');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (312, '834669073', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.670424');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (313, '863315976', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.670424');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (314, '877546819', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.670424');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (315, '871751721', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.681561');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (316, '822812612', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.681561');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (317, '858966616', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.701842');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (318, '875705265', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.701842');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (319, '882907789', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.71787');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (320, '849707551', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.71787');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (321, '859103042', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.73733');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (322, '830359834', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.73733');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (323, '880967607', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.73733');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (324, '818786135', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.753777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (325, '842810467', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.753777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (326, '869146460', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.753777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (327, '811235604', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.768292');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (328, '875345141', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.780808');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (329, '880013472', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.780808');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (330, '833759078', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.811576');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (331, '888464361', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.811576');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (332, '854339829', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.811576');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (333, '894571142', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.811576');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (334, '887905822', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.828113');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (335, '833756981', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.828113');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (336, '826330385', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.828113');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (337, '891555439', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.828113');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (338, '896920834', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.863465');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (339, '879564751', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.863465');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (340, '836530672', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.863465');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (341, '892324905', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.863465');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (342, '822582670', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.941339');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (343, '844004408', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.941339');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (344, '806868172', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.941339');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (345, '809808915', 'VIRKSOMHET', '9', '2023-09-26 08:41:18.941339');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (346, '804710758', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.941339');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (347, '851371456', 'VIRKSOMHET', '1', '2023-09-26 08:41:18.941339');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (348, '890797411', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.941339');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (349, '834730925', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.984132');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (350, '879694468', 'VIRKSOMHET', '2', '2023-09-26 08:41:18.984132');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (351, '878491400', 'VIRKSOMHET', '3', '2023-09-26 08:41:18.984132');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (352, '887695198', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.007368');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (353, '817754837', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.007368');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (354, '817592892', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.007368');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (355, '839628252', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.007368');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (356, '881133468', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.007368');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (357, '851076314', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.030926');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (358, '812785759', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.030926');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (359, '884442635', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.030926');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (360, '845307946', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.051858');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (361, '866583348', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.051858');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (362, '875467294', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.051858');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (363, '845360782', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.051858');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (364, '864718167', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.051858');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (365, '812375313', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.072486');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (366, '824153216', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.072486');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (367, '844481790', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.08856');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (368, '883251195', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.08856');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (369, '847393696', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.08856');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (370, '877551828', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.11257');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (371, '824151314', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.124854');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (372, '868625646', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.124854');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (373, '801041781', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.124854');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (374, '833522111', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.142896');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (375, '838724757', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.142896');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (376, '873142509', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.142896');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (377, '819095643', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.154588');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (378, '839805308', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.154588');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (379, '864530414', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.154588');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (380, '876334530', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.154588');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (381, '806839656', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.169385');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (382, '846015259', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.169385');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (383, '814345054', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.169385');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (384, '873748492', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.181741');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (385, '870830126', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.181741');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (386, '855694962', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.200136');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (387, '816957144', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.200136');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (388, '879958734', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.212827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (389, '854997907', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.212827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (390, '840090931', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.212827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (391, '896336814', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.212827');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (392, '829763599', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.230774');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (393, '804813050', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.230774');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (394, '821982479', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.230774');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (395, '801590421', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.248537');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (396, '880244637', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.248537');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (397, '886923382', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.248537');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (398, '835178070', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.248537');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (399, '878399690', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.269437');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (400, '821233692', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.269437');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (401, '834703013', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.269437');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (402, '875419244', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.302941');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (403, '875524887', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.302941');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (404, '808577852', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.302941');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (405, '855976007', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.302941');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (406, '805668045', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.320397');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (407, '866053344', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.320397');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (408, '826675802', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.320397');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (409, '891178398', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.320397');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (410, '827246869', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.320397');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (411, '884866232', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.320397');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (412, '832999354', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.320397');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (413, '804217825', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.320397');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (414, '877885837', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.338102');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (415, '845650116', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.338102');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (416, '825243256', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.351473');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (417, '868231650', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.351473');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (418, '891495802', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.351473');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (419, '803071765', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.351473');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (420, '813392223', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.376133');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (421, '838837456', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.376133');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (422, '832925912', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.376133');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (423, '879984059', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.393303');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (424, '876194824', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.393303');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (425, '869960927', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.393303');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (426, '864924121', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.393303');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (427, '889871834', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.410423');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (428, '888941725', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.410423');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (429, '864451386', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.410423');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (430, '805409250', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.410423');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (431, '885909306', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.410423');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (432, '882842016', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.429355');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (433, '828800154', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.444327');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (434, '865165378', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.444327');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (435, '802468370', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.444327');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (436, '866720470', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.444327');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (437, '837254716', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.468914');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (438, '822693795', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.468914');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (439, '824924346', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.468914');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (440, '840023586', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.485911');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (441, '864991464', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.485911');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (442, '859153568', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.485911');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (443, '844114779', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.504493');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (444, '838791317', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.504493');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (445, '896532159', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.504493');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (446, '856413108', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.527723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (447, '809698080', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.527723');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (448, '817684378', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.543028');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (449, '832196578', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.543028');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (450, '893850387', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.543028');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (451, '817356166', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.560453');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (452, '851432294', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.560453');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (453, '864392250', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.560453');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (454, '825803329', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.560453');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (455, '819673352', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.574361');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (456, '813294486', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.574361');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (457, '878831599', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.574361');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (458, '864960497', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.595055');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (459, '802850140', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.595055');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (460, '888167848', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.613297');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (461, '842330504', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.613297');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (462, '858424081', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.613297');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (463, '815207424', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.629729');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (464, '865941162', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.629729');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (465, '831686801', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.645121');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (466, '895905384', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.645121');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (467, '872009291', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.645121');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (468, '863269152', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.670084');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (469, '849547937', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.670084');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (470, '873304362', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.670084');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (471, '876387118', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.670084');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (472, '857272488', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.689851');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (473, '822221695', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.689851');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (474, '819638427', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.689851');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (475, '866895965', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.717324');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (476, '861193841', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.732258');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (477, '874977279', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.732258');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (478, '889745877', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.751515');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (479, '820698548', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.751515');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (480, '809296618', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.751515');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (481, '863705831', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.762749');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (482, '811014768', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.762749');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (483, '865854422', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.762749');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (484, '820448483', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.773956');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (485, '821667661', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.773956');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (486, '889542390', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.786215');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (487, '835409486', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.786215');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (488, '814346717', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.786215');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (489, '815413004', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.799593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (490, '818895804', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.799593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (491, '861204923', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.799593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (492, '879555072', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.799593');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (493, '855772393', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.811221');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (494, '837201486', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.811221');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (495, '843460808', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.811221');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (496, '877968358', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.825562');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (497, '874838097', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.825562');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (498, '805560200', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.825562');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (499, '881593144', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.845029');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (500, '842206021', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.845029');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (501, '809539154', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.861155');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (502, '881462374', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.861155');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (503, '829262952', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.861155');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (504, '824601665', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.861155');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (505, '862526144', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.861155');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (506, '839613883', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.861155');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (507, '888715789', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.875777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (508, '832828782', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.875777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (509, '816554836', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.875777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (510, '856843871', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.875777');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (511, '885789588', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.893821');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (512, '884813924', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.893821');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (513, '890898121', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.893821');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (514, '800950247', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.893821');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (515, '837591913', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.893821');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (516, '860767128', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.893821');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (517, '838144492', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.913142');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (518, '855490226', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.913142');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (519, '850967552', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.913142');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (520, '840025249', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.913142');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (521, '836815368', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.92583');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (522, '819212825', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.92583');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (523, '868485136', 'VIRKSOMHET', '1', '2023-09-26 08:41:19.92583');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (524, '895904953', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.92583');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (525, '879844455', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.941151');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (526, '843762828', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.941151');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (527, '816273549', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.941151');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (528, '841533906', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.941151');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (529, '888102873', 'VIRKSOMHET', '9', '2023-09-26 08:41:19.941151');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (530, '834489694', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.957177');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (531, '839054362', 'VIRKSOMHET', '3', '2023-09-26 08:41:19.957177');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (532, '802825378', 'VIRKSOMHET', '2', '2023-09-26 08:41:19.957177');


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

SELECT pg_catalog.setval('public.sykefravar_statistikk_virksomhet_id_seq', 532, true);


--
-- Name: sykefravar_statistikk_virksomhet_siste_4_kvartal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_virksomhet_siste_4_kvartal_id_seq', 532, true);


--
-- Name: virksomhet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.virksomhet_id_seq', 510, true);


--
-- Name: virksomhet_metadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.virksomhet_metadata_id_seq', 532, true);


--
-- Name: virksomhet_naringsundergrupper_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.virksomhet_naringsundergrupper_id_seq', 510, true);


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

