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

INSERT INTO public.flyway_schema_history VALUES (1, '1', 'init', 'SQL', 'V1__init.sql', 1782034767, 'test', '2023-09-20 15:44:24.163642', 46, true);
INSERT INTO public.flyway_schema_history VALUES (2, '2', 'create virksomhet adresse', 'SQL', 'V2__create_virksomhet_adresse.sql', -64248919, 'test', '2023-09-20 15:44:24.286951', 41, true);
INSERT INTO public.flyway_schema_history VALUES (3, '3', 'legg til navn pa virksomhet', 'SQL', 'V3__legg_til_navn_pa_virksomhet.sql', 60790216, 'test', '2023-09-20 15:44:24.376455', 17, true);
INSERT INTO public.flyway_schema_history VALUES (4, '4', 'endre prosent til sykefraversprosent', 'SQL', 'V4__endre_prosent_til_sykefraversprosent.sql', 125199402, 'test', '2023-09-20 15:44:24.488385', 27, true);
INSERT INTO public.flyway_schema_history VALUES (5, '5', 'endre type paa postnummer', 'SQL', 'V5__endre_type_paa_postnummer.sql', 1895026063, 'test', '2023-09-20 15:44:24.589802', 49, true);
INSERT INTO public.flyway_schema_history VALUES (6, '6', 'unique constraint sykefravarstatistikk', 'SQL', 'V6__unique_constraint_sykefravarstatistikk.sql', -1493468680, 'test', '2023-09-20 15:44:24.711354', 49, true);
INSERT INTO public.flyway_schema_history VALUES (7, '7', 'unique constraint virksomhet', 'SQL', 'V7__unique_constraint_virksomhet.sql', 2085819180, 'test', '2023-09-20 15:44:24.829021', 31, true);
INSERT INTO public.flyway_schema_history VALUES (8, '8', 'unique constraint virksomhet metadata', 'SQL', 'V8__unique_constraint_virksomhet_metadata.sql', 1632274980, 'test', '2023-09-20 15:44:24.909404', 23, true);
INSERT INTO public.flyway_schema_history VALUES (9, '9', 'legg til narings kode tabeller', 'SQL', 'V9__legg_til_narings_kode_tabeller.sql', 1866713049, 'test', '2023-09-20 15:44:24.976408', 32, true);
INSERT INTO public.flyway_schema_history VALUES (10, '10', 'legg til uoppgitt naeringskode', 'SQL', 'V10__legg_til_uoppgitt_naeringskode.sql', 715256750, 'test', '2023-09-20 15:44:25.058668', 31, true);
INSERT INTO public.flyway_schema_history VALUES (11, '11', 'fjern naringskode fra metadata tabell', 'SQL', 'V11__fjern_naringskode_fra_metadata_tabell.sql', -23097316, 'test', '2023-09-20 15:44:25.147586', 31, true);
INSERT INTO public.flyway_schema_history VALUES (12, '12', 'legg til adresse i virksomhet', 'SQL', 'V12__legg_til_adresse_i_virksomhet.sql', -1159443775, 'test', '2023-09-20 15:44:25.226275', 30, true);
INSERT INTO public.flyway_schema_history VALUES (13, '13', 'ia prosess', 'SQL', 'V13__ia_prosess.sql', -1755516749, 'test', '2023-09-20 15:44:25.31596', 23, true);
INSERT INTO public.flyway_schema_history VALUES (14, '14', 'endre ia prosess til ia sak', 'SQL', 'V14__endre_ia_prosess_til_ia_sak.sql', -751106797, 'test', '2023-09-20 15:44:25.381431', 53, true);
INSERT INTO public.flyway_schema_history VALUES (15, '15', 'endre saknummer', 'SQL', 'V15__endre_saknummer.sql', -1379621340, 'test', '2023-09-20 15:44:25.485743', 22, true);
INSERT INTO public.flyway_schema_history VALUES (16, '16', 'ia sak hendelse', 'SQL', 'V16__ia_sak_hendelse.sql', 586872662, 'test', '2023-09-20 15:44:25.558755', 71, true);
INSERT INTO public.flyway_schema_history VALUES (17, '17', 'legg til eidAv i ia sak', 'SQL', 'V17__legg_til_eidAv_i_ia_sak.sql', -1075526830, 'test', '2023-09-20 15:44:25.679061', 39, true);
INSERT INTO public.flyway_schema_history VALUES (18, '18', 'sykefravar statistikk grunnlag', 'SQL', 'V18__sykefravar_statistikk_grunnlag.sql', -925423348, 'test', '2023-09-20 15:44:25.792295', 88, true);
INSERT INTO public.flyway_schema_history VALUES (19, '19', 'legg til begrunnelser', 'SQL', 'V19__legg_til_begrunnelser.sql', 779259005, 'test', '2023-09-20 15:44:26.035369', 64, true);
INSERT INTO public.flyway_schema_history VALUES (20, '20', 'legg til flere indekser', 'SQL', 'V20__legg_til_flere_indekser.sql', -843857404, 'test', '2023-09-20 15:44:26.226892', 99, true);
INSERT INTO public.flyway_schema_history VALUES (21, '21', 'fjern enkelt begrunnelse', 'SQL', 'V21__fjern_enkelt_begrunnelse.sql', 1129743939, 'test', '2023-09-20 15:44:26.389008', 21, true);
INSERT INTO public.flyway_schema_history VALUES (22, '22', 'legg til endret felt på statistikk', 'SQL', 'V22__legg_til_endret_felt_på_statistikk.sql', -1542988905, 'test', '2023-09-20 15:44:26.461819', 20, true);
INSERT INTO public.flyway_schema_history VALUES (23, '23', 'legg til statistikk for sektor', 'SQL', 'V23__legg_til_statistikk_for_sektor.sql', -417896716, 'test', '2023-09-20 15:44:26.525204', 24, true);
INSERT INTO public.flyway_schema_history VALUES (24, '24', 'unique constraint endre sektor statistikk sektor', 'SQL', 'V24__unique_constraint_endre_sektor_statistikk_sektor.sql', 773753929, 'test', '2023-09-20 15:44:26.598294', 37, true);
INSERT INTO public.flyway_schema_history VALUES (25, '25', 'legg til statistikk for naring og land', 'SQL', 'V25__legg_til_statistikk_for_naring_og_land.sql', -336115428, 'test', '2023-09-20 15:44:26.699288', 54, true);
INSERT INTO public.flyway_schema_history VALUES (26, '26', 'fjern type fra ia sak', 'SQL', 'V26__fjern_type_fra_ia_sak.sql', 1889267882, 'test', '2023-09-20 15:44:26.804154', 14, true);
INSERT INTO public.flyway_schema_history VALUES (27, '27', 'drop idx orgnr virksomhet', 'SQL', 'V27__drop_idx_orgnr_virksomhet.sql', 1323783627, 'test', '2023-09-20 15:44:26.85997', 16, true);
INSERT INTO public.flyway_schema_history VALUES (28, '28', 'legg til uopgitt tosifret kode', 'SQL', 'V28__legg_til_uopgitt_tosifret_kode.sql', -912681527, 'test', '2023-09-20 15:44:26.913812', 19, true);
INSERT INTO public.flyway_schema_history VALUES (29, '29', 'index tapte dagsverk', 'SQL', 'V29__index_tapte_dagsverk.sql', 1914625834, 'test', '2023-09-20 15:44:26.973576', 19, true);
INSERT INTO public.flyway_schema_history VALUES (30, '30', 'virksomhet flere felter ifbm oppdatering', 'SQL', 'V30__virksomhet_flere_felter_ifbm_oppdatering.sql', -558279761, 'test', '2023-09-20 15:44:27.03169', 21, true);
INSERT INTO public.flyway_schema_history VALUES (31, '31', 'sistendrettidspunkt skal ikke vare null', 'SQL', 'V31__sistendrettidspunkt_skal_ikke_vare_null.sql', -1891530364, 'test', '2023-09-20 15:44:27.090088', 27, true);
INSERT INTO public.flyway_schema_history VALUES (32, '32', 'statistikk siste 4 kvartal', 'SQL', 'V32__statistikk_siste_4_kvartal.sql', -2136617812, 'test', '2023-09-20 15:44:27.161252', 25, true);
INSERT INTO public.flyway_schema_history VALUES (33, '33', 'endre navn fra opprettet til sist endret', 'SQL', 'V33__endre_navn_fra_opprettet_til_sist_endret.sql', 1854948614, 'test', '2023-09-20 15:44:27.227587', 10, true);
INSERT INTO public.flyway_schema_history VALUES (34, '34', 'statistikk land siste 4 kvartal', 'SQL', 'V34__statistikk_land_siste_4_kvartal.sql', 542360408, 'test', '2023-09-20 15:44:27.263309', 19, true);
INSERT INTO public.flyway_schema_history VALUES (35, '35', 'drop sykefravar statistikk grunnlag', 'SQL', 'V35__drop_sykefravar_statistikk_grunnlag.sql', 461103825, 'test', '2023-09-20 15:44:27.312229', 12, true);
INSERT INTO public.flyway_schema_history VALUES (36, '36', 'registrere bistand', 'SQL', 'V36__registrere_bistand.sql', -1365283904, 'test', '2023-09-20 15:44:27.354709', 30, true);
INSERT INTO public.flyway_schema_history VALUES (37, '37', 'fullfoert dato leveranse', 'SQL', 'V37__fullfoert_dato_leveranse.sql', 1621470787, 'test', '2023-09-20 15:44:27.414849', 13, true);
INSERT INTO public.flyway_schema_history VALUES (38, '38', 'oppdatere moduler', 'SQL', 'V38__oppdatere_moduler.sql', -246234034, 'test', '2023-09-20 15:44:27.462525', 15, true);
INSERT INTO public.flyway_schema_history VALUES (39, '39', 'rette iatjeneste på modul', 'SQL', 'V39__rette_iatjeneste_på_modul.sql', -1034067650, 'test', '2023-09-20 15:44:27.505266', 10, true);
INSERT INTO public.flyway_schema_history VALUES (40, '40', 'legg til rolle ia sak hendelse', 'SQL', 'V40__legg_til_rolle_ia_sak_hendelse.sql', -82283870, 'test', '2023-09-20 15:44:27.537408', 10, true);
INSERT INTO public.flyway_schema_history VALUES (41, '41', 'legg til rolle ia sak leveranse', 'SQL', 'V41__legg_til_rolle_ia_sak_leveranse.sql', -2029318456, 'test', '2023-09-20 15:44:27.569704', 10, true);
INSERT INTO public.flyway_schema_history VALUES (42, '42', 'legg til deaktivert', 'SQL', 'V42__legg_til_deaktivert.sql', 1170357332, 'test', '2023-09-20 15:44:27.607871', 15, true);
INSERT INTO public.flyway_schema_history VALUES (43, '43', 'siste publiseringsinfo tabell', 'SQL', 'V43__siste_publiseringsinfo_tabell.sql', -1555520829, 'test', '2023-09-20 15:44:27.654899', 19, true);
INSERT INTO public.flyway_schema_history VALUES (44, '44', 'hendelse nav enhet', 'SQL', 'V44__hendelse_nav_enhet.sql', -1118774222, 'test', '2023-09-20 15:44:27.705811', 13, true);
INSERT INTO public.flyway_schema_history VALUES (45, '45', 'oppdatere siste publiseringsinfo', 'SQL', 'V45__oppdatere_siste_publiseringsinfo.sql', -1919960111, 'test', '2023-09-20 15:44:27.744847', 9, true);
INSERT INTO public.flyway_schema_history VALUES (46, '46', 'populer siste publiseringsdato', 'SQL', 'V46__populer_siste_publiseringsdato.sql', 21300723, 'test', '2023-09-20 15:44:27.778715', 20, true);
INSERT INTO public.flyway_schema_history VALUES (47, '47', 'virksomhet naringsundergrupper tabell', 'SQL', 'V47__virksomhet_naringsundergrupper_tabell.sql', 581614507, 'test', '2023-09-20 15:44:27.824167', 12, true);
INSERT INTO public.flyway_schema_history VALUES (48, '48', 'endre oppdateringsdato', 'SQL', 'V48__endre_oppdateringsdato.sql', 855334580, 'test', '2023-09-20 15:44:27.85745', 13, true);
INSERT INTO public.flyway_schema_history VALUES (49, '49', 'sykefravar statistikk bransje tabell', 'SQL', 'V49__sykefravar_statistikk_bransje_tabell.sql', 1439525146, 'test', '2023-09-20 15:44:27.89504', 17, true);
INSERT INTO public.flyway_schema_history VALUES (50, '50', 'endre kode lengde siste 4 kvartal', 'SQL', 'V50__endre_kode_lengde_siste_4_kvartal.sql', 218855534, 'test', '2023-09-20 15:44:27.93573', 12, true);
INSERT INTO public.flyway_schema_history VALUES (51, '51', 'endre navn fra naeringskode til naringsundergruppe', 'SQL', 'V51__endre_navn_fra_naeringskode_til_naringsundergruppe.sql', 498551672, 'test', '2023-09-20 15:44:27.973919', 14, true);
INSERT INTO public.flyway_schema_history VALUES (52, '52', 'slett virksomhet naring tabell', 'SQL', 'V52__slett_virksomhet_naring_tabell.sql', 1210783708, 'test', '2023-09-20 15:44:28.012261', 11, true);
INSERT INTO public.flyway_schema_history VALUES (53, '53', 'oppdatere siste publiseringsinfo Q2 2023', 'SQL', 'V53__oppdatere_siste_publiseringsinfo_Q2_2023.sql', -100876903, 'test', '2023-09-20 15:44:28.047063', 9, true);
INSERT INTO public.flyway_schema_history VALUES (54, '54', 'naringsundergrupper per bransje tabell', 'SQL', 'V54__naringsundergrupper_per_bransje_tabell.sql', -885609844, 'test', '2023-09-20 15:44:28.078512', 144, true);
INSERT INTO public.flyway_schema_history VALUES (55, '55', 'legg til opprettet tidspunkt iasak leveranse', 'SQL', 'V55__legg_til_opprettet_tidspunkt_iasak_leveranse.sql', -1334142016, 'test', '2023-09-20 15:44:28.25014', 14, true);
INSERT INTO public.flyway_schema_history VALUES (56, '56', 'legg til endret statistikk tabeller', 'SQL', 'V56__legg_til_endret_statistikk_tabeller.sql', 1995700472, 'test', '2023-09-20 15:44:28.290413', 24, true);
INSERT INTO public.flyway_schema_history VALUES (57, '57', 'legg til publiseringskvartal', 'SQL', 'V57__legg_til_publiseringskvartal.sql', -1125206576, 'test', '2023-09-20 15:44:28.337476', 21, true);
INSERT INTO public.flyway_schema_history VALUES (58, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', -1691851122, 'test', '2023-09-20 15:44:28.380237', 21, true);
INSERT INTO public.flyway_schema_history VALUES (59, NULL, 'gi tilgang til cloudsqliamuser', 'SQL', 'R__gi_tilgang_til_cloudsqliamuser.sql', -901723652, 'test', '2023-09-20 15:44:58.624114', 46, true);


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

INSERT INTO public.naringsundergrupper_per_bransje VALUES ('88.911', 'BARNEHAGER', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.110', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.120', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.130', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.201', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.202', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.203', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.209', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.310', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.320', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.390', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.411', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.412', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.413', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.420', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.510', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.520', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.610', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.620', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.710', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.720', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.730', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.810', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.820', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.830', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.840', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.850', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.860', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.890', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.910', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('10.920', 'NÆRINGSMIDDELINDUSTRI', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('86.101', 'SYKEHUS', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('86.102', 'SYKEHUS', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('86.104', 'SYKEHUS', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('86.105', 'SYKEHUS', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('86.106', 'SYKEHUS', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('86.107', 'SYKEHUS', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('87.101', 'SYKEHJEM', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('87.102', 'SYKEHJEM', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('49.100', 'TRANSPORT', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('49.311', 'TRANSPORT', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('49.391', 'TRANSPORT', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('49.392', 'TRANSPORT', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('41.101', 'BYGG', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('41.109', 'BYGG', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('41.200', 'BYGG', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.110', 'ANLEGG', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.120', 'ANLEGG', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.130', 'ANLEGG', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.210', 'ANLEGG', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.220', 'ANLEGG', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.910', 'ANLEGG', '2023-09-20 15:44:28.09012');
INSERT INTO public.naringsundergrupper_per_bransje VALUES ('42.990', 'ANLEGG', '2023-09-20 15:44:28.09012');


--
-- Data for Name: sektor; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: siste_publiseringsinfo; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.siste_publiseringsinfo VALUES (1, 2022, 4, '2023-03-02 00:00:00', '2023-06-01 00:00:00', '2023-09-20 15:44:27.668572');
INSERT INTO public.siste_publiseringsinfo VALUES (2, 2023, 1, '2023-06-01 00:00:00', '2023-09-07 00:00:00', '2023-09-20 15:44:27.75381');
INSERT INTO public.siste_publiseringsinfo VALUES (3, 2022, 3, '2022-12-01 00:00:00', '2023-03-02 00:00:00', '2023-09-20 15:44:27.788534');
INSERT INTO public.siste_publiseringsinfo VALUES (4, 2022, 2, '2022-09-08 00:00:00', '2022-12-01 00:00:00', '2023-09-20 15:44:27.788534');
INSERT INTO public.siste_publiseringsinfo VALUES (5, 2022, 1, '2022-06-02 00:00:00', '2022-09-08 00:00:00', '2023-09-20 15:44:27.788534');
INSERT INTO public.siste_publiseringsinfo VALUES (6, 2021, 4, '2022-03-03 00:00:00', '2022-06-02 00:00:00', '2023-09-20 15:44:27.788534');
INSERT INTO public.siste_publiseringsinfo VALUES (7, 2021, 3, '2021-12-02 00:00:00', '2022-03-03 00:00:00', '2023-09-20 15:44:27.788534');
INSERT INTO public.siste_publiseringsinfo VALUES (8, 2023, 2, '2023-09-07 00:00:00', '2023-11-30 00:00:00', '2023-09-20 15:44:28.055179');


--
-- Data for Name: sykefravar_statistikk_bransje; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_bransje VALUES (1, 2023, 2, 'BARNEHAGER', 1000, 25000, 250000, 10, false, '2023-09-20 15:45:07.388187', NULL);
INSERT INTO public.sykefravar_statistikk_bransje VALUES (2, 2023, 2, 'NÆRINGSMIDDELINDUSTRI', 1000, 25000, 250000, 10, false, '2023-09-20 15:45:07.420792', NULL);
INSERT INTO public.sykefravar_statistikk_bransje VALUES (3, 2023, 2, 'SYKEHUS', 1000, 25000, 250000, 10, false, '2023-09-20 15:45:07.420792', NULL);
INSERT INTO public.sykefravar_statistikk_bransje VALUES (4, 2023, 2, 'SYKEHJEM', 1000, 25000, 250000, 10, false, '2023-09-20 15:45:07.453635', NULL);
INSERT INTO public.sykefravar_statistikk_bransje VALUES (5, 2023, 2, 'TRANSPORT', 1000, 25000, 250000, 10, false, '2023-09-20 15:45:07.453635', NULL);
INSERT INTO public.sykefravar_statistikk_bransje VALUES (6, 2023, 2, 'BYGG', 1000, 25000, 250000, 10, false, '2023-09-20 15:45:07.453635', NULL);
INSERT INTO public.sykefravar_statistikk_bransje VALUES (7, 2023, 2, 'ANLEGG', 1000, 25000, 250000, 10, false, '2023-09-20 15:45:07.453635', NULL);


--
-- Data for Name: sykefravar_statistikk_kategori_siste_4_kvartal; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (1, 'NÆRING', '00', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.562576', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (2, 'NÆRING', '01', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.695618', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (3, 'NÆRING', '02', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.695618', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (4, 'NÆRING', '03', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.695618', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (5, 'NÆRING', '05', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.695618', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (6, 'NÆRING', '06', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (7, 'NÆRING', '07', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (8, 'NÆRING', '08', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (9, 'NÆRING', '09', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (10, 'NÆRING', '10', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (11, 'NÆRING', '11', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (12, 'NÆRING', '12', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (13, 'NÆRING', '13', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (14, 'NÆRING', '14', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (15, 'NÆRING', '15', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (16, 'NÆRING', '16', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (17, 'NÆRING', '17', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (18, 'NÆRING', '18', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (19, 'NÆRING', '19', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (20, 'NÆRING', '20', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (21, 'NÆRING', '21', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (22, 'NÆRING', '22', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (23, 'NÆRING', '23', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (24, 'NÆRING', '24', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (25, 'NÆRING', '25', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (26, 'NÆRING', '26', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (27, 'NÆRING', '27', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (28, 'NÆRING', '28', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (29, 'NÆRING', '29', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (30, 'NÆRING', '30', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (31, 'NÆRING', '31', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (32, 'NÆRING', '32', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (33, 'NÆRING', '33', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.769329', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (34, 'NÆRING', '35', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.934045', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (35, 'NÆRING', '36', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.934045', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (36, 'NÆRING', '37', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.934045', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (37, 'NÆRING', '38', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.934045', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (38, 'NÆRING', '39', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.934045', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (39, 'NÆRING', '41', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.934045', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (40, 'NÆRING', '42', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:06.934045', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (41, 'NÆRING', '43', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.018095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (42, 'NÆRING', '45', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.018095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (43, 'NÆRING', '46', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.018095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (44, 'NÆRING', '47', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.018095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (45, 'NÆRING', '49', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.018095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (46, 'NÆRING', '50', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.018095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (47, 'NÆRING', '51', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.018095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (48, 'NÆRING', '52', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.018095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (49, 'NÆRING', '53', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.018095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (50, 'NÆRING', '55', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.018095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (51, 'NÆRING', '56', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.018095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (52, 'NÆRING', '58', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.018095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (53, 'NÆRING', '59', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.018095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (54, 'NÆRING', '60', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.018095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (55, 'NÆRING', '61', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.018095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (56, 'NÆRING', '62', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.018095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (57, 'NÆRING', '63', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.018095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (58, 'NÆRING', '64', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.018095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (59, 'NÆRING', '65', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.018095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (60, 'NÆRING', '66', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.018095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (61, 'NÆRING', '68', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.018095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (62, 'NÆRING', '69', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.018095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (63, 'NÆRING', '70', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.018095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (64, 'NÆRING', '71', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.018095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (65, 'NÆRING', '72', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.018095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (66, 'NÆRING', '73', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.018095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (67, 'NÆRING', '74', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.178455', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (68, 'NÆRING', '75', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.178455', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (69, 'NÆRING', '77', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.178455', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (70, 'NÆRING', '78', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.178455', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (71, 'NÆRING', '79', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.178455', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (72, 'NÆRING', '80', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.178455', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (73, 'NÆRING', '81', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.178455', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (74, 'NÆRING', '82', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.178455', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (75, 'NÆRING', '84', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.261224', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (76, 'NÆRING', '85', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.261224', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (77, 'NÆRING', '86', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.261224', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (78, 'NÆRING', '87', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.261224', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (79, 'NÆRING', '88', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.261224', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (80, 'NÆRING', '90', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.261224', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (81, 'NÆRING', '91', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.261224', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (82, 'NÆRING', '92', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.261224', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (83, 'NÆRING', '93', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.261224', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (84, 'NÆRING', '94', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.261224', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (85, 'NÆRING', '95', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.261224', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (86, 'NÆRING', '96', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.261224', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (87, 'NÆRING', '97', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.261224', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (88, 'NÆRING', '99', 50000, 1000000, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.261224', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (89, 'BRANSJE', 'BARNEHAGER', 100000, 1000000, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.375654', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (90, 'BRANSJE', 'NÆRINGSMIDDELINDUSTRI', 100000, 1000000, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.408238', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (91, 'BRANSJE', 'SYKEHUS', 100000, 1000000, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.408238', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (92, 'BRANSJE', 'SYKEHJEM', 100000, 1000000, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.446352', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (93, 'BRANSJE', 'TRANSPORT', 100000, 1000000, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.446352', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (94, 'BRANSJE', 'BYGG', 100000, 1000000, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.446352', 2, 2023);
INSERT INTO public.sykefravar_statistikk_kategori_siste_4_kvartal VALUES (95, 'BRANSJE', 'ANLEGG', 100000, 1000000, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:07.446352', 2, 2023);


--
-- Data for Name: sykefravar_statistikk_land; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: sykefravar_statistikk_naring; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_naring VALUES (1, 2023, 2, '00', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.596588', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (2, 2023, 2, '01', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.714634', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (3, 2023, 2, '02', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.714634', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (4, 2023, 2, '03', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.714634', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (5, 2023, 2, '05', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.714634', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (6, 2023, 2, '06', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (7, 2023, 2, '07', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (8, 2023, 2, '08', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (9, 2023, 2, '09', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (10, 2023, 2, '10', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (11, 2023, 2, '11', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (12, 2023, 2, '12', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (13, 2023, 2, '13', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (14, 2023, 2, '14', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (15, 2023, 2, '15', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (16, 2023, 2, '16', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (17, 2023, 2, '17', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (18, 2023, 2, '18', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (19, 2023, 2, '19', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (20, 2023, 2, '20', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (21, 2023, 2, '21', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (22, 2023, 2, '22', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (23, 2023, 2, '23', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (24, 2023, 2, '24', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (25, 2023, 2, '25', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (26, 2023, 2, '26', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (27, 2023, 2, '27', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (28, 2023, 2, '28', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (29, 2023, 2, '29', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (30, 2023, 2, '30', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (31, 2023, 2, '31', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (32, 2023, 2, '32', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (33, 2023, 2, '33', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.842628', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (34, 2023, 2, '35', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.951085', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (35, 2023, 2, '36', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.951085', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (36, 2023, 2, '37', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.951085', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (37, 2023, 2, '38', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.951085', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (38, 2023, 2, '39', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.951085', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (39, 2023, 2, '41', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.951085', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (40, 2023, 2, '42', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:06.951085', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (41, 2023, 2, '43', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.086096', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (42, 2023, 2, '45', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.086096', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (43, 2023, 2, '46', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.086096', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (44, 2023, 2, '47', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.086096', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (45, 2023, 2, '49', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.086096', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (46, 2023, 2, '50', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.086096', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (47, 2023, 2, '51', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.086096', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (48, 2023, 2, '52', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.086096', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (49, 2023, 2, '53', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.086096', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (50, 2023, 2, '55', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.086096', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (51, 2023, 2, '56', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.086096', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (52, 2023, 2, '58', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.086096', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (53, 2023, 2, '59', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.086096', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (54, 2023, 2, '60', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.086096', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (55, 2023, 2, '61', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.086096', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (56, 2023, 2, '62', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.086096', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (57, 2023, 2, '63', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.086096', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (58, 2023, 2, '64', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.086096', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (59, 2023, 2, '65', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.086096', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (60, 2023, 2, '66', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.086096', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (61, 2023, 2, '68', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.086096', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (62, 2023, 2, '69', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.086096', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (63, 2023, 2, '70', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.086096', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (64, 2023, 2, '71', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.086096', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (65, 2023, 2, '72', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.086096', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (66, 2023, 2, '73', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.086096', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (67, 2023, 2, '74', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.202986', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (68, 2023, 2, '75', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.202986', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (69, 2023, 2, '77', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.202986', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (70, 2023, 2, '78', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.202986', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (71, 2023, 2, '79', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.202986', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (72, 2023, 2, '80', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.202986', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (73, 2023, 2, '81', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.202986', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (74, 2023, 2, '82', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.202986', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (75, 2023, 2, '84', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.305075', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (76, 2023, 2, '85', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.305075', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (77, 2023, 2, '86', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.305075', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (78, 2023, 2, '87', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.305075', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (79, 2023, 2, '88', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.305075', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (80, 2023, 2, '90', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.305075', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (81, 2023, 2, '91', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.305075', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (82, 2023, 2, '92', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.305075', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (83, 2023, 2, '93', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.305075', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (84, 2023, 2, '94', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.305075', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (85, 2023, 2, '95', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.305075', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (86, 2023, 2, '96', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.305075', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (87, 2023, 2, '97', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.305075', NULL);
INSERT INTO public.sykefravar_statistikk_naring VALUES (88, 2023, 2, '99', 1000, 12500, 250000, 5, false, '2023-09-20 15:45:07.305075', NULL);


--
-- Data for Name: sykefravar_statistikk_naringsundergruppe; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: sykefravar_statistikk_sektor; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: sykefravar_statistikk_virksomhet; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (1, '987654321', 2023, 2, 6, 6924.04536431052, 125, 16, false, '2023-09-20 15:45:10.848151', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (2, '987654321', 2023, 1, 6, 6924.04536431052, 125, 7, false, '2023-09-20 15:45:10.870273', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (3, '123456789', 2023, 2, 301, 4246.17410572266, 125, 7, false, '2023-09-20 15:45:10.899754', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (4, '123456789', 2023, 1, 301, 4246.17410572266, 125, 7, false, '2023-09-20 15:45:10.899754', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (5, '555555555', 2023, 2, 925, 5884.49107409147, 125, 10, false, '2023-09-20 15:45:10.899754', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (6, '817218179', 2023, 2, 196, 2960.56824206292, 125, 6, false, '2023-09-20 15:45:10.899754', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (7, '817218179', 2023, 1, 196, 2960.56824206292, 125, 6, false, '2023-09-20 15:45:10.899754', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (8, '858315727', 2023, 2, 42, 2328.93702077699, 125, 6, false, '2023-09-20 15:45:10.928709', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (9, '858315727', 2023, 1, 42, 2328.93702077699, 125, 6, false, '2023-09-20 15:45:10.928709', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (10, '867886062', 2023, 2, 42, 79.2562784043984, 125, 6, false, '2023-09-20 15:45:10.928709', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (11, '867886062', 2023, 1, 42, 79.2562784043984, 125, 6, false, '2023-09-20 15:45:10.928709', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (12, '855774607', 2023, 2, 531, 6410.91267187963, 125, 3, false, '2023-09-20 15:45:10.959986', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (13, '855774607', 2023, 1, 531, 6410.91267187963, 125, 14, false, '2023-09-20 15:45:10.959986', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (14, '827015467', 2023, 2, 278, 4004.28699346698, 125, 17, false, '2023-09-20 15:45:10.959986', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (15, '805290389', 2023, 2, 312, 3631.8678281133, 125, 9, false, '2023-09-20 15:45:10.959986', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (16, '857768316', 2023, 2, 126, 8513.98718832714, 125, 2, false, '2023-09-20 15:45:10.959986', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (17, '878440626', 2023, 2, 315, 3986.31961665028, 125, 7, false, '2023-09-20 15:45:10.959986', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (18, '837670234', 2023, 2, 408, 7307.61658980663, 125, 19, false, '2023-09-20 15:45:10.991379', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (19, '869337023', 2023, 2, 628, 4005.94467431299, 125, 2, false, '2023-09-20 15:45:10.991379', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (20, '868310560', 2023, 2, 360, 9057.87690400581, 125, 6, false, '2023-09-20 15:45:10.991379', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (21, '854189604', 2023, 2, 7, 7575.23362184433, 125, 12, false, '2023-09-20 15:45:10.991379', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (22, '868245401', 2023, 2, 117, 8281.93439244322, 125, 20, false, '2023-09-20 15:45:10.991379', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (23, '887421757', 2023, 2, 526, 6324.79426908425, 125, 3, false, '2023-09-20 15:45:11.026907', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (24, '801201600', 2023, 2, 765, 9899.06762605137, 125, 5, false, '2023-09-20 15:45:11.026907', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (25, '853912646', 2023, 2, 700, 9000.51920221018, 125, 20, false, '2023-09-20 15:45:11.026907', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (26, '871483086', 2023, 2, 891, 4916.21702105948, 125, 20, false, '2023-09-20 15:45:11.026907', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (27, '889480505', 2023, 2, 422, 4118.98936849697, 125, 8, false, '2023-09-20 15:45:11.026907', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (28, '889747942', 2023, 2, 108, 4640.10675670481, 125, 1, false, '2023-09-20 15:45:11.026907', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (29, '862875196', 2023, 2, 260, 8458.87516540827, 125, 6, false, '2023-09-20 15:45:11.063001', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (30, '855525313', 2023, 2, 226, 2781.82786540758, 125, 4, false, '2023-09-20 15:45:11.063001', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (31, '811443790', 2023, 2, 827, 5817.14025955679, 125, 11, false, '2023-09-20 15:45:11.063001', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (32, '833573552', 2023, 2, 912, 4417.36838713893, 125, 3, false, '2023-09-20 15:45:11.063001', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (33, '819462272', 2023, 2, 592, 820.352026260444, 125, 1, false, '2023-09-20 15:45:11.063001', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (34, '856293477', 2023, 2, 817, 458.378431387719, 125, 9, false, '2023-09-20 15:45:11.063001', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (35, '882254761', 2023, 2, 555, 3317.10546450289, 125, 1, false, '2023-09-20 15:45:11.133916', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (36, '855039001', 2023, 2, 693, 2900.81005340987, 125, 16, false, '2023-09-20 15:45:11.133916', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (37, '824009121', 2023, 2, 730, 7128.69771338963, 125, 20, false, '2023-09-20 15:45:11.133916', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (38, '800497744', 2023, 2, 542, 3524.46951484989, 125, 5, false, '2023-09-20 15:45:11.133916', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (39, '844731879', 2023, 2, 515, 901.64070232632, 125, 11, false, '2023-09-20 15:45:11.133916', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (40, '840016805', 2023, 2, 845, 3675.33279331737, 125, 1, false, '2023-09-20 15:45:11.133916', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (41, '888553487', 2023, 2, 637, 8777.55333451234, 125, 8, false, '2023-09-20 15:45:11.133916', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (42, '806720589', 2023, 2, 841, 2852.59924313661, 125, 7, false, '2023-09-20 15:45:11.133916', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (43, '837337985', 2023, 2, 619, 4545.98291579057, 125, 10, false, '2023-09-20 15:45:11.133916', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (44, '874871261', 2023, 2, 682, 481.087899682343, 125, 5, false, '2023-09-20 15:45:11.185613', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (45, '801074620', 2023, 2, 828, 2612.08219696165, 125, 3, false, '2023-09-20 15:45:11.185613', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (46, '876853959', 2023, 2, 546, 1108.72683624124, 125, 7, false, '2023-09-20 15:45:11.185613', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (47, '889812652', 2023, 2, 856, 4802.15677733724, 125, 8, false, '2023-09-20 15:45:11.185613', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (48, '839437706', 2023, 2, 131, 5931.11826335347, 125, 16, false, '2023-09-20 15:45:11.185613', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (49, '845771147', 2023, 2, 965, 9803.23016176345, 125, 3, false, '2023-09-20 15:45:11.185613', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (50, '855530089', 2023, 2, 845, 5773.24880339959, 125, 20, false, '2023-09-20 15:45:11.185613', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (51, '892871410', 2023, 2, 870, 7914.30329314414, 125, 14, false, '2023-09-20 15:45:11.185613', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (52, '874569933', 2023, 2, 120, 1559.41755294417, 125, 11, false, '2023-09-20 15:45:11.185613', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (53, '890920316', 2023, 2, 527, 6693.02456708633, 125, 1, false, '2023-09-20 15:45:11.185613', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (54, '806574144', 2023, 2, 848, 4396.61909644517, 125, 14, false, '2023-09-20 15:45:11.237042', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (55, '897019567', 2023, 2, 301, 3442.31726990942, 125, 20, false, '2023-09-20 15:45:11.237042', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (56, '899744758', 2023, 2, 178, 1334.76800848278, 125, 5, false, '2023-09-20 15:45:11.237042', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (57, '879055458', 2023, 2, 222, 4303.92999773129, 125, 4, false, '2023-09-20 15:45:11.237042', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (58, '849291295', 2023, 2, 836, 8856.81027642962, 125, 9, false, '2023-09-20 15:45:11.237042', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (59, '876484129', 2023, 2, 433, 8532.35518697776, 125, 19, false, '2023-09-20 15:45:11.237042', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (60, '804794544', 2023, 2, 996, 5038.24746907627, 125, 1, false, '2023-09-20 15:45:11.237042', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (61, '801414721', 2023, 2, 652, 1648.15206186305, 125, 12, false, '2023-09-20 15:45:11.237042', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (62, '853084595', 2023, 2, 410, 507.053390279097, 125, 6, false, '2023-09-20 15:45:11.290359', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (63, '814750942', 2023, 2, 989, 349.165286612235, 125, 10, false, '2023-09-20 15:45:11.290359', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (64, '894248802', 2023, 2, 596, 8426.47073628886, 125, 5, false, '2023-09-20 15:45:11.290359', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (65, '895438962', 2023, 2, 649, 3607.23480202545, 125, 12, false, '2023-09-20 15:45:11.290359', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (66, '894222980', 2023, 2, 329, 5767.20061113303, 125, 1, false, '2023-09-20 15:45:11.290359', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (67, '892644608', 2023, 2, 704, 6135.29073538285, 125, 9, false, '2023-09-20 15:45:11.290359', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (68, '861296525', 2023, 2, 308, 2284.6454261469, 125, 5, false, '2023-09-20 15:45:11.290359', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (69, '856974053', 2023, 2, 88, 5201.03924123198, 125, 9, false, '2023-09-20 15:45:11.290359', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (70, '893401740', 2023, 2, 596, 48.6367508250359, 125, 20, false, '2023-09-20 15:45:11.290359', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (71, '898873892', 2023, 2, 259, 8182.49394086347, 125, 14, false, '2023-09-20 15:45:11.290359', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (72, '890416553', 2023, 2, 879, 5954.43067332188, 125, 2, false, '2023-09-20 15:45:11.334609', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (73, '883382387', 2023, 2, 576, 6553.20636590203, 125, 5, false, '2023-09-20 15:45:11.334609', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (74, '819780616', 2023, 2, 85, 6908.26348461578, 125, 16, false, '2023-09-20 15:45:11.334609', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (75, '840103549', 2023, 2, 44, 4099.90700913746, 125, 5, false, '2023-09-20 15:45:11.334609', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (76, '858398076', 2023, 2, 343, 8394.25548564631, 125, 6, false, '2023-09-20 15:45:11.334609', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (77, '820203200', 2023, 2, 913, 3599.66089709145, 125, 9, false, '2023-09-20 15:45:11.381837', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (78, '815962275', 2023, 2, 200, 2214.12795636, 125, 7, false, '2023-09-20 15:45:11.381837', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (79, '858135043', 2023, 2, 701, 7201.0999938222, 125, 8, false, '2023-09-20 15:45:11.381837', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (80, '808027924', 2023, 2, 573, 7531.76954784758, 125, 14, false, '2023-09-20 15:45:11.381837', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (81, '825903416', 2023, 2, 751, 3090.38555413951, 125, 1, false, '2023-09-20 15:45:11.381837', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (82, '824836141', 2023, 2, 637, 6822.40162636401, 125, 12, false, '2023-09-20 15:45:11.381837', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (83, '832710844', 2023, 2, 808, 2228.29310983732, 125, 18, false, '2023-09-20 15:45:11.381837', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (84, '842362113', 2023, 2, 474, 7792.48216625469, 125, 15, false, '2023-09-20 15:45:11.381837', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (85, '850606669', 2023, 2, 555, 8917.12318187584, 125, 20, false, '2023-09-20 15:45:11.381837', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (86, '850242937', 2023, 2, 675, 8862.69638507906, 125, 13, false, '2023-09-20 15:45:11.418697', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (87, '828871863', 2023, 2, 582, 830.051494298531, 125, 4, false, '2023-09-20 15:45:11.418697', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (88, '822859420', 2023, 2, 657, 2570.15237634786, 125, 15, false, '2023-09-20 15:45:11.418697', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (89, '843001698', 2023, 2, 35, 1397.85148010243, 125, 7, false, '2023-09-20 15:45:11.418697', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (90, '831692857', 2023, 2, 230, 6047.37545493461, 125, 10, false, '2023-09-20 15:45:11.418697', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (91, '886195004', 2023, 2, 520, 2266.74852322124, 125, 18, false, '2023-09-20 15:45:11.460932', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (92, '813134297', 2023, 2, 601, 8399.6684624857, 125, 11, false, '2023-09-20 15:45:11.460932', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (93, '854341349', 2023, 2, 482, 8763.16648117893, 125, 17, false, '2023-09-20 15:45:11.460932', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (94, '852255739', 2023, 2, 725, 3325.76724341011, 125, 2, false, '2023-09-20 15:45:11.460932', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (95, '831919224', 2023, 2, 765, 9882.50884627621, 125, 16, false, '2023-09-20 15:45:11.460932', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (96, '893956693', 2023, 2, 617, 9032.52803558601, 125, 12, false, '2023-09-20 15:45:11.460932', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (97, '887068890', 2023, 2, 122, 2081.59710258616, 125, 17, false, '2023-09-20 15:45:11.460932', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (98, '859377546', 2023, 2, 640, 8899.27164234723, 125, 17, false, '2023-09-20 15:45:11.460932', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (99, '808337271', 2023, 2, 319, 7619.51331303663, 125, 1, false, '2023-09-20 15:45:11.507479', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (100, '892079041', 2023, 2, 809, 8504.98175205555, 125, 2, false, '2023-09-20 15:45:11.507479', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (101, '825309841', 2023, 2, 821, 8569.5981243455, 125, 6, false, '2023-09-20 15:45:11.507479', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (102, '899283543', 2023, 2, 130, 1564.68128661009, 125, 15, false, '2023-09-20 15:45:11.507479', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (103, '836105668', 2023, 2, 171, 6366.21552912682, 125, 2, false, '2023-09-20 15:45:11.536879', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (104, '899617322', 2023, 2, 693, 438.777998811875, 125, 18, false, '2023-09-20 15:45:11.536879', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (105, '897369016', 2023, 2, 215, 1461.37811388722, 125, 2, false, '2023-09-20 15:45:11.536879', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (106, '847909287', 2023, 2, 816, 5225.47807259235, 125, 18, false, '2023-09-20 15:45:11.536879', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (107, '885363201', 2023, 2, 68, 1829.19028617199, 125, 16, false, '2023-09-20 15:45:11.536879', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (108, '895703494', 2023, 2, 306, 5189.03799525443, 125, 20, false, '2023-09-20 15:45:11.536879', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (109, '805582082', 2023, 2, 9, 7214.5417108887, 125, 1, false, '2023-09-20 15:45:11.536879', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (110, '831313921', 2023, 2, 644, 9853.40975983583, 125, 17, false, '2023-09-20 15:45:11.536879', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (111, '887250798', 2023, 2, 78, 8950.40378756113, 125, 5, false, '2023-09-20 15:45:11.536879', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (112, '876662451', 2023, 2, 694, 8379.45679294371, 125, 6, false, '2023-09-20 15:45:11.588556', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (113, '829725165', 2023, 2, 202, 6115.5076684128, 125, 16, false, '2023-09-20 15:45:11.588556', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (114, '862196487', 2023, 2, 689, 9035.43106858948, 125, 3, false, '2023-09-20 15:45:11.588556', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (115, '851434861', 2023, 2, 993, 7484.06698740192, 125, 5, false, '2023-09-20 15:45:11.588556', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (116, '861181928', 2023, 2, 469, 9839.97637563674, 125, 16, false, '2023-09-20 15:45:11.636608', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (117, '852787577', 2023, 2, 316, 6503.37703898382, 125, 20, false, '2023-09-20 15:45:11.636608', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (118, '801830575', 2023, 2, 915, 6488.99583424146, 125, 8, false, '2023-09-20 15:45:11.636608', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (119, '836614467', 2023, 2, 312, 5625.49338163954, 125, 15, false, '2023-09-20 15:45:11.636608', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (120, '893864437', 2023, 2, 528, 4456.19594550626, 125, 12, false, '2023-09-20 15:45:11.636608', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (121, '831824518', 2023, 2, 378, 4729.89127751862, 125, 13, false, '2023-09-20 15:45:11.636608', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (122, '824296444', 2023, 2, 136, 1466.277754785, 125, 15, false, '2023-09-20 15:45:11.636608', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (123, '869460321', 2023, 2, 391, 3275.07276418549, 125, 19, false, '2023-09-20 15:45:11.679015', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (124, '808176785', 2023, 2, 130, 5139.96014194107, 125, 6, false, '2023-09-20 15:45:11.679015', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (125, '863481189', 2023, 2, 301, 3434.33915800127, 125, 11, false, '2023-09-20 15:45:11.679015', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (126, '891032390', 2023, 2, 706, 3041.43919066158, 125, 20, false, '2023-09-20 15:45:11.679015', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (127, '827341816', 2023, 2, 105, 9624.07851796579, 125, 2, false, '2023-09-20 15:45:11.679015', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (128, '897698399', 2023, 2, 48, 3926.34487519701, 125, 8, false, '2023-09-20 15:45:11.679015', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (129, '890446075', 2023, 2, 941, 8570.42860672541, 125, 13, false, '2023-09-20 15:45:11.728547', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (130, '845411087', 2023, 2, 736, 7704.75699851909, 125, 10, false, '2023-09-20 15:45:11.728547', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (131, '873878975', 2023, 2, 257, 1955.41032420971, 125, 9, false, '2023-09-20 15:45:11.728547', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (132, '823474091', 2023, 2, 61, 7062.26999400936, 125, 2, false, '2023-09-20 15:45:11.728547', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (133, '807676378', 2023, 2, 40, 3780.52743748225, 125, 4, false, '2023-09-20 15:45:11.728547', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (134, '832530561', 2023, 2, 751, 6090.87341578146, 125, 4, false, '2023-09-20 15:45:11.728547', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (135, '848331429', 2023, 2, 336, 6748.8511695242, 125, 1, false, '2023-09-20 15:45:11.728547', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (136, '857977631', 2023, 2, 59, 1232.55285786232, 125, 16, false, '2023-09-20 15:45:11.728547', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (137, '821437524', 2023, 2, 417, 8860.68936802601, 125, 17, false, '2023-09-20 15:45:11.728547', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (138, '813058997', 2023, 2, 484, 213.881192989406, 125, 18, false, '2023-09-20 15:45:11.728547', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (139, '817599634', 2023, 2, 618, 8164.50893736636, 125, 4, false, '2023-09-20 15:45:11.775685', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (140, '841754369', 2023, 2, 156, 6201.26176956838, 125, 14, false, '2023-09-20 15:45:11.775685', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (141, '848123425', 2023, 2, 784, 2595.83687417912, 125, 14, false, '2023-09-20 15:45:11.775685', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (142, '823949946', 2023, 2, 864, 6797.15269530234, 125, 13, false, '2023-09-20 15:45:11.775685', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (143, '830259693', 2023, 2, 542, 7312.60245846873, 125, 8, false, '2023-09-20 15:45:11.775685', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (144, '825960020', 2023, 2, 739, 7125.78848520674, 125, 16, false, '2023-09-20 15:45:11.817558', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (145, '821955914', 2023, 2, 899, 5840.42551396312, 125, 4, false, '2023-09-20 15:45:11.817558', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (146, '840273134', 2023, 2, 162, 3894.01315774771, 125, 20, false, '2023-09-20 15:45:11.817558', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (147, '804095151', 2023, 2, 827, 2006.27528629727, 125, 20, false, '2023-09-20 15:45:11.817558', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (148, '895219474', 2023, 2, 538, 5839.92236313785, 125, 7, false, '2023-09-20 15:45:11.817558', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (149, '801800235', 2023, 2, 498, 5358.22059655249, 125, 7, false, '2023-09-20 15:45:11.817558', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (150, '807003856', 2023, 2, 117, 2672.47872204752, 125, 2, false, '2023-09-20 15:45:11.817558', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (151, '841429259', 2023, 2, 573, 2755.76938909663, 125, 8, false, '2023-09-20 15:45:11.817558', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (152, '881670559', 2023, 2, 861, 6769.03117281425, 125, 17, false, '2023-09-20 15:45:11.817558', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (153, '843481844', 2023, 2, 344, 7679.56058092392, 125, 20, false, '2023-09-20 15:45:11.817558', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (154, '884326615', 2023, 2, 851, 9915.78221313304, 125, 17, false, '2023-09-20 15:45:11.817558', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (155, '853080669', 2023, 2, 209, 7658.59381694592, 125, 4, false, '2023-09-20 15:45:11.852921', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (156, '865040557', 2023, 2, 923, 3513.82590867558, 125, 12, false, '2023-09-20 15:45:11.852921', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (157, '817210443', 2023, 2, 217, 1272.56757282262, 125, 17, false, '2023-09-20 15:45:11.852921', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (158, '862357563', 2023, 2, 305, 7530.1048714005, 125, 15, false, '2023-09-20 15:45:11.852921', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (159, '882527092', 2023, 2, 468, 339.598288974117, 125, 9, false, '2023-09-20 15:45:11.852921', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (160, '851225319', 2023, 2, 877, 169.87698946564, 125, 8, false, '2023-09-20 15:45:11.897141', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (161, '899519607', 2023, 2, 538, 6232.98456995779, 125, 20, false, '2023-09-20 15:45:11.897141', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (162, '896316258', 2023, 2, 967, 443.83033361266, 125, 12, false, '2023-09-20 15:45:11.897141', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (163, '800366945', 2023, 2, 810, 434.006339625763, 125, 5, false, '2023-09-20 15:45:11.897141', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (164, '898008510', 2023, 2, 310, 5657.14649238587, 125, 19, false, '2023-09-20 15:45:11.924588', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (165, '829686729', 2023, 2, 917, 4119.82081313194, 125, 19, false, '2023-09-20 15:45:11.924588', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (166, '846341319', 2023, 2, 973, 592.068275827225, 125, 13, false, '2023-09-20 15:45:11.924588', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (167, '894967226', 2023, 2, 621, 4747.93025426618, 125, 16, false, '2023-09-20 15:45:11.924588', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (168, '833597055', 2023, 2, 943, 3027.74014513935, 125, 2, false, '2023-09-20 15:45:11.924588', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (169, '874119945', 2023, 2, 806, 8044.54922334208, 125, 5, false, '2023-09-20 15:45:11.924588', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (170, '868445187', 2023, 2, 970, 9248.38071085592, 125, 11, false, '2023-09-20 15:45:11.959331', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (171, '871094397', 2023, 2, 414, 5199.76364450054, 125, 14, false, '2023-09-20 15:45:11.959331', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (172, '802898734', 2023, 2, 539, 8451.69526304092, 125, 5, false, '2023-09-20 15:45:11.959331', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (173, '834917051', 2023, 2, 132, 9539.03487953579, 125, 15, false, '2023-09-20 15:45:11.959331', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (174, '807563291', 2023, 2, 821, 3282.41220501881, 125, 10, false, '2023-09-20 15:45:11.959331', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (175, '835160605', 2023, 2, 831, 3419.39612762723, 125, 12, false, '2023-09-20 15:45:11.959331', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (176, '885992640', 2023, 2, 342, 8791.85456410431, 125, 7, false, '2023-09-20 15:45:11.959331', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (177, '869936536', 2023, 2, 310, 534.12934133834, 125, 1, false, '2023-09-20 15:45:11.959331', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (178, '859402121', 2023, 2, 992, 3665.79036273613, 125, 20, false, '2023-09-20 15:45:11.998123', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (179, '892954819', 2023, 2, 417, 8880.53130168742, 125, 4, false, '2023-09-20 15:45:11.998123', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (180, '816644800', 2023, 2, 419, 1672.44588907709, 125, 17, false, '2023-09-20 15:45:11.998123', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (181, '806220031', 2023, 2, 148, 2366.4721658678, 125, 17, false, '2023-09-20 15:45:11.998123', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (182, '894638284', 2023, 2, 508, 2069.98771082203, 125, 7, false, '2023-09-20 15:45:11.998123', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (183, '878312512', 2023, 2, 234, 2803.36499132046, 125, 4, false, '2023-09-20 15:45:11.998123', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (184, '842491957', 2023, 2, 780, 5817.12444757722, 125, 15, false, '2023-09-20 15:45:11.998123', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (185, '834513291', 2023, 2, 974, 4151.70685362898, 125, 12, false, '2023-09-20 15:45:12.111129', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (186, '810550084', 2023, 2, 106, 4571.99447616705, 125, 3, false, '2023-09-20 15:45:12.111129', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (187, '803121336', 2023, 2, 588, 1395.02657040468, 125, 12, false, '2023-09-20 15:45:12.111129', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (188, '828279257', 2023, 2, 221, 9587.18916674658, 125, 8, false, '2023-09-20 15:45:12.111129', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (189, '859330839', 2023, 2, 209, 5417.75768726678, 125, 13, false, '2023-09-20 15:45:12.340202', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (190, '830488574', 2023, 2, 145, 5550.30473999626, 125, 10, false, '2023-09-20 15:45:12.340202', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (191, '857478770', 2023, 2, 291, 4072.97702722372, 125, 20, false, '2023-09-20 15:45:12.340202', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (192, '887040001', 2023, 2, 745, 1584.8594788078, 125, 18, false, '2023-09-20 15:45:12.340202', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (193, '891364302', 2023, 2, 103, 1645.24699553456, 125, 7, false, '2023-09-20 15:45:12.340202', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (194, '843653815', 2023, 2, 106, 2800.43309306827, 125, 13, false, '2023-09-20 15:45:12.340202', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (195, '845887942', 2023, 2, 836, 8432.31605949234, 125, 3, false, '2023-09-20 15:45:12.540749', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (196, '861150977', 2023, 2, 589, 8387.54873868679, 125, 1, false, '2023-09-20 15:45:12.540749', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (197, '868136854', 2023, 2, 262, 9916.29877967274, 125, 14, false, '2023-09-20 15:45:12.540749', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (198, '870704831', 2023, 2, 500, 6476.18996819433, 125, 14, false, '2023-09-20 15:45:12.540749', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (199, '889143962', 2023, 2, 718, 9555.27746876726, 125, 12, false, '2023-09-20 15:45:12.540749', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (200, '818905666', 2023, 2, 318, 2431.83929991294, 125, 9, false, '2023-09-20 15:45:12.540749', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (201, '843833062', 2023, 2, 52, 4211.83892942973, 125, 17, false, '2023-09-20 15:45:12.540749', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (202, '866329394', 2023, 2, 590, 6660.34218263959, 125, 15, false, '2023-09-20 15:45:12.540749', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (203, '821557660', 2023, 2, 898, 2732.39325897644, 125, 11, false, '2023-09-20 15:45:12.624124', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (204, '883078463', 2023, 2, 359, 6645.50293755518, 125, 9, false, '2023-09-20 15:45:12.624124', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (205, '873714856', 2023, 2, 461, 14.9102459791187, 125, 13, false, '2023-09-20 15:45:12.624124', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (206, '877777665', 2023, 2, 614, 9926.66175557552, 125, 9, false, '2023-09-20 15:45:12.624124', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (207, '876064107', 2023, 2, 834, 9354.21409612798, 125, 14, false, '2023-09-20 15:45:12.624124', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (208, '891563436', 2023, 2, 435, 296.498118041634, 125, 19, false, '2023-09-20 15:45:12.624124', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (209, '827967499', 2023, 2, 327, 1737.8143964349, 125, 1, false, '2023-09-20 15:45:12.624124', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (210, '898942783', 2023, 2, 851, 904.626303832028, 125, 10, false, '2023-09-20 15:45:12.624124', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (211, '836937976', 2023, 2, 721, 9023.80308472197, 125, 17, false, '2023-09-20 15:45:12.711418', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (212, '804568928', 2023, 2, 553, 416.527798812108, 125, 14, false, '2023-09-20 15:45:12.711418', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (213, '800503985', 2023, 2, 730, 688.773448016493, 125, 12, false, '2023-09-20 15:45:12.711418', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (214, '813990535', 2023, 2, 10, 4329.68470794792, 125, 15, false, '2023-09-20 15:45:12.711418', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (215, '890758402', 2023, 2, 369, 3548.46799569368, 125, 14, false, '2023-09-20 15:45:12.711418', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (216, '811028317', 2023, 2, 213, 5186.99005289565, 125, 7, false, '2023-09-20 15:45:12.711418', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (217, '804760052', 2023, 2, 174, 1791.76803497525, 125, 7, false, '2023-09-20 15:45:12.711418', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (218, '838548431', 2023, 2, 245, 2546.5429382384, 125, 19, false, '2023-09-20 15:45:12.711418', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (219, '896612714', 2023, 2, 852, 8258.70397159052, 125, 7, false, '2023-09-20 15:45:12.711418', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (220, '851496542', 2023, 2, 771, 1092.77620089097, 125, 17, false, '2023-09-20 15:45:12.769373', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (221, '818563585', 2023, 2, 159, 1532.9763697277, 125, 8, false, '2023-09-20 15:45:12.769373', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (222, '875669833', 2023, 2, 600, 8693.36444599159, 125, 18, false, '2023-09-20 15:45:12.769373', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (223, '819785171', 2023, 2, 640, 9113.42584424329, 125, 7, false, '2023-09-20 15:45:12.769373', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (224, '828584499', 2023, 2, 395, 7488.15404630413, 125, 6, false, '2023-09-20 15:45:12.769373', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (225, '843434835', 2023, 2, 404, 6333.09638351814, 125, 5, false, '2023-09-20 15:45:12.769373', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (226, '875354392', 2023, 2, 341, 4040.30437831684, 125, 10, false, '2023-09-20 15:45:12.769373', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (227, '821764249', 2023, 2, 202, 4023.78830063805, 125, 16, false, '2023-09-20 15:45:12.769373', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (228, '879884092', 2023, 2, 891, 2551.51278082826, 125, 20, false, '2023-09-20 15:45:12.769373', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (229, '887508538', 2023, 2, 285, 5179.58125650349, 125, 16, false, '2023-09-20 15:45:12.795354', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (230, '854025366', 2023, 2, 423, 7607.71078229754, 125, 19, false, '2023-09-20 15:45:12.795354', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (231, '832495084', 2023, 2, 817, 9169.05202326347, 125, 9, false, '2023-09-20 15:45:12.795354', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (232, '819546494', 2023, 2, 217, 1533.78098642723, 125, 2, false, '2023-09-20 15:45:12.795354', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (233, '886234710', 2023, 2, 221, 6889.31986395708, 125, 9, false, '2023-09-20 15:45:12.795354', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (234, '863114808', 2023, 2, 70, 6305.6789480428, 125, 14, false, '2023-09-20 15:45:12.795354', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (235, '806585818', 2023, 2, 501, 6873.47436176504, 125, 18, false, '2023-09-20 15:45:12.795354', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (236, '869277026', 2023, 2, 932, 3817.93122120958, 125, 8, false, '2023-09-20 15:45:12.795354', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (237, '826601992', 2023, 2, 114, 4063.53837025484, 125, 11, false, '2023-09-20 15:45:12.821042', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (238, '845768352', 2023, 2, 981, 9080.7142810681, 125, 15, false, '2023-09-20 15:45:12.821042', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (239, '857606426', 2023, 2, 666, 9780.939978255, 125, 18, false, '2023-09-20 15:45:12.821042', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (240, '802627162', 2023, 2, 189, 2142.41998278399, 125, 11, false, '2023-09-20 15:45:12.821042', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (241, '896062995', 2023, 2, 387, 8192.12850633248, 125, 12, false, '2023-09-20 15:45:12.821042', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (242, '802773451', 2023, 2, 201, 34.3436656272727, 125, 13, false, '2023-09-20 15:45:12.851947', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (243, '897412501', 2023, 2, 281, 812.008487336822, 125, 13, false, '2023-09-20 15:45:12.851947', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (244, '877078417', 2023, 2, 750, 8933.05506390058, 125, 20, false, '2023-09-20 15:45:12.851947', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (245, '862364504', 2023, 2, 74, 62.1353268621904, 125, 6, false, '2023-09-20 15:45:12.851947', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (246, '819608759', 2023, 2, 528, 2332.26485858598, 125, 14, false, '2023-09-20 15:45:12.884356', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (247, '847772631', 2023, 2, 143, 3705.22160027071, 125, 4, false, '2023-09-20 15:45:12.884356', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (248, '867565514', 2023, 2, 276, 4799.64578344497, 125, 13, false, '2023-09-20 15:45:12.884356', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (249, '886230666', 2023, 2, 258, 7287.08567741632, 125, 8, false, '2023-09-20 15:45:12.884356', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (250, '890278607', 2023, 2, 728, 5661.9112020697, 125, 8, false, '2023-09-20 15:45:12.884356', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (251, '830954144', 2023, 2, 991, 7120.20367809844, 125, 12, false, '2023-09-20 15:45:12.884356', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (252, '840495641', 2023, 2, 142, 7533.47693294452, 125, 12, false, '2023-09-20 15:45:12.917771', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (253, '853665654', 2023, 2, 326, 6221.0485607651, 125, 11, false, '2023-09-20 15:45:12.917771', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (254, '883098123', 2023, 2, 486, 3946.34008174252, 125, 18, false, '2023-09-20 15:45:12.917771', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (255, '836163189', 2023, 2, 832, 355.912188907304, 125, 15, false, '2023-09-20 15:45:12.917771', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (256, '841569048', 2023, 2, 517, 2118.2839319651, 125, 10, false, '2023-09-20 15:45:12.917771', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (257, '834225226', 2023, 2, 920, 4043.71054949576, 125, 17, false, '2023-09-20 15:45:12.917771', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (258, '826987922', 2023, 2, 365, 136.286541170394, 125, 10, false, '2023-09-20 15:45:12.953164', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (259, '847906942', 2023, 2, 363, 2320.49410264541, 125, 5, false, '2023-09-20 15:45:12.953164', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (260, '841372702', 2023, 2, 906, 1477.85760016011, 125, 9, false, '2023-09-20 15:45:12.953164', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (261, '814696095', 2023, 2, 514, 4830.13140784609, 125, 6, false, '2023-09-20 15:45:12.984097', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (262, '800004513', 2023, 2, 619, 6622.23333333013, 125, 2, false, '2023-09-20 15:45:12.984097', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (263, '815510655', 2023, 2, 586, 1422.09376474613, 125, 13, false, '2023-09-20 15:45:12.984097', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (264, '807833757', 2023, 2, 589, 9854.66385353163, 125, 7, false, '2023-09-20 15:45:13.0205', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (265, '874913674', 2023, 2, 768, 7567.39696416086, 125, 6, false, '2023-09-20 15:45:13.0205', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (266, '865707207', 2023, 2, 69, 9993.13806964955, 125, 1, false, '2023-09-20 15:45:13.0205', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (267, '878813506', 2023, 2, 354, 8068.05677886871, 125, 2, false, '2023-09-20 15:45:13.0205', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (268, '863559303', 2023, 2, 830, 1415.17245250874, 125, 10, false, '2023-09-20 15:45:13.055158', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (269, '854841360', 2023, 2, 592, 5709.62444482775, 125, 17, false, '2023-09-20 15:45:13.055158', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (270, '893682691', 2023, 2, 872, 5173.25649234067, 125, 18, false, '2023-09-20 15:45:13.055158', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (271, '893949319', 2023, 2, 946, 5289.91625309053, 125, 7, false, '2023-09-20 15:45:13.055158', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (272, '825876867', 2023, 2, 920, 6711.72151730243, 125, 5, false, '2023-09-20 15:45:13.085874', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (273, '862102393', 2023, 2, 56, 7344.33867272556, 125, 20, false, '2023-09-20 15:45:13.085874', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (274, '876576630', 2023, 2, 590, 919.348227307517, 125, 18, false, '2023-09-20 15:45:13.085874', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (275, '839374478', 2023, 2, 780, 9020.38559096748, 125, 19, false, '2023-09-20 15:45:13.085874', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (276, '887074592', 2023, 2, 168, 4483.9245895596, 125, 5, false, '2023-09-20 15:45:13.085874', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (277, '858115058', 2023, 2, 974, 8847.83323297327, 125, 7, false, '2023-09-20 15:45:13.085874', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (278, '833758984', 2023, 2, 438, 3150.9844721365, 125, 18, false, '2023-09-20 15:45:13.11848', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (279, '861845843', 2023, 2, 75, 5903.62139436663, 125, 14, false, '2023-09-20 15:45:13.1616', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (280, '810021012', 2023, 2, 671, 1983.08156517473, 125, 14, false, '2023-09-20 15:45:13.1616', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (281, '874383060', 2023, 2, 414, 7239.34485570286, 125, 19, false, '2023-09-20 15:45:13.1616', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (282, '883377510', 2023, 2, 785, 4319.92162934805, 125, 13, false, '2023-09-20 15:45:13.1616', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (283, '839661067', 2023, 2, 166, 8149.00383766446, 125, 8, false, '2023-09-20 15:45:13.1616', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (284, '879881537', 2023, 2, 284, 9032.1425590147, 125, 20, false, '2023-09-20 15:45:13.1616', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (285, '854298397', 2023, 2, 748, 5204.7163341146, 125, 20, false, '2023-09-20 15:45:13.1616', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (286, '847858198', 2023, 2, 705, 7345.56728102056, 125, 11, false, '2023-09-20 15:45:13.1616', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (287, '876707327', 2023, 2, 721, 2400.21137950264, 125, 15, false, '2023-09-20 15:45:13.211139', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (288, '858699494', 2023, 2, 587, 6738.91596266979, 125, 15, false, '2023-09-20 15:45:13.211139', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (289, '861873966', 2023, 2, 578, 775.552155056594, 125, 7, false, '2023-09-20 15:45:13.211139', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (290, '888525472', 2023, 2, 783, 8198.45215631402, 125, 9, false, '2023-09-20 15:45:13.243834', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (291, '827662737', 2023, 2, 159, 6181.45813423698, 125, 14, false, '2023-09-20 15:45:13.243834', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (292, '819333814', 2023, 2, 401, 1552.2703294177, 125, 5, false, '2023-09-20 15:45:13.243834', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (293, '854962683', 2023, 2, 853, 8903.56580212133, 125, 18, false, '2023-09-20 15:45:13.243834', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (294, '826990918', 2023, 2, 543, 3885.39849919812, 125, 12, false, '2023-09-20 15:45:13.243834', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (295, '874654389', 2023, 2, 743, 5483.11805082067, 125, 8, false, '2023-09-20 15:45:13.273721', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (296, '871171774', 2023, 2, 883, 6168.56557210236, 125, 10, false, '2023-09-20 15:45:13.273721', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (297, '857723124', 2023, 2, 275, 749.52626124065, 125, 3, false, '2023-09-20 15:45:13.273721', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (298, '817427440', 2023, 2, 689, 9103.16394408249, 125, 6, false, '2023-09-20 15:45:13.273721', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (299, '827735226', 2023, 2, 880, 7988.18547507167, 125, 4, false, '2023-09-20 15:45:13.273721', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (300, '810373111', 2023, 2, 210, 8459.62028398681, 125, 7, false, '2023-09-20 15:45:13.304361', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (301, '828628162', 2023, 2, 777, 7436.5411833791, 125, 16, false, '2023-09-20 15:45:13.304361', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (302, '808837822', 2023, 2, 266, 7645.39756846378, 125, 9, false, '2023-09-20 15:45:13.304361', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (303, '813354371', 2023, 2, 516, 5278.88133507434, 125, 13, false, '2023-09-20 15:45:13.304361', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (304, '875316797', 2023, 2, 258, 9132.86291959143, 125, 15, false, '2023-09-20 15:45:13.304361', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (305, '811920494', 2023, 2, 740, 5670.36838197061, 125, 19, false, '2023-09-20 15:45:13.331988', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (306, '892369559', 2023, 2, 215, 6422.17875179379, 125, 19, false, '2023-09-20 15:45:13.331988', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (307, '873929526', 2023, 2, 539, 2313.41089021554, 125, 3, false, '2023-09-20 15:45:13.331988', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (308, '814663019', 2023, 2, 98, 1973.35418656161, 125, 6, false, '2023-09-20 15:45:13.331988', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (309, '873287552', 2023, 2, 708, 2883.59660328811, 125, 10, false, '2023-09-20 15:45:13.331988', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (310, '819360448', 2023, 2, 186, 796.502737607156, 125, 5, false, '2023-09-20 15:45:13.331988', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (311, '801440225', 2023, 2, 706, 6137.15065139669, 125, 13, false, '2023-09-20 15:45:13.355118', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (312, '868950634', 2023, 2, 114, 4937.31912703485, 125, 20, false, '2023-09-20 15:45:13.355118', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (313, '817957349', 2023, 2, 111, 664.187605282792, 125, 3, false, '2023-09-20 15:45:13.355118', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (314, '835966398', 2023, 2, 356, 3023.84165765018, 125, 4, false, '2023-09-20 15:45:13.355118', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (315, '834790743', 2023, 2, 701, 3506.94365384428, 125, 9, false, '2023-09-20 15:45:13.355118', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (316, '834442274', 2023, 2, 772, 602.402754356406, 125, 16, false, '2023-09-20 15:45:13.383836', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (317, '808252171', 2023, 2, 321, 702.582252078292, 125, 10, false, '2023-09-20 15:45:13.383836', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (318, '890248760', 2023, 2, 595, 5463.68187544958, 125, 19, false, '2023-09-20 15:45:13.383836', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (319, '865099482', 2023, 2, 819, 6056.88688223734, 125, 18, false, '2023-09-20 15:45:13.383836', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (320, '813221338', 2023, 2, 548, 51.4162613042475, 125, 15, false, '2023-09-20 15:45:13.383836', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (321, '842392037', 2023, 2, 937, 2087.74964522327, 125, 16, false, '2023-09-20 15:45:13.443399', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (322, '834385233', 2023, 2, 184, 3685.74352765659, 125, 15, false, '2023-09-20 15:45:13.443399', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (323, '849837990', 2023, 2, 526, 2897.29380539209, 125, 12, false, '2023-09-20 15:45:13.443399', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (324, '885923358', 2023, 2, 791, 229.560609073663, 125, 15, false, '2023-09-20 15:45:13.443399', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (325, '839996495', 2023, 2, 957, 5815.0989309566, 125, 1, false, '2023-09-20 15:45:13.443399', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (326, '811469589', 2023, 2, 773, 9744.58140992992, 125, 17, false, '2023-09-20 15:45:13.480515', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (327, '833437439', 2023, 2, 778, 6479.88072704615, 125, 10, false, '2023-09-20 15:45:13.480515', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (328, '826277182', 2023, 2, 848, 841.249993887573, 125, 20, false, '2023-09-20 15:45:13.480515', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (329, '865358050', 2023, 2, 467, 3986.82043983631, 125, 2, false, '2023-09-20 15:45:13.480515', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (330, '881698955', 2023, 2, 359, 5161.91894535164, 125, 12, false, '2023-09-20 15:45:13.480515', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (331, '855827742', 2023, 2, 22, 5351.96082322337, 125, 12, false, '2023-09-20 15:45:13.480515', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (332, '829288621', 2023, 2, 635, 6605.52302010995, 125, 13, false, '2023-09-20 15:45:13.480515', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (333, '893779608', 2023, 2, 311, 7703.12664850198, 125, 15, false, '2023-09-20 15:45:13.520557', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (334, '880882302', 2023, 2, 28, 794.887982024814, 125, 6, false, '2023-09-20 15:45:13.520557', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (335, '825497333', 2023, 2, 839, 8637.74302497123, 125, 9, false, '2023-09-20 15:45:13.520557', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (336, '898480863', 2023, 2, 278, 9403.86944804168, 125, 10, false, '2023-09-20 15:45:13.520557', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (337, '848313087', 2023, 2, 197, 5590.34212808659, 125, 12, false, '2023-09-20 15:45:13.520557', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (338, '806457638', 2023, 2, 75, 4600.31894831869, 125, 20, false, '2023-09-20 15:45:13.520557', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (339, '874065068', 2023, 2, 297, 2465.00194943991, 125, 12, false, '2023-09-20 15:45:13.520557', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (340, '877536857', 2023, 2, 719, 7847.10832868835, 125, 19, false, '2023-09-20 15:45:13.520557', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (341, '854048609', 2023, 2, 588, 9687.7472342675, 125, 11, false, '2023-09-20 15:45:13.56175', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (342, '826180431', 2023, 2, 431, 1604.3246532205, 125, 11, false, '2023-09-20 15:45:13.56175', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (343, '804810763', 2023, 2, 134, 9301.29156200167, 125, 1, false, '2023-09-20 15:45:13.56175', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (344, '824385833', 2023, 2, 744, 3912.51722797179, 125, 18, false, '2023-09-20 15:45:13.56175', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (345, '854115545', 2023, 2, 937, 8644.91780340932, 125, 16, false, '2023-09-20 15:45:13.56175', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (346, '892252172', 2023, 2, 354, 6402.79514015762, 125, 17, false, '2023-09-20 15:45:13.56175', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (347, '856868617', 2023, 2, 650, 7432.47671286727, 125, 2, false, '2023-09-20 15:45:13.594497', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (348, '835816352', 2023, 2, 713, 1237.51062210296, 125, 9, false, '2023-09-20 15:45:13.594497', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (349, '808489389', 2023, 2, 118, 6867.38054868697, 125, 9, false, '2023-09-20 15:45:13.594497', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (350, '842564595', 2023, 2, 59, 2413.02893367036, 125, 20, false, '2023-09-20 15:45:13.594497', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (351, '862487391', 2023, 2, 914, 30.31437013278, 125, 9, false, '2023-09-20 15:45:13.594497', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (352, '844864220', 2023, 2, 234, 679.553914591638, 125, 11, false, '2023-09-20 15:45:13.594497', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (353, '863745120', 2023, 2, 802, 8064.84213788297, 125, 8, false, '2023-09-20 15:45:13.594497', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (354, '811463659', 2023, 2, 359, 6672.71477076928, 125, 18, false, '2023-09-20 15:45:13.594497', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (355, '859424845', 2023, 2, 475, 7651.01632479522, 125, 14, false, '2023-09-20 15:45:13.594497', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (356, '826162593', 2023, 2, 16, 7607.66354211898, 125, 18, false, '2023-09-20 15:45:13.62447', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (357, '854501114', 2023, 2, 926, 8564.65440107601, 125, 16, false, '2023-09-20 15:45:13.62447', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (358, '837971247', 2023, 2, 928, 6010.86112474559, 125, 7, false, '2023-09-20 15:45:13.62447', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (359, '814526409', 2023, 2, 295, 7182.20949919497, 125, 20, false, '2023-09-20 15:45:13.62447', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (360, '889233452', 2023, 2, 218, 4372.1325751989, 125, 17, false, '2023-09-20 15:45:13.62447', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (361, '851933508', 2023, 2, 800, 7781.3214422504, 125, 2, false, '2023-09-20 15:45:13.62447', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (362, '886861663', 2023, 2, 913, 3855.11823688526, 125, 3, false, '2023-09-20 15:45:13.62447', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (363, '861967886', 2023, 2, 339, 5705.78612849966, 125, 13, false, '2023-09-20 15:45:13.62447', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (364, '824514650', 2023, 2, 703, 5395.18626147958, 125, 5, false, '2023-09-20 15:45:13.650987', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (365, '821686436', 2023, 2, 957, 6006.54829647355, 125, 13, false, '2023-09-20 15:45:13.650987', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (366, '879033196', 2023, 2, 768, 162.607584725471, 125, 13, false, '2023-09-20 15:45:13.650987', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (367, '843548997', 2023, 2, 712, 4584.33686677429, 125, 18, false, '2023-09-20 15:45:13.650987', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (368, '874858772', 2023, 2, 842, 185.990438043479, 125, 17, false, '2023-09-20 15:45:13.650987', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (369, '802656356', 2023, 2, 576, 278.347366282394, 125, 1, false, '2023-09-20 15:45:13.650987', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (370, '880863319', 2023, 2, 666, 8031.45761291442, 125, 6, false, '2023-09-20 15:45:13.680925', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (371, '818100493', 2023, 2, 642, 6947.8814607109, 125, 1, false, '2023-09-20 15:45:13.680925', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (372, '887531172', 2023, 2, 929, 2297.7012265186, 125, 10, false, '2023-09-20 15:45:13.680925', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (373, '897549565', 2023, 2, 400, 3472.57757891882, 125, 20, false, '2023-09-20 15:45:13.680925', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (374, '833746388', 2023, 2, 392, 9368.94170731561, 125, 16, false, '2023-09-20 15:45:13.680925', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (375, '864617557', 2023, 2, 325, 7472.65116805325, 125, 13, false, '2023-09-20 15:45:13.708486', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (376, '885749792', 2023, 2, 523, 9101.46840636272, 125, 4, false, '2023-09-20 15:45:13.708486', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (377, '854373649', 2023, 2, 932, 5384.8414996671, 125, 6, false, '2023-09-20 15:45:13.708486', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (378, '848288114', 2023, 2, 479, 7903.01514699266, 125, 20, false, '2023-09-20 15:45:13.708486', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (379, '822516713', 2023, 2, 448, 7799.06223793927, 125, 15, false, '2023-09-20 15:45:13.708486', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (380, '850613686', 2023, 2, 647, 3387.97534407066, 125, 12, false, '2023-09-20 15:45:13.708486', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (381, '852103064', 2023, 2, 422, 2452.72329726584, 125, 16, false, '2023-09-20 15:45:13.708486', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (382, '887895969', 2023, 2, 486, 3331.56630328401, 125, 14, false, '2023-09-20 15:45:13.737017', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (383, '897049098', 2023, 2, 937, 8206.8292865933, 125, 12, false, '2023-09-20 15:45:13.737017', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (384, '802649242', 2023, 2, 738, 9003.25499285812, 125, 16, false, '2023-09-20 15:45:13.737017', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (385, '857503747', 2023, 2, 337, 6541.46125240817, 125, 2, false, '2023-09-20 15:45:13.737017', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (386, '884369375', 2023, 2, 98, 5452.23841646784, 125, 6, false, '2023-09-20 15:45:13.737017', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (387, '829935543', 2023, 2, 570, 8719.03955912363, 125, 11, false, '2023-09-20 15:45:13.737017', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (388, '802777851', 2023, 2, 271, 1631.23089022574, 125, 8, false, '2023-09-20 15:45:13.737017', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (389, '841413884', 2023, 2, 682, 688.690538321936, 125, 5, false, '2023-09-20 15:45:13.76696', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (390, '823768843', 2023, 2, 494, 5825.49690327711, 125, 16, false, '2023-09-20 15:45:13.76696', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (391, '871525212', 2023, 2, 590, 4424.9545292021, 125, 6, false, '2023-09-20 15:45:13.76696', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (392, '808924277', 2023, 2, 822, 1940.31523392499, 125, 10, false, '2023-09-20 15:45:13.76696', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (393, '851159913', 2023, 2, 120, 1657.79330378304, 125, 4, false, '2023-09-20 15:45:13.76696', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (394, '836866744', 2023, 2, 927, 9872.59948997153, 125, 12, false, '2023-09-20 15:45:13.76696', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (395, '847553918', 2023, 2, 931, 1109.2116532476, 125, 2, false, '2023-09-20 15:45:13.797413', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (396, '822664169', 2023, 2, 694, 6551.10232049405, 125, 16, false, '2023-09-20 15:45:13.797413', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (397, '835875990', 2023, 2, 36, 9037.53891771841, 125, 5, false, '2023-09-20 15:45:13.797413', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (398, '829279885', 2023, 2, 352, 2629.4071582662, 125, 7, false, '2023-09-20 15:45:13.797413', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (399, '807835433', 2023, 2, 721, 3741.97243529294, 125, 14, false, '2023-09-20 15:45:13.797413', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (400, '891539796', 2023, 2, 342, 100.772620303841, 125, 15, false, '2023-09-20 15:45:13.797413', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (401, '835688521', 2023, 2, 177, 7108.91239356101, 125, 3, false, '2023-09-20 15:45:13.797413', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (402, '824680928', 2023, 2, 595, 492.542205945535, 125, 12, false, '2023-09-20 15:45:13.823065', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (403, '883936426', 2023, 2, 531, 903.738764251393, 125, 6, false, '2023-09-20 15:45:13.823065', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (404, '891833338', 2023, 2, 722, 827.152928619069, 125, 12, false, '2023-09-20 15:45:13.823065', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (405, '878031681', 2023, 2, 352, 9471.68794570781, 125, 15, false, '2023-09-20 15:45:13.823065', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (406, '845521141', 2023, 2, 417, 7971.10826656438, 125, 6, false, '2023-09-20 15:45:13.823065', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (407, '809976227', 2023, 2, 55, 5920.29765756817, 125, 12, false, '2023-09-20 15:45:13.823065', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (408, '859355587', 2023, 2, 347, 6449.82214707062, 125, 15, false, '2023-09-20 15:45:13.849007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (409, '807325397', 2023, 2, 664, 3009.76959988919, 125, 11, false, '2023-09-20 15:45:13.849007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (410, '891463624', 2023, 2, 146, 1090.81541952155, 125, 16, false, '2023-09-20 15:45:13.849007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (411, '895835975', 2023, 2, 195, 9405.54867412122, 125, 1, false, '2023-09-20 15:45:13.849007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (412, '809233627', 2023, 2, 434, 8970.73149376192, 125, 19, false, '2023-09-20 15:45:13.849007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (413, '889087670', 2023, 2, 203, 1690.18678801154, 125, 8, false, '2023-09-20 15:45:13.849007', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (414, '820335833', 2023, 2, 271, 4153.05959947723, 125, 2, false, '2023-09-20 15:45:13.884512', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (415, '898003942', 2023, 2, 605, 9450.29992464346, 125, 12, false, '2023-09-20 15:45:13.884512', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (416, '892725587', 2023, 2, 93, 6591.06313631851, 125, 15, false, '2023-09-20 15:45:13.884512', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (417, '874702974', 2023, 2, 393, 4641.85003531448, 125, 10, false, '2023-09-20 15:45:13.884512', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (418, '814697430', 2023, 2, 927, 4125.68844932521, 125, 10, false, '2023-09-20 15:45:13.884512', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (419, '868394680', 2023, 2, 401, 7063.9433158362, 125, 15, false, '2023-09-20 15:45:13.884512', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (420, '868827435', 2023, 2, 545, 4012.16390124892, 125, 16, false, '2023-09-20 15:45:13.884512', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (421, '826836538', 2023, 2, 987, 9119.93349162668, 125, 1, false, '2023-09-20 15:45:13.884512', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (422, '852363701', 2023, 2, 439, 2298.64586222645, 125, 12, false, '2023-09-20 15:45:13.925196', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (423, '843954573', 2023, 2, 132, 303.405924150827, 125, 19, false, '2023-09-20 15:45:13.925196', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (424, '854299147', 2023, 2, 24, 9981.12202147139, 125, 12, false, '2023-09-20 15:45:13.925196', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (425, '878570568', 2023, 2, 554, 9116.21021362356, 125, 17, false, '2023-09-20 15:45:13.925196', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (426, '853068332', 2023, 2, 902, 3333.68987203083, 125, 14, false, '2023-09-20 15:45:13.976387', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (427, '855430467', 2023, 2, 926, 7768.74677247762, 125, 14, false, '2023-09-20 15:45:13.976387', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (428, '894685451', 2023, 2, 837, 6062.58960445842, 125, 4, false, '2023-09-20 15:45:13.976387', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (429, '822981409', 2023, 2, 257, 5021.98696150324, 125, 14, false, '2023-09-20 15:45:13.976387', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (430, '831415693', 2023, 2, 740, 4271.59870856293, 125, 9, false, '2023-09-20 15:45:13.976387', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (431, '846100277', 2023, 2, 668, 8352.08336056541, 125, 9, false, '2023-09-20 15:45:13.976387', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (432, '847750948', 2023, 2, 949, 1849.11105456617, 125, 20, false, '2023-09-20 15:45:13.976387', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (433, '874157752', 2023, 2, 816, 6968.78593926496, 125, 10, false, '2023-09-20 15:45:13.976387', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (434, '875537262', 2023, 2, 614, 9397.32253038491, 125, 15, false, '2023-09-20 15:45:14.010744', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (435, '818277813', 2023, 2, 787, 4446.52087297693, 125, 9, false, '2023-09-20 15:45:14.010744', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (436, '826608733', 2023, 2, 985, 1511.4160490024, 125, 19, false, '2023-09-20 15:45:14.010744', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (437, '819654730', 2023, 2, 538, 4970.71576616595, 125, 4, false, '2023-09-20 15:45:14.010744', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (438, '858734514', 2023, 2, 189, 166.201741004434, 125, 7, false, '2023-09-20 15:45:14.010744', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (439, '887394013', 2023, 2, 535, 7704.47929513189, 125, 11, false, '2023-09-20 15:45:14.056894', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (440, '806978546', 2023, 2, 132, 5919.23456592097, 125, 20, false, '2023-09-20 15:45:14.056894', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (441, '832921799', 2023, 2, 322, 3659.15625045223, 125, 3, false, '2023-09-20 15:45:14.056894', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (442, '839653608', 2023, 2, 240, 7885.64223868903, 125, 20, false, '2023-09-20 15:45:14.056894', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (443, '823764470', 2023, 2, 309, 9242.43763652365, 125, 4, false, '2023-09-20 15:45:14.056894', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (444, '808654021', 2023, 2, 640, 7241.56128461834, 125, 3, false, '2023-09-20 15:45:14.056894', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (445, '845791967', 2023, 2, 674, 4005.63399106579, 125, 9, false, '2023-09-20 15:45:14.093369', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (446, '813492132', 2023, 2, 580, 5572.05260752102, 125, 15, false, '2023-09-20 15:45:14.093369', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (447, '886404438', 2023, 2, 854, 6085.76090445121, 125, 9, false, '2023-09-20 15:45:14.093369', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (448, '826906234', 2023, 2, 749, 5923.92515171854, 125, 12, false, '2023-09-20 15:45:14.093369', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (449, '884842532', 2023, 2, 328, 3394.64640247693, 125, 6, false, '2023-09-20 15:45:14.093369', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (450, '823806402', 2023, 2, 93, 725.409255700043, 125, 19, false, '2023-09-20 15:45:14.142461', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (451, '828511475', 2023, 2, 232, 7334.60454543309, 125, 10, false, '2023-09-20 15:45:14.142461', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (452, '874812930', 2023, 2, 277, 1685.82861616349, 125, 15, false, '2023-09-20 15:45:14.142461', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (453, '826631179', 2023, 2, 276, 9618.40773633724, 125, 9, false, '2023-09-20 15:45:14.142461', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (454, '835704192', 2023, 2, 402, 6542.3733980313, 125, 13, false, '2023-09-20 15:45:14.142461', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (455, '850136949', 2023, 2, 960, 3064.32824350579, 125, 13, false, '2023-09-20 15:45:14.142461', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (456, '843057612', 2023, 2, 596, 6859.36285126732, 125, 11, false, '2023-09-20 15:45:14.142461', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (457, '840861739', 2023, 2, 86, 7064.7346779073, 125, 10, false, '2023-09-20 15:45:14.204869', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (458, '805101105', 2023, 2, 367, 1735.33739008478, 125, 1, false, '2023-09-20 15:45:14.204869', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (459, '887848461', 2023, 2, 945, 5854.1179845024, 125, 17, false, '2023-09-20 15:45:14.204869', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (460, '893141706', 2023, 2, 858, 9783.45888690489, 125, 12, false, '2023-09-20 15:45:14.204869', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (461, '821432696', 2023, 2, 65, 2426.1483705429, 125, 6, false, '2023-09-20 15:45:14.204869', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (462, '837300396', 2023, 2, 802, 8126.11929374969, 125, 15, false, '2023-09-20 15:45:14.204869', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (463, '809023320', 2023, 2, 260, 2867.95410196598, 125, 8, false, '2023-09-20 15:45:14.204869', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (464, '868307087', 2023, 2, 725, 4234.42538921772, 125, 3, false, '2023-09-20 15:45:14.252602', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (465, '843098741', 2023, 2, 322, 9144.24199411959, 125, 13, false, '2023-09-20 15:45:14.252602', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (466, '815697017', 2023, 2, 487, 3503.66759178446, 125, 14, false, '2023-09-20 15:45:14.252602', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (467, '828447962', 2023, 2, 837, 7517.53590486519, 125, 12, false, '2023-09-20 15:45:14.252602', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (468, '822609218', 2023, 2, 380, 1986.55155419278, 125, 19, false, '2023-09-20 15:45:14.252602', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (469, '836946437', 2023, 2, 436, 3856.46515166437, 125, 4, false, '2023-09-20 15:45:14.252602', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (470, '883685594', 2023, 2, 710, 7054.95110213365, 125, 16, false, '2023-09-20 15:45:14.252602', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (471, '840392436', 2023, 2, 286, 4096.01778629305, 125, 4, false, '2023-09-20 15:45:14.252602', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (472, '856806194', 2023, 2, 533, 3002.15860619201, 125, 7, false, '2023-09-20 15:45:14.252602', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (473, '806990673', 2023, 2, 263, 6644.71048768006, 125, 16, false, '2023-09-20 15:45:14.252602', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (474, '813595696', 2023, 2, 646, 6169.24629821929, 125, 16, false, '2023-09-20 15:45:14.252602', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (475, '891297613', 2023, 2, 204, 7935.11426818221, 125, 16, false, '2023-09-20 15:45:14.299446', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (476, '853554657', 2023, 2, 134, 1746.39204680449, 125, 17, false, '2023-09-20 15:45:14.299446', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (477, '849153261', 2023, 2, 547, 918.420742206094, 125, 8, false, '2023-09-20 15:45:14.299446', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (478, '827837752', 2023, 2, 251, 6600.90725410954, 125, 3, false, '2023-09-20 15:45:14.299446', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (479, '839978531', 2023, 2, 960, 5173.38053455733, 125, 9, false, '2023-09-20 15:45:14.299446', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (480, '804482373', 2023, 2, 156, 9548.64455656951, 125, 18, false, '2023-09-20 15:45:14.299446', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (481, '828759753', 2023, 2, 127, 5299.70652007227, 125, 10, false, '2023-09-20 15:45:14.299446', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (482, '849497625', 2023, 2, 316, 8994.5232160093, 125, 17, false, '2023-09-20 15:45:14.299446', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (483, '872494324', 2023, 2, 5, 7236.98642893744, 125, 13, false, '2023-09-20 15:45:14.299446', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (484, '891327339', 2023, 2, 911, 8311.48033767943, 125, 14, false, '2023-09-20 15:45:14.344888', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (485, '856498534', 2023, 2, 520, 6457.54175792948, 125, 7, false, '2023-09-20 15:45:14.344888', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (486, '869823047', 2023, 2, 246, 9948.77514556472, 125, 12, false, '2023-09-20 15:45:14.344888', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (487, '854842974', 2023, 2, 287, 9833.66398060291, 125, 15, false, '2023-09-20 15:45:14.344888', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (488, '887264644', 2023, 2, 148, 6242.7182621409, 125, 10, false, '2023-09-20 15:45:14.3752', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (489, '827930910', 2023, 2, 141, 1667.8064575391, 125, 2, false, '2023-09-20 15:45:14.3752', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (490, '834399652', 2023, 2, 442, 8092.24779668732, 125, 3, false, '2023-09-20 15:45:14.3752', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (491, '850604719', 2023, 2, 609, 7532.75014213521, 125, 9, false, '2023-09-20 15:45:14.3752', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (492, '811194793', 2023, 2, 368, 1280.77870837972, 125, 18, false, '2023-09-20 15:45:14.3752', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (493, '808172276', 2023, 2, 827, 5588.71038801919, 125, 20, false, '2023-09-20 15:45:14.411564', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (494, '846382671', 2023, 2, 445, 1851.90856243063, 125, 18, false, '2023-09-20 15:45:14.411564', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (495, '890681775', 2023, 2, 439, 6470.37107239692, 125, 18, false, '2023-09-20 15:45:14.411564', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (496, '878720665', 2023, 2, 89, 4528.72760142016, 125, 12, false, '2023-09-20 15:45:14.411564', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (497, '823309582', 2023, 2, 825, 7163.6720853343, 125, 13, false, '2023-09-20 15:45:14.411564', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (498, '898744138', 2023, 2, 809, 7251.84970195909, 125, 6, false, '2023-09-20 15:45:14.458734', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (499, '829172773', 2023, 2, 410, 7969.54245759316, 125, 20, false, '2023-09-20 15:45:14.458734', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (500, '823080067', 2023, 2, 140, 4950.64650281959, 125, 10, false, '2023-09-20 15:45:14.458734', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (501, '866404258', 2023, 2, 806, 2523.8783460754, 125, 11, false, '2023-09-20 15:45:14.458734', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (502, '881286826', 2023, 2, 588, 6110.76968411172, 125, 11, false, '2023-09-20 15:45:14.458734', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (503, '834002266', 2023, 2, 388, 7700.1742089915, 125, 17, false, '2023-09-20 15:45:14.497808', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (504, '806570115', 2023, 2, 184, 8433.51993446316, 125, 16, false, '2023-09-20 15:45:14.497808', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (505, '808483887', 2023, 2, 104, 4480.50241269345, 125, 14, false, '2023-09-20 15:45:14.497808', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (506, '862698070', 2023, 2, 405, 9733.52963284979, 125, 11, false, '2023-09-20 15:45:14.497808', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (507, '807756994', 2023, 2, 830, 2993.05414389141, 125, 11, false, '2023-09-20 15:45:14.497808', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (508, '824085351', 2023, 2, 613, 1678.04632323857, 125, 4, false, '2023-09-20 15:45:14.497808', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (509, '866496146', 2023, 2, 946, 9792.84633017946, 125, 20, false, '2023-09-20 15:45:14.497808', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (510, '895153005', 2023, 2, 796, 415.143349248899, 125, 20, false, '2023-09-20 15:45:14.534062', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (511, '840237839', 2023, 2, 366, 2858.19415170303, 125, 12, false, '2023-09-20 15:45:14.534062', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (512, '873832109', 2023, 2, 182, 8431.14129165654, 125, 19, false, '2023-09-20 15:45:14.534062', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (513, '876884282', 2023, 2, 154, 5947.69784832842, 125, 5, false, '2023-09-20 15:45:14.534062', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (514, '858719326', 2023, 2, 695, 7613.63619299012, 125, 8, false, '2023-09-20 15:45:14.534062', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (515, '827064129', 2023, 2, 745, 5657.7133323315, 125, 12, false, '2023-09-20 15:45:18.739278', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (516, '827416008', 2023, 2, 117, 3874.37218378942, 125, 3, false, '2023-09-20 15:45:18.756016', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (517, '809867706', 2023, 2, 417, 6717.59871664441, 125, 18, false, '2023-09-20 15:45:18.768099', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (518, '864835591', 2023, 2, 362, 3215.73058626983, 125, 8, false, '2023-09-20 15:45:18.768099', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (519, '873229058', 2023, 2, 410, 5156.31799529739, 125, 10, false, '2023-09-20 15:45:18.785235', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (520, '864612934', 2023, 2, 645, 7678.31829288659, 125, 16, false, '2023-09-20 15:45:18.785235', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (521, '801778443', 2023, 2, 790, 7038.98634552193, 125, 6, false, '2023-09-20 15:45:18.785235', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (522, '810327990', 2023, 2, 433, 1273.49639342645, 125, 10, false, '2023-09-20 15:45:18.785235', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (523, '824034863', 2023, 2, 513, 8675.03603577683, 125, 9, false, '2023-09-20 15:45:18.810567', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (524, '821066600', 2023, 2, 75, 4599.18310859811, 125, 4, false, '2023-09-20 15:45:18.810567', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (525, '856178317', 2023, 2, 389, 4634.43633457922, 125, 9, false, '2023-09-20 15:45:18.810567', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (526, '881392469', 2023, 2, 479, 3067.09157660122, 125, 5, false, '2023-09-20 15:45:18.810567', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (527, '800325562', 2023, 2, 772, 7163.21378933107, 125, 15, false, '2023-09-20 15:45:18.83307', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (528, '832006833', 2023, 2, 260, 7859.50139172445, 125, 17, false, '2023-09-20 15:45:18.83307', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (529, '841487607', 2023, 2, 129, 9128.62588033202, 125, 5, false, '2023-09-20 15:45:18.83307', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (530, '809374902', 2023, 2, 990, 4156.02599288813, 125, 2, false, '2023-09-20 15:45:18.83307', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (531, '803371521', 2023, 2, 5, 4789.34073797707, 125, 19, false, '2023-09-20 15:45:18.851565', NULL);
INSERT INTO public.sykefravar_statistikk_virksomhet VALUES (532, '848006818', 2023, 2, 18, 5172.70129954025, 125, 13, false, '2023-09-20 15:45:18.851565', NULL);


--
-- Data for Name: sykefravar_statistikk_virksomhet_siste_4_kvartal; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (1, '987654321', 27696.1814572421, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:10.839643', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (2, '987654321', 27696.1814572421, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:10.865199', 1, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (3, '123456789', 16984.6964228906, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:10.888786', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (4, '123456789', 16984.6964228906, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:10.888786', 1, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (5, '555555555', 23537.9642963659, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:10.888786', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (6, '817218179', 11842.2729682517, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:10.888786', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (7, '817218179', 11842.2729682517, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:10.888786', 1, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (8, '858315727', 9315.74808310796, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:10.921721', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (9, '858315727', 9315.74808310796, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:10.921721', 1, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (10, '867886062', 317.025113617594, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:10.921721', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (11, '867886062', 317.025113617594, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:10.921721', 1, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (12, '855774607', 25643.6506875185, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:10.951399', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (13, '855774607', 25643.6506875185, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:10.951399', 1, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (14, '827015467', 16017.1479738679, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:10.951399', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (15, '805290389', 14527.4713124532, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:10.951399', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (16, '857768316', 34055.9487533086, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:10.951399', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (17, '878440626', 15945.2784666011, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:10.951399', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (18, '837670234', 29230.4663592265, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:10.982219', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (19, '869337023', 16023.778697252, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:10.982219', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (20, '868310560', 36231.5076160233, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:10.982219', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (21, '854189604', 30300.9344873773, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:10.982219', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (22, '868245401', 33127.7375697729, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:10.982219', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (23, '887421757', 25299.177076337, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.02025', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (24, '801201600', 39596.2705042055, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.02025', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (25, '853912646', 36002.0768088407, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.02025', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (26, '871483086', 19664.8680842379, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.02025', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (27, '889480505', 16475.9574739879, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.02025', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (28, '889747942', 18560.4270268192, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.02025', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (29, '862875196', 33835.5006616331, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.055198', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (30, '855525313', 11127.3114616303, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.055198', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (31, '811443790', 23268.5610382272, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.055198', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (32, '833573552', 17669.4735485557, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.055198', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (33, '819462272', 3281.40810504178, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.055198', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (34, '856293477', 1833.51372555088, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.055198', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (35, '882254761', 13268.4218580116, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.102095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (36, '855039001', 11603.2402136395, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.102095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (37, '824009121', 28514.7908535585, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.102095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (38, '800497744', 14097.8780593995, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.102095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (39, '844731879', 3606.56280930528, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.102095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (40, '840016805', 14701.3311732695, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.102095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (41, '888553487', 35110.2133380493, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.102095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (42, '806720589', 11410.3969725464, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.102095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (43, '837337985', 18183.9316631623, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.102095', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (44, '874871261', 1924.35159872937, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.168691', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (45, '801074620', 10448.3287878466, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.168691', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (46, '876853959', 4434.90734496497, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.168691', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (47, '889812652', 19208.627109349, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.168691', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (48, '839437706', 23724.4730534139, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.168691', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (49, '845771147', 39212.9206470538, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.168691', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (50, '855530089', 23092.9952135984, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.168691', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (51, '892871410', 31657.2131725765, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.168691', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (52, '874569933', 6237.67021177667, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.168691', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (53, '890920316', 26772.0982683453, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.168691', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (54, '806574144', 17586.4763857807, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.225031', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (55, '897019567', 13769.2690796377, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.225031', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (56, '899744758', 5339.07203393113, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.225031', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (57, '879055458', 17215.7199909252, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.225031', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (58, '849291295', 35427.2411057185, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.225031', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (59, '876484129', 34129.420747911, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.225031', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (60, '804794544', 20152.9898763051, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.225031', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (61, '801414721', 6592.60824745222, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.225031', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (62, '853084595', 2028.21356111639, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.269392', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (63, '814750942', 1396.66114644894, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.269392', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (64, '894248802', 33705.8829451554, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.269392', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (65, '895438962', 14428.9392081018, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.269392', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (66, '894222980', 23068.8024445321, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.269392', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (67, '892644608', 24541.1629415314, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.269392', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (68, '861296525', 9138.58170458761, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.269392', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (69, '856974053', 20804.1569649279, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.269392', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (70, '893401740', 194.547003300144, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.269392', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (71, '898873892', 32729.9757634539, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.269392', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (72, '890416553', 23817.7226932875, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.324855', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (73, '883382387', 26212.8254636081, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.324855', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (74, '819780616', 27633.0539384631, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.324855', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (75, '840103549', 16399.6280365498, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.324855', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (76, '858398076', 33577.0219425852, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.324855', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (77, '820203200', 14398.6435883658, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.366048', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (78, '815962275', 8856.51182544, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.366048', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (79, '858135043', 28804.3999752888, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.366048', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (80, '808027924', 30127.0781913903, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.366048', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (81, '825903416', 12361.542216558, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.366048', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (82, '824836141', 27289.606505456, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.366048', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (83, '832710844', 8913.17243934928, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.366048', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (84, '842362113', 31169.9286650187, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.366048', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (85, '850606669', 35668.4927275034, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.366048', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (86, '850242937', 35450.7855403162, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.413365', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (87, '828871863', 3320.20597719413, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.413365', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (88, '822859420', 10280.6095053914, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.413365', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (89, '843001698', 5591.40592040972, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.413365', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (90, '831692857', 24189.5018197384, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.413365', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (91, '886195004', 9066.99409288497, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.449294', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (92, '813134297', 33598.6738499428, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.449294', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (93, '854341349', 35052.6659247157, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.449294', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (94, '852255739', 13303.0689736404, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.449294', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (95, '831919224', 39530.0353851048, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.449294', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (96, '893956693', 36130.112142344, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.449294', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (97, '887068890', 8326.38841034466, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.449294', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (98, '859377546', 35597.0865693889, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.449294', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (99, '808337271', 30478.0532521465, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.492165', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (100, '892079041', 34019.9270082222, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.492165', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (101, '825309841', 34278.392497382, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.492165', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (102, '899283543', 6258.72514644035, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.492165', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (103, '836105668', 25464.8621165073, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.521184', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (104, '899617322', 1755.1119952475, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.521184', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (105, '897369016', 5845.51245554886, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.521184', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (106, '847909287', 20901.9122903694, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.521184', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (107, '885363201', 7316.76114468795, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.521184', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (108, '895703494', 20756.1519810177, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.521184', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (109, '805582082', 28858.1668435548, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.521184', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (110, '831313921', 39413.6390393433, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.521184', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (111, '887250798', 35801.6151502445, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.521184', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (112, '876662451', 33517.8271717749, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.57794', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (113, '829725165', 24462.0306736512, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.57794', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (114, '862196487', 36141.7242743579, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.57794', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (115, '851434861', 29936.2679496077, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.57794', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (116, '861181928', 39359.9055025469, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.617583', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (117, '852787577', 26013.5081559353, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.617583', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (118, '801830575', 25955.9833369659, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.617583', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (119, '836614467', 22501.9735265582, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.617583', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (120, '893864437', 17824.783782025, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.617583', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (121, '831824518', 18919.5651100745, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.617583', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (122, '824296444', 5865.11101913999, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.617583', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (123, '869460321', 13100.2910567419, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.671587', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (124, '808176785', 20559.8405677643, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.671587', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (125, '863481189', 13737.3566320051, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.671587', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (126, '891032390', 12165.7567626463, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.671587', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (127, '827341816', 38496.3140718632, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.671587', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (128, '897698399', 15705.3795007881, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.671587', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (129, '890446075', 34281.7144269016, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.707471', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (130, '845411087', 30819.0279940764, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.707471', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (131, '873878975', 7821.64129683886, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.707471', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (132, '823474091', 28249.0799760374, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.707471', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (133, '807676378', 15122.109749929, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.707471', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (134, '832530561', 24363.4936631258, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.707471', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (135, '848331429', 26995.4046780968, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.707471', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (136, '857977631', 4930.21143144927, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.707471', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (137, '821437524', 35442.7574721041, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.707471', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (138, '813058997', 855.524771957625, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.707471', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (139, '817599634', 32658.0357494654, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.764328', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (140, '841754369', 24805.0470782735, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.764328', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (141, '848123425', 10383.3474967165, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.764328', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (142, '823949946', 27188.6107812094, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.764328', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (143, '830259693', 29250.4098338749, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.764328', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (144, '825960020', 28503.153940827, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.798142', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (145, '821955914', 23361.7020558525, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.798142', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (146, '840273134', 15576.0526309908, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.798142', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (147, '804095151', 8025.10114518908, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.798142', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (148, '895219474', 23359.6894525514, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.798142', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (149, '801800235', 21432.88238621, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.798142', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (150, '807003856', 10689.9148881901, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.798142', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (151, '841429259', 11023.0775563865, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.798142', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (152, '881670559', 27076.124691257, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.798142', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (153, '843481844', 30718.2423236957, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.798142', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (154, '884326615', 39663.1288525322, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.798142', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (155, '853080669', 30634.3752677837, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.843926', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (156, '865040557', 14055.3036347023, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.843926', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (157, '817210443', 5090.27029129046, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.843926', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (158, '862357563', 30120.419485602, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.843926', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (159, '882527092', 1358.39315589647, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.843926', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (160, '851225319', 679.507957862559, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.884926', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (161, '899519607', 24931.9382798312, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.884926', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (162, '896316258', 1775.32133445064, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.884926', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (163, '800366945', 1736.02535850305, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.884926', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (164, '898008510', 22628.5859695435, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.916342', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (165, '829686729', 16479.2832525278, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.916342', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (166, '846341319', 2368.2731033089, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.916342', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (167, '894967226', 18991.7210170647, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.916342', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (168, '833597055', 12110.9605805574, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.916342', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (169, '874119945', 32178.1968933683, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.916342', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (170, '868445187', 36993.5228434237, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.953123', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (171, '871094397', 20799.0545780022, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.953123', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (172, '802898734', 33806.7810521637, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.953123', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (173, '834917051', 38156.1395181432, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.953123', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (174, '807563291', 13129.6488200752, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.953123', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (175, '835160605', 13677.5845105089, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.953123', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (176, '885992640', 35167.4182564173, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.953123', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (177, '869936536', 2136.51736535336, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.953123', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (178, '859402121', 14663.1614509445, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.986152', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (179, '892954819', 35522.1252067497, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.986152', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (180, '816644800', 6689.78355630835, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.986152', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (181, '806220031', 9465.88866347121, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.986152', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (182, '894638284', 8279.95084328811, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.986152', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (183, '878312512', 11213.4599652818, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.986152', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (184, '842491957', 23268.4977903089, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:11.986152', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (185, '834513291', 16606.8274145159, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.078455', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (186, '810550084', 18287.9779046682, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.078455', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (187, '803121336', 5580.10628161873, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.078455', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (188, '828279257', 38348.7566669863, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.078455', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (189, '859330839', 21671.0307490671, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.224928', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (190, '830488574', 22201.218959985, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.224928', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (191, '857478770', 16291.9081088949, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.224928', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (192, '887040001', 6339.4379152312, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.224928', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (193, '891364302', 6580.98798213823, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.224928', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (194, '843653815', 11201.7323722731, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.224928', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (195, '845887942', 33729.2642379693, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.525255', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (196, '861150977', 33550.1949547472, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.525255', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (197, '868136854', 39665.195118691, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.525255', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (198, '870704831', 25904.7598727773, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.525255', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (199, '889143962', 38221.109875069, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.525255', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (200, '818905666', 9727.35719965175, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.525255', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (201, '843833062', 16847.3557177189, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.525255', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (202, '866329394', 26641.3687305583, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.525255', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (203, '821557660', 10929.5730359058, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.599387', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (204, '883078463', 26582.0117502207, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.599387', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (205, '873714856', 59.6409839164747, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.599387', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (206, '877777665', 39706.6470223021, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.599387', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (207, '876064107', 37416.8563845119, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.599387', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (208, '891563436', 1185.99247216654, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.599387', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (209, '827967499', 6951.25758573961, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.599387', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (210, '898942783', 3618.50521532811, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.599387', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (211, '836937976', 36095.2123388879, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.682074', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (212, '804568928', 1666.11119524843, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.682074', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (213, '800503985', 2755.09379206597, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.682074', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (214, '813990535', 17318.7388317917, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.682074', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (215, '890758402', 14193.8719827747, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.682074', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (216, '811028317', 20747.9602115826, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.682074', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (217, '804760052', 7167.072139901, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.682074', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (218, '838548431', 10186.1717529536, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.682074', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (219, '896612714', 33034.8158863621, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.682074', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (220, '851496542', 4371.10480356389, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.756692', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (221, '818563585', 6131.90547891079, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.756692', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (222, '875669833', 34773.4577839664, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.756692', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (223, '819785171', 36453.7033769732, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.756692', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (224, '828584499', 29952.6161852165, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.756692', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (225, '843434835', 25332.3855340726, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.756692', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (226, '875354392', 16161.2175132674, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.756692', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (227, '821764249', 16095.1532025522, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.756692', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (228, '879884092', 10206.051123313, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.756692', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (229, '887508538', 20718.325026014, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.788838', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (230, '854025366', 30430.8431291901, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.788838', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (231, '832495084', 36676.2080930539, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.788838', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (232, '819546494', 6135.12394570894, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.788838', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (233, '886234710', 27557.2794558283, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.788838', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (234, '863114808', 25222.7157921712, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.788838', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (235, '806585818', 27493.8974470602, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.788838', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (236, '869277026', 15271.7248848383, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.788838', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (237, '826601992', 16254.1534810194, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.815473', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (238, '845768352', 36322.8571242724, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.815473', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (239, '857606426', 39123.75991302, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.815473', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (240, '802627162', 8569.67993113596, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.815473', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (241, '896062995', 32768.5140253299, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.815473', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (242, '802773451', 137.374662509091, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.845324', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (243, '897412501', 3248.03394934729, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.845324', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (244, '877078417', 35732.2202556023, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.845324', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (245, '862364504', 248.541307448762, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.845324', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (246, '819608759', 9329.05943434392, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.873725', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (247, '847772631', 14820.8864010828, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.873725', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (248, '867565514', 19198.5831337799, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.873725', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (249, '886230666', 29148.3427096653, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.873725', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (250, '890278607', 22647.6448082788, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.873725', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (251, '830954144', 28480.8147123938, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.873725', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (252, '840495641', 30133.9077317781, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.907171', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (253, '853665654', 24884.1942430604, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.907171', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (254, '883098123', 15785.3603269701, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.907171', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (255, '836163189', 1423.64875562921, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.907171', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (256, '841569048', 8473.13572786038, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.907171', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (257, '834225226', 16174.842197983, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.907171', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (258, '826987922', 545.146164681577, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.942569', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (259, '847906942', 9281.97641058165, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.942569', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (260, '841372702', 5911.43040064046, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.942569', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (261, '814696095', 19320.5256313844, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.971417', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (262, '800004513', 26488.9333333205, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.971417', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (263, '815510655', 5688.3750589845, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:12.971417', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (264, '807833757', 39418.6554141265, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.01019', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (265, '874913674', 30269.5878566435, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.01019', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (266, '865707207', 39972.5522785982, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.01019', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (267, '878813506', 32272.2271154748, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.01019', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (268, '863559303', 5660.68981003498, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.050234', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (269, '854841360', 22838.497779311, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.050234', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (270, '893682691', 20693.0259693627, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.050234', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (271, '893949319', 21159.6650123621, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.050234', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (272, '825876867', 26846.8860692097, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.070678', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (273, '862102393', 29377.3546909022, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.070678', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (274, '876576630', 3677.39290923007, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.070678', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (275, '839374478', 36081.5423638699, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.070678', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (276, '887074592', 17935.6983582384, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.070678', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (277, '858115058', 35391.3329318931, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.070678', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (278, '833758984', 12603.937888546, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.114864', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (279, '861845843', 23614.4855774665, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.143107', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (280, '810021012', 7932.32626069893, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.143107', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (281, '874383060', 28957.3794228114, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.143107', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (282, '883377510', 17279.6865173922, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.143107', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (283, '839661067', 32596.0153506578, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.143107', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (284, '879881537', 36128.5702360588, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.143107', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (285, '854298397', 20818.8653364584, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.143107', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (286, '847858198', 29382.2691240822, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.143107', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (287, '876707327', 9600.84551801057, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.193909', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (288, '858699494', 26955.6638506792, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.193909', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (289, '861873966', 3102.20862022638, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.193909', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (290, '888525472', 32793.8086252561, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.231147', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (291, '827662737', 24725.8325369479, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.231147', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (292, '819333814', 6209.08131767081, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.231147', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (293, '854962683', 35614.2632084853, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.231147', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (294, '826990918', 15541.5939967925, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.231147', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (295, '874654389', 21932.4722032827, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.26372', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (296, '871171774', 24674.2622884094, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.26372', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (297, '857723124', 2998.1050449626, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.26372', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (298, '817427440', 36412.65577633, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.26372', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (299, '827735226', 31952.7419002867, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.26372', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (300, '810373111', 33838.4811359472, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.296397', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (301, '828628162', 29746.1647335164, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.296397', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (302, '808837822', 30581.5902738551, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.296397', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (303, '813354371', 21115.5253402974, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.296397', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (304, '875316797', 36531.4516783657, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.296397', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (305, '811920494', 22681.4735278824, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.325997', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (306, '892369559', 25688.7150071752, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.325997', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (307, '873929526', 9253.64356086216, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.325997', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (308, '814663019', 7893.41674624646, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.325997', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (309, '873287552', 11534.3864131524, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.325997', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (310, '819360448', 3186.01095042863, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.325997', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (311, '801440225', 24548.6026055868, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.349217', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (312, '868950634', 19749.2765081394, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.349217', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (313, '817957349', 2656.75042113117, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.349217', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (314, '835966398', 12095.3666306007, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.349217', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (315, '834790743', 14027.7746153771, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.349217', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (316, '834442274', 2409.61101742562, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.372888', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (317, '808252171', 2810.32900831317, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.372888', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (318, '890248760', 21854.7275017983, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.372888', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (319, '865099482', 24227.5475289494, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.372888', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (320, '813221338', 205.66504521699, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.372888', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (321, '842392037', 8350.99858089307, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.421926', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (322, '834385233', 14742.9741106263, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.421926', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (323, '849837990', 11589.1752215684, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.421926', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (324, '885923358', 918.24243629465, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.421926', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (325, '839996495', 23260.3957238264, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.421926', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (326, '811469589', 38978.3256397197, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.467866', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (327, '833437439', 25919.5229081846, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.467866', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (328, '826277182', 3364.99997555029, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.467866', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (329, '865358050', 15947.2817593452, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.467866', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (330, '881698955', 20647.6757814065, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.467866', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (331, '855827742', 21407.8432928935, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.467866', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (332, '829288621', 26422.0920804398, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.467866', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (333, '893779608', 30812.5065940079, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.505151', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (334, '880882302', 3179.55192809925, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.505151', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (335, '825497333', 34550.9720998849, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.505151', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (336, '898480863', 37615.4777921667, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.505151', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (337, '848313087', 22361.3685123464, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.505151', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (338, '806457638', 18401.2757932748, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.505151', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (339, '874065068', 9860.00779775964, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.505151', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (340, '877536857', 31388.4333147534, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.505151', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (341, '854048609', 38750.98893707, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.553797', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (342, '826180431', 6417.29861288201, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.553797', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (343, '804810763', 37205.1662480067, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.553797', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (344, '824385833', 15650.0689118872, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.553797', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (345, '854115545', 34579.6712136373, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.553797', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (346, '892252172', 25611.1805606305, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.553797', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (347, '856868617', 29729.9068514691, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.582673', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (348, '835816352', 4950.04248841183, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.582673', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (349, '808489389', 27469.5221947479, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.582673', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (350, '842564595', 9652.11573468144, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.582673', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (351, '862487391', 121.25748053112, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.582673', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (352, '844864220', 2718.21565836655, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.582673', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (353, '863745120', 32259.3685515319, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.582673', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (354, '811463659', 26690.8590830771, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.582673', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (355, '859424845', 30604.0652991809, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.582673', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (356, '826162593', 30430.6541684759, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.616053', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (357, '854501114', 34258.617604304, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.616053', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (358, '837971247', 24043.4444989824, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.616053', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (359, '814526409', 28728.8379967799, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.616053', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (360, '889233452', 17488.5303007956, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.616053', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (361, '851933508', 31125.2857690016, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.616053', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (362, '886861663', 15420.472947541, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.616053', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (363, '861967886', 22823.1445139986, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.616053', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (364, '824514650', 21580.7450459183, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.64396', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (365, '821686436', 24026.1931858942, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.64396', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (366, '879033196', 650.430338901884, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.64396', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (367, '843548997', 18337.3474670972, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.64396', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (368, '874858772', 743.961752173914, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.64396', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (369, '802656356', 1113.38946512958, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.64396', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (370, '880863319', 32125.8304516577, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.671009', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (371, '818100493', 27791.5258428436, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.671009', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (372, '887531172', 9190.80490607439, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.671009', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (373, '897549565', 13890.3103156753, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.671009', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (374, '833746388', 37475.7668292624, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.671009', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (375, '864617557', 29890.604672213, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.698967', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (376, '885749792', 36405.8736254509, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.698967', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (377, '854373649', 21539.3659986684, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.698967', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (378, '848288114', 31612.0605879706, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.698967', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (379, '822516713', 31196.2489517571, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.698967', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (380, '850613686', 13551.9013762826, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.698967', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (381, '852103064', 9810.89318906335, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.698967', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (382, '887895969', 13326.2652131361, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.728343', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (383, '897049098', 32827.3171463732, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.728343', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (384, '802649242', 36013.0199714325, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.728343', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (385, '857503747', 26165.8450096327, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.728343', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (386, '884369375', 21808.9536658714, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.728343', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (387, '829935543', 34876.1582364945, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.728343', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (388, '802777851', 6524.92356090295, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.728343', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (389, '841413884', 2754.76215328774, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.755802', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (390, '823768843', 23301.9876131085, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.755802', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (391, '871525212', 17699.8181168084, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.755802', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (392, '808924277', 7761.26093569998, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.755802', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (393, '851159913', 6631.17321513216, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.755802', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (394, '836866744', 39490.3979598861, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.755802', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (395, '847553918', 4436.84661299039, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.789611', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (396, '822664169', 26204.4092819762, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.789611', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (397, '835875990', 36150.1556708737, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.789611', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (398, '829279885', 10517.6286330648, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.789611', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (399, '807835433', 14967.8897411718, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.789611', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (400, '891539796', 403.090481215362, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.789611', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (401, '835688521', 28435.649574244, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.789611', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (402, '824680928', 1970.16882378214, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.813828', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (403, '883936426', 3614.95505700557, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.813828', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (404, '891833338', 3308.61171447628, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.813828', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (405, '878031681', 37886.7517828312, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.813828', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (406, '845521141', 31884.4330662575, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.813828', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (407, '809976227', 23681.1906302727, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.813828', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (408, '859355587', 25799.2885882825, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.841519', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (409, '807325397', 12039.0783995568, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.841519', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (410, '891463624', 4363.2616780862, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.841519', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (411, '895835975', 37622.1946964849, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.841519', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (412, '809233627', 35882.9259750477, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.841519', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (413, '889087670', 6760.74715204614, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.841519', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (414, '820335833', 16612.2383979089, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.87063', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (415, '898003942', 37801.1996985738, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.87063', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (416, '892725587', 26364.252545274, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.87063', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (417, '874702974', 18567.4001412579, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.87063', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (418, '814697430', 16502.7537973008, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.87063', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (419, '868394680', 28255.7732633448, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.87063', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (420, '868827435', 16048.6556049957, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.87063', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (421, '826836538', 36479.7339665067, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.87063', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (422, '852363701', 9194.58344890581, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.917787', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (423, '843954573', 1213.62369660331, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.917787', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (424, '854299147', 39924.4880858856, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.917787', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (425, '878570568', 36464.8408544942, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.917787', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (426, '853068332', 13334.7594881233, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.960417', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (427, '855430467', 31074.9870899105, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.960417', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (428, '894685451', 24250.3584178337, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.960417', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (429, '822981409', 20087.947846013, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.960417', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (430, '831415693', 17086.3948342517, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.960417', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (431, '846100277', 33408.3334422616, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.960417', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (432, '847750948', 7396.44421826468, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.960417', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (433, '874157752', 27875.1437570598, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:13.960417', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (434, '875537262', 37589.2901215396, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.001365', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (435, '818277813', 17786.0834919077, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.001365', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (436, '826608733', 6045.6641960096, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.001365', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (437, '819654730', 19882.8630646638, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.001365', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (438, '858734514', 664.806964017738, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.001365', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (439, '887394013', 30817.9171805275, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.045235', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (440, '806978546', 23676.9382636839, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.045235', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (441, '832921799', 14636.6250018089, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.045235', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (442, '839653608', 31542.5689547561, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.045235', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (443, '823764470', 36969.7505460946, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.045235', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (444, '808654021', 28966.2451384734, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.045235', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (445, '845791967', 16022.5359642632, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.078808', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (446, '813492132', 22288.2104300841, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.078808', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (447, '886404438', 24343.0436178048, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.078808', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (448, '826906234', 23695.7006068742, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.078808', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (449, '884842532', 13578.5856099077, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.078808', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (450, '823806402', 2901.63702280017, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.126248', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (451, '828511475', 29338.4181817324, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.126248', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (452, '874812930', 6743.31446465396, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.126248', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (453, '826631179', 38473.630945349, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.126248', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (454, '835704192', 26169.4935921252, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.126248', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (455, '850136949', 12257.3129740232, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.126248', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (456, '843057612', 27437.4514050693, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.126248', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (457, '840861739', 28258.9387116292, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.188666', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (458, '805101105', 6941.34956033911, 500, 1, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.188666', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (459, '887848461', 23416.4719380096, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.188666', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (460, '893141706', 39133.8355476196, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.188666', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (461, '821432696', 9704.59348217161, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.188666', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (462, '837300396', 32504.4771749988, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.188666', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (463, '809023320', 11471.8164078639, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.188666', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (464, '868307087', 16937.7015568709, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.233389', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (465, '843098741', 36576.9679764784, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.233389', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (466, '815697017', 14014.6703671378, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.233389', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (467, '828447962', 30070.1436194608, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.233389', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (468, '822609218', 7946.20621677114, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.233389', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (469, '836946437', 15425.8606066575, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.233389', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (470, '883685594', 28219.8044085346, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.233389', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (471, '840392436', 16384.0711451722, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.233389', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (472, '856806194', 12008.634424768, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.233389', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (473, '806990673', 26578.8419507202, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.233389', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (474, '813595696', 24676.9851928772, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.233389', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (475, '891297613', 31740.4570727288, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.285715', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (476, '853554657', 6985.56818721796, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.285715', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (477, '849153261', 3673.68296882438, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.285715', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (478, '827837752', 26403.6290164381, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.285715', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (479, '839978531', 20693.5221382293, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.285715', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (480, '804482373', 38194.5782262781, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.285715', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (481, '828759753', 21198.8260802891, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.285715', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (482, '849497625', 35978.0928640372, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.285715', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (483, '872494324', 28947.9457157497, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.285715', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (484, '891327339', 33245.9213507177, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.335154', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (485, '856498534', 25830.1670317179, 500, 7, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.335154', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (486, '869823047', 39795.1005822589, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.335154', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (487, '854842974', 39334.6559224116, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.335154', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (488, '887264644', 24970.8730485636, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.362896', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (489, '827930910', 6671.22583015638, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.362896', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (490, '834399652', 32368.9911867493, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.362896', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (491, '850604719', 30131.0005685409, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.362896', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (492, '811194793', 5123.11483351887, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.362896', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (493, '808172276', 22354.8415520767, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.397968', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (494, '846382671', 7407.63424972252, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.397968', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (495, '890681775', 25881.4842895877, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.397968', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (496, '878720665', 18114.9104056806, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.397968', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (497, '823309582', 28654.6883413372, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.397968', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (498, '898744138', 29007.3988078363, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.445033', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (499, '829172773', 31878.1698303727, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.445033', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (500, '823080067', 19802.5860112784, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.445033', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (501, '866404258', 10095.5133843016, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.445033', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (502, '881286826', 24443.0787364469, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.445033', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (503, '834002266', 30800.696835966, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.486717', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (504, '806570115', 33734.0797378526, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.486717', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (505, '808483887', 17922.0096507738, 500, 14, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.486717', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (506, '862698070', 38934.1185313992, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.486717', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (507, '807756994', 11972.2165755656, 500, 11, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.486717', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (508, '824085351', 6712.18529295429, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.486717', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (509, '866496146', 39171.3853207178, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.486717', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (510, '895153005', 1660.57339699559, 500, 20, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.52371', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (511, '840237839', 11432.7766068121, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.52371', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (512, '873832109', 33724.5651666261, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.52371', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (513, '876884282', 23790.7913933137, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.52371', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (514, '858719326', 30454.5447719605, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:14.52371', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (515, '827064129', 22630.853329326, 500, 12, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:18.734582', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (516, '827416008', 15497.4887351577, 500, 3, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:18.753552', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (517, '809867706', 26870.3948665776, 500, 18, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:18.764378', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (518, '864835591', 12862.9223450793, 500, 8, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:18.764378', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (519, '873229058', 20625.2719811896, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:18.779361', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (520, '864612934', 30713.2731715463, 500, 16, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:18.779361', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (521, '801778443', 28155.9453820877, 500, 6, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:18.779361', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (522, '810327990', 5093.98557370581, 500, 10, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:18.779361', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (523, '824034863', 34700.1441431073, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:18.806027', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (524, '821066600', 18396.7324343924, 500, 4, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:18.806027', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (525, '856178317', 18537.7453383169, 500, 9, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:18.806027', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (526, '881392469', 12268.3663064049, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:18.806027', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (527, '800325562', 28652.8551573243, 500, 15, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:18.826475', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (528, '832006833', 31438.0055668978, 500, 17, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:18.826475', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (529, '841487607', 36514.5035213281, 500, 5, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:18.826475', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (530, '809374902', 16624.1039715525, 500, 2, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:18.826475', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (531, '803371521', 19157.3629519083, 500, 19, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:18.848013', 2, 2023);
INSERT INTO public.sykefravar_statistikk_virksomhet_siste_4_kvartal VALUES (532, '848006818', 20690.805198161, 500, 13, false, 2, '[{"kvartal": 2, "årstall": 2023}, {"kvartal": 1, "årstall": 2023}]', '2023-09-20 15:45:18.848013', 2, 2023);


--
-- Data for Name: virksomhet; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet VALUES (1, '987654321', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo', '{"Osloveien 1"}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:07.825221', '2023-09-20 15:45:07.825221');
INSERT INTO public.virksomhet VALUES (2, '123456789', 'Norge', 'NO', '1234', 'POSTSTED', 'BERGEN', '4601', 'Virksomhet Bærgen', '{"Bergenveien 1"}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:07.855433', '2023-09-20 15:45:07.855433');
INSERT INTO public.virksomhet VALUES (3, '555555555', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo Flere Adresser', '{"c/o Oslo Tigersen","Osloveien 1","0977 Oslo"}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:07.877956', '2023-09-20 15:45:07.877956');
INSERT INTO public.virksomhet VALUES (4, '666666666', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Virksomhet Oslo Mangler Adresser', '{}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:07.888186', '2023-09-20 15:45:07.888186');
INSERT INTO public.virksomhet VALUES (5, '834190884', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834190884', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:07.921519', '2023-09-20 15:45:07.921519');
INSERT INTO public.virksomhet VALUES (6, '817218179', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817218179', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:07.9276', '2023-09-20 15:45:07.9276');
INSERT INTO public.virksomhet VALUES (7, '858315727', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858315727', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:07.934938', '2023-09-20 15:45:07.934938');
INSERT INTO public.virksomhet VALUES (8, '867886062', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867886062', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:07.943046', '2023-09-20 15:45:07.943046');
INSERT INTO public.virksomhet VALUES (9, '855774607', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855774607', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:07.948953', '2023-09-20 15:45:07.948953');
INSERT INTO public.virksomhet VALUES (10, '827015467', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827015467', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:07.955734', '2023-09-20 15:45:07.955734');
INSERT INTO public.virksomhet VALUES (11, '805290389', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805290389', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:07.969721', '2023-09-20 15:45:07.969721');
INSERT INTO public.virksomhet VALUES (12, '857768316', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857768316', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:07.979429', '2023-09-20 15:45:07.979429');
INSERT INTO public.virksomhet VALUES (13, '878440626', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878440626', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:07.994252', '2023-09-20 15:45:07.994252');
INSERT INTO public.virksomhet VALUES (14, '837670234', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837670234', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.000738', '2023-09-20 15:45:08.000738');
INSERT INTO public.virksomhet VALUES (15, '869337023', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869337023', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.005108', '2023-09-20 15:45:08.005108');
INSERT INTO public.virksomhet VALUES (16, '868310560', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868310560', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.008368', '2023-09-20 15:45:08.008368');
INSERT INTO public.virksomhet VALUES (17, '854189604', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854189604', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.014746', '2023-09-20 15:45:08.014746');
INSERT INTO public.virksomhet VALUES (18, '868245401', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868245401', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.02089', '2023-09-20 15:45:08.02089');
INSERT INTO public.virksomhet VALUES (19, '887421757', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887421757', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.027009', '2023-09-20 15:45:08.027009');
INSERT INTO public.virksomhet VALUES (20, '801201600', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801201600', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.033575', '2023-09-20 15:45:08.033575');
INSERT INTO public.virksomhet VALUES (21, '853912646', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853912646', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.038136', '2023-09-20 15:45:08.038136');
INSERT INTO public.virksomhet VALUES (22, '871483086', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871483086', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.044076', '2023-09-20 15:45:08.044076');
INSERT INTO public.virksomhet VALUES (23, '889480505', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889480505', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.053517', '2023-09-20 15:45:08.053517');
INSERT INTO public.virksomhet VALUES (24, '889747942', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889747942', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.058008', '2023-09-20 15:45:08.058008');
INSERT INTO public.virksomhet VALUES (25, '862875196', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862875196', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.062383', '2023-09-20 15:45:08.062383');
INSERT INTO public.virksomhet VALUES (26, '855525313', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855525313', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.068239', '2023-09-20 15:45:08.068239');
INSERT INTO public.virksomhet VALUES (27, '811443790', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811443790', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.075394', '2023-09-20 15:45:08.075394');
INSERT INTO public.virksomhet VALUES (28, '833573552', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833573552', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.081732', '2023-09-20 15:45:08.081732');
INSERT INTO public.virksomhet VALUES (29, '819462272', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819462272', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.087666', '2023-09-20 15:45:08.087666');
INSERT INTO public.virksomhet VALUES (30, '856293477', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856293477', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.096597', '2023-09-20 15:45:08.096597');
INSERT INTO public.virksomhet VALUES (31, '882254761', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882254761', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.100966', '2023-09-20 15:45:08.100966');
INSERT INTO public.virksomhet VALUES (32, '855039001', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855039001', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.107318', '2023-09-20 15:45:08.107318');
INSERT INTO public.virksomhet VALUES (33, '824009121', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824009121', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.115', '2023-09-20 15:45:08.115');
INSERT INTO public.virksomhet VALUES (34, '800497744', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800497744', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.122943', '2023-09-20 15:45:08.122943');
INSERT INTO public.virksomhet VALUES (35, '844731879', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844731879', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.130907', '2023-09-20 15:45:08.130907');
INSERT INTO public.virksomhet VALUES (36, '840016805', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840016805', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.154753', '2023-09-20 15:45:08.154753');
INSERT INTO public.virksomhet VALUES (37, '888553487', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888553487', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.159444', '2023-09-20 15:45:08.159444');
INSERT INTO public.virksomhet VALUES (38, '806720589', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806720589', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.181548', '2023-09-20 15:45:08.181548');
INSERT INTO public.virksomhet VALUES (39, '837337985', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837337985', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.188904', '2023-09-20 15:45:08.188904');
INSERT INTO public.virksomhet VALUES (40, '874871261', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874871261', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.195516', '2023-09-20 15:45:08.195516');
INSERT INTO public.virksomhet VALUES (41, '801074620', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801074620', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.204409', '2023-09-20 15:45:08.204409');
INSERT INTO public.virksomhet VALUES (42, '876853959', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876853959', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.213198', '2023-09-20 15:45:08.213198');
INSERT INTO public.virksomhet VALUES (43, '889812652', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889812652', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.218347', '2023-09-20 15:45:08.218347');
INSERT INTO public.virksomhet VALUES (44, '839437706', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839437706', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.22539', '2023-09-20 15:45:08.22539');
INSERT INTO public.virksomhet VALUES (45, '845771147', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845771147', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.231516', '2023-09-20 15:45:08.231516');
INSERT INTO public.virksomhet VALUES (46, '855530089', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855530089', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.242444', '2023-09-20 15:45:08.242444');
INSERT INTO public.virksomhet VALUES (47, '892871410', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892871410', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.263346', '2023-09-20 15:45:08.263346');
INSERT INTO public.virksomhet VALUES (48, '874569933', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874569933', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.274491', '2023-09-20 15:45:08.274491');
INSERT INTO public.virksomhet VALUES (49, '890920316', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890920316', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.281712', '2023-09-20 15:45:08.281712');
INSERT INTO public.virksomhet VALUES (50, '806574144', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806574144', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.28763', '2023-09-20 15:45:08.28763');
INSERT INTO public.virksomhet VALUES (51, '897019567', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897019567', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.294232', '2023-09-20 15:45:08.294232');
INSERT INTO public.virksomhet VALUES (52, '899744758', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899744758', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.302871', '2023-09-20 15:45:08.302871');
INSERT INTO public.virksomhet VALUES (53, '879055458', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879055458', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.309377', '2023-09-20 15:45:08.309377');
INSERT INTO public.virksomhet VALUES (54, '849291295', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849291295', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.315774', '2023-09-20 15:45:08.315774');
INSERT INTO public.virksomhet VALUES (55, '876484129', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876484129', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.323684', '2023-09-20 15:45:08.323684');
INSERT INTO public.virksomhet VALUES (56, '804794544', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804794544', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.3295', '2023-09-20 15:45:08.3295');
INSERT INTO public.virksomhet VALUES (57, '801414721', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801414721', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.334045', '2023-09-20 15:45:08.334045');
INSERT INTO public.virksomhet VALUES (58, '853084595', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853084595', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.339354', '2023-09-20 15:45:08.339354');
INSERT INTO public.virksomhet VALUES (59, '814750942', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814750942', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.345103', '2023-09-20 15:45:08.345103');
INSERT INTO public.virksomhet VALUES (60, '894248802', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894248802', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.350745', '2023-09-20 15:45:08.350745');
INSERT INTO public.virksomhet VALUES (61, '895438962', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895438962', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.358312', '2023-09-20 15:45:08.358312');
INSERT INTO public.virksomhet VALUES (62, '894222980', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894222980', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.36588', '2023-09-20 15:45:08.36588');
INSERT INTO public.virksomhet VALUES (63, '892644608', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892644608', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.373274', '2023-09-20 15:45:08.373274');
INSERT INTO public.virksomhet VALUES (64, '861296525', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861296525', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.379984', '2023-09-20 15:45:08.379984');
INSERT INTO public.virksomhet VALUES (65, '856974053', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856974053', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.387758', '2023-09-20 15:45:08.387758');
INSERT INTO public.virksomhet VALUES (66, '893401740', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893401740', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.39573', '2023-09-20 15:45:08.39573');
INSERT INTO public.virksomhet VALUES (67, '898873892', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898873892', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.403375', '2023-09-20 15:45:08.403375');
INSERT INTO public.virksomhet VALUES (68, '890416553', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890416553', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.409439', '2023-09-20 15:45:08.409439');
INSERT INTO public.virksomhet VALUES (69, '883382387', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883382387', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.42264', '2023-09-20 15:45:08.42264');
INSERT INTO public.virksomhet VALUES (70, '819780616', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819780616', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.427479', '2023-09-20 15:45:08.427479');
INSERT INTO public.virksomhet VALUES (71, '840103549', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840103549', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.43326', '2023-09-20 15:45:08.43326');
INSERT INTO public.virksomhet VALUES (72, '858398076', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858398076', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.440077', '2023-09-20 15:45:08.440077');
INSERT INTO public.virksomhet VALUES (73, '820203200', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820203200', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.446385', '2023-09-20 15:45:08.446385');
INSERT INTO public.virksomhet VALUES (74, '815962275', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815962275', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.450645', '2023-09-20 15:45:08.450645');
INSERT INTO public.virksomhet VALUES (75, '858135043', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858135043', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.460643', '2023-09-20 15:45:08.460643');
INSERT INTO public.virksomhet VALUES (76, '808027924', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808027924', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.466205', '2023-09-20 15:45:08.466205');
INSERT INTO public.virksomhet VALUES (77, '825903416', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825903416', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.471737', '2023-09-20 15:45:08.471737');
INSERT INTO public.virksomhet VALUES (78, '824836141', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824836141', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.47508', '2023-09-20 15:45:08.47508');
INSERT INTO public.virksomhet VALUES (79, '832710844', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832710844', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.479565', '2023-09-20 15:45:08.479565');
INSERT INTO public.virksomhet VALUES (80, '842362113', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842362113', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.496451', '2023-09-20 15:45:08.496451');
INSERT INTO public.virksomhet VALUES (81, '850606669', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850606669', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.50078', '2023-09-20 15:45:08.50078');
INSERT INTO public.virksomhet VALUES (82, '850242937', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850242937', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.509091', '2023-09-20 15:45:08.509091');
INSERT INTO public.virksomhet VALUES (83, '828871863', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828871863', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.514343', '2023-09-20 15:45:08.514343');
INSERT INTO public.virksomhet VALUES (84, '822859420', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822859420', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.519283', '2023-09-20 15:45:08.519283');
INSERT INTO public.virksomhet VALUES (85, '843001698', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843001698', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.535592', '2023-09-20 15:45:08.535592');
INSERT INTO public.virksomhet VALUES (86, '831692857', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831692857', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.549515', '2023-09-20 15:45:08.549515');
INSERT INTO public.virksomhet VALUES (87, '886195004', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886195004', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.556148', '2023-09-20 15:45:08.556148');
INSERT INTO public.virksomhet VALUES (88, '813134297', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813134297', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.565959', '2023-09-20 15:45:08.565959');
INSERT INTO public.virksomhet VALUES (89, '854341349', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854341349', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.574083', '2023-09-20 15:45:08.574083');
INSERT INTO public.virksomhet VALUES (90, '852255739', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852255739', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.579922', '2023-09-20 15:45:08.579922');
INSERT INTO public.virksomhet VALUES (91, '831919224', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831919224', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.586332', '2023-09-20 15:45:08.586332');
INSERT INTO public.virksomhet VALUES (92, '893956693', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893956693', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.59159', '2023-09-20 15:45:08.59159');
INSERT INTO public.virksomhet VALUES (93, '887068890', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887068890', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.60069', '2023-09-20 15:45:08.60069');
INSERT INTO public.virksomhet VALUES (94, '859377546', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859377546', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.607504', '2023-09-20 15:45:08.607504');
INSERT INTO public.virksomhet VALUES (95, '808337271', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808337271', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.61362', '2023-09-20 15:45:08.61362');
INSERT INTO public.virksomhet VALUES (96, '892079041', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892079041', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.619531', '2023-09-20 15:45:08.619531');
INSERT INTO public.virksomhet VALUES (97, '825309841', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825309841', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.623734', '2023-09-20 15:45:08.623734');
INSERT INTO public.virksomhet VALUES (98, '899283543', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899283543', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.626716', '2023-09-20 15:45:08.626716');
INSERT INTO public.virksomhet VALUES (99, '836105668', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836105668', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.632589', '2023-09-20 15:45:08.632589');
INSERT INTO public.virksomhet VALUES (100, '899617322', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899617322', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.638287', '2023-09-20 15:45:08.638287');
INSERT INTO public.virksomhet VALUES (101, '897369016', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897369016', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.642204', '2023-09-20 15:45:08.642204');
INSERT INTO public.virksomhet VALUES (102, '847909287', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847909287', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.646449', '2023-09-20 15:45:08.646449');
INSERT INTO public.virksomhet VALUES (103, '885363201', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885363201', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.650632', '2023-09-20 15:45:08.650632');
INSERT INTO public.virksomhet VALUES (104, '895703494', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895703494', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.654912', '2023-09-20 15:45:08.654912');
INSERT INTO public.virksomhet VALUES (105, '805582082', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805582082', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.658222', '2023-09-20 15:45:08.658222');
INSERT INTO public.virksomhet VALUES (106, '831313921', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831313921', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.663239', '2023-09-20 15:45:08.663239');
INSERT INTO public.virksomhet VALUES (107, '887250798', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887250798', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.668171', '2023-09-20 15:45:08.668171');
INSERT INTO public.virksomhet VALUES (108, '876662451', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876662451', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.671639', '2023-09-20 15:45:08.671639');
INSERT INTO public.virksomhet VALUES (109, '829725165', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829725165', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.677633', '2023-09-20 15:45:08.677633');
INSERT INTO public.virksomhet VALUES (110, '862196487', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862196487', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.684221', '2023-09-20 15:45:08.684221');
INSERT INTO public.virksomhet VALUES (111, '851434861', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851434861', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.687626', '2023-09-20 15:45:08.687626');
INSERT INTO public.virksomhet VALUES (112, '861181928', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861181928', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.691645', '2023-09-20 15:45:08.691645');
INSERT INTO public.virksomhet VALUES (113, '852787577', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852787577', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.706171', '2023-09-20 15:45:08.706171');
INSERT INTO public.virksomhet VALUES (114, '801830575', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801830575', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.714262', '2023-09-20 15:45:08.714262');
INSERT INTO public.virksomhet VALUES (115, '836614467', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836614467', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.720322', '2023-09-20 15:45:08.720322');
INSERT INTO public.virksomhet VALUES (116, '893864437', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893864437', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.728511', '2023-09-20 15:45:08.728511');
INSERT INTO public.virksomhet VALUES (117, '831824518', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831824518', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.736069', '2023-09-20 15:45:08.736069');
INSERT INTO public.virksomhet VALUES (118, '824296444', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824296444', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.742285', '2023-09-20 15:45:08.742285');
INSERT INTO public.virksomhet VALUES (119, '869460321', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869460321', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.747315', '2023-09-20 15:45:08.747315');
INSERT INTO public.virksomhet VALUES (120, '808176785', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808176785', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.753774', '2023-09-20 15:45:08.753774');
INSERT INTO public.virksomhet VALUES (121, '863481189', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863481189', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.760698', '2023-09-20 15:45:08.760698');
INSERT INTO public.virksomhet VALUES (122, '891032390', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891032390', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.765822', '2023-09-20 15:45:08.765822');
INSERT INTO public.virksomhet VALUES (123, '827341816', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827341816', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.771299', '2023-09-20 15:45:08.771299');
INSERT INTO public.virksomhet VALUES (124, '897698399', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897698399', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.782016', '2023-09-20 15:45:08.782016');
INSERT INTO public.virksomhet VALUES (125, '890446075', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890446075', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.788284', '2023-09-20 15:45:08.788284');
INSERT INTO public.virksomhet VALUES (126, '845411087', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845411087', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.794183', '2023-09-20 15:45:08.794183');
INSERT INTO public.virksomhet VALUES (127, '873878975', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873878975', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.799945', '2023-09-20 15:45:08.799945');
INSERT INTO public.virksomhet VALUES (128, '823474091', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823474091', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.809623', '2023-09-20 15:45:08.809623');
INSERT INTO public.virksomhet VALUES (129, '807676378', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807676378', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.813869', '2023-09-20 15:45:08.813869');
INSERT INTO public.virksomhet VALUES (130, '832530561', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832530561', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.818622', '2023-09-20 15:45:08.818622');
INSERT INTO public.virksomhet VALUES (131, '848331429', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848331429', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.825694', '2023-09-20 15:45:08.825694');
INSERT INTO public.virksomhet VALUES (132, '857977631', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857977631', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.829455', '2023-09-20 15:45:08.829455');
INSERT INTO public.virksomhet VALUES (133, '821437524', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821437524', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.833221', '2023-09-20 15:45:08.833221');
INSERT INTO public.virksomhet VALUES (134, '813058997', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813058997', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.838536', '2023-09-20 15:45:08.838536');
INSERT INTO public.virksomhet VALUES (135, '817599634', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817599634', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.844059', '2023-09-20 15:45:08.844059');
INSERT INTO public.virksomhet VALUES (136, '841754369', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841754369', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.850961', '2023-09-20 15:45:08.850961');
INSERT INTO public.virksomhet VALUES (137, '848123425', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848123425', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.862076', '2023-09-20 15:45:08.862076');
INSERT INTO public.virksomhet VALUES (138, '823949946', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823949946', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.866948', '2023-09-20 15:45:08.866948');
INSERT INTO public.virksomhet VALUES (139, '830259693', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830259693', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.875151', '2023-09-20 15:45:08.875151');
INSERT INTO public.virksomhet VALUES (140, '825960020', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825960020', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.892859', '2023-09-20 15:45:08.892859');
INSERT INTO public.virksomhet VALUES (141, '821955914', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821955914', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.898326', '2023-09-20 15:45:08.898326');
INSERT INTO public.virksomhet VALUES (142, '840273134', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840273134', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.903974', '2023-09-20 15:45:08.903974');
INSERT INTO public.virksomhet VALUES (143, '804095151', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804095151', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.913481', '2023-09-20 15:45:08.913481');
INSERT INTO public.virksomhet VALUES (144, '895219474', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895219474', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.922923', '2023-09-20 15:45:08.922923');
INSERT INTO public.virksomhet VALUES (145, '801800235', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801800235', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.927411', '2023-09-20 15:45:08.927411');
INSERT INTO public.virksomhet VALUES (146, '807003856', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807003856', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.933855', '2023-09-20 15:45:08.933855');
INSERT INTO public.virksomhet VALUES (147, '841429259', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841429259', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.938555', '2023-09-20 15:45:08.938555');
INSERT INTO public.virksomhet VALUES (148, '881670559', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881670559', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.943685', '2023-09-20 15:45:08.943685');
INSERT INTO public.virksomhet VALUES (149, '843481844', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843481844', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.968066', '2023-09-20 15:45:08.968066');
INSERT INTO public.virksomhet VALUES (150, '884326615', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884326615', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.976116', '2023-09-20 15:45:08.976116');
INSERT INTO public.virksomhet VALUES (151, '853080669', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853080669', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.982691', '2023-09-20 15:45:08.982691');
INSERT INTO public.virksomhet VALUES (152, '865040557', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865040557', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.988444', '2023-09-20 15:45:08.988444');
INSERT INTO public.virksomhet VALUES (153, '817210443', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817210443', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:08.995549', '2023-09-20 15:45:08.995549');
INSERT INTO public.virksomhet VALUES (154, '862357563', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862357563', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.000743', '2023-09-20 15:45:09.000743');
INSERT INTO public.virksomhet VALUES (155, '882527092', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 882527092', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.006123', '2023-09-20 15:45:09.006123');
INSERT INTO public.virksomhet VALUES (156, '851225319', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851225319', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.01274', '2023-09-20 15:45:09.01274');
INSERT INTO public.virksomhet VALUES (157, '899519607', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 899519607', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.020555', '2023-09-20 15:45:09.020555');
INSERT INTO public.virksomhet VALUES (158, '896316258', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896316258', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.026549', '2023-09-20 15:45:09.026549');
INSERT INTO public.virksomhet VALUES (159, '800366945', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800366945', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.03318', '2023-09-20 15:45:09.03318');
INSERT INTO public.virksomhet VALUES (160, '898008510', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898008510', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.038146', '2023-09-20 15:45:09.038146');
INSERT INTO public.virksomhet VALUES (161, '829686729', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829686729', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.042122', '2023-09-20 15:45:09.042122');
INSERT INTO public.virksomhet VALUES (162, '846341319', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846341319', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.046518', '2023-09-20 15:45:09.046518');
INSERT INTO public.virksomhet VALUES (163, '894967226', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894967226', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.050481', '2023-09-20 15:45:09.050481');
INSERT INTO public.virksomhet VALUES (164, '833597055', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833597055', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.054258', '2023-09-20 15:45:09.054258');
INSERT INTO public.virksomhet VALUES (165, '874119945', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874119945', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.058517', '2023-09-20 15:45:09.058517');
INSERT INTO public.virksomhet VALUES (166, '868445187', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868445187', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.062631', '2023-09-20 15:45:09.062631');
INSERT INTO public.virksomhet VALUES (167, '871094397', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871094397', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.068826', '2023-09-20 15:45:09.068826');
INSERT INTO public.virksomhet VALUES (168, '802898734', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802898734', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.080975', '2023-09-20 15:45:09.080975');
INSERT INTO public.virksomhet VALUES (169, '834917051', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834917051', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.086295', '2023-09-20 15:45:09.086295');
INSERT INTO public.virksomhet VALUES (170, '807563291', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807563291', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.092509', '2023-09-20 15:45:09.092509');
INSERT INTO public.virksomhet VALUES (171, '835160605', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835160605', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.096773', '2023-09-20 15:45:09.096773');
INSERT INTO public.virksomhet VALUES (172, '885992640', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885992640', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.100613', '2023-09-20 15:45:09.100613');
INSERT INTO public.virksomhet VALUES (173, '869936536', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869936536', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.104773', '2023-09-20 15:45:09.104773');
INSERT INTO public.virksomhet VALUES (174, '859402121', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859402121', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.108176', '2023-09-20 15:45:09.108176');
INSERT INTO public.virksomhet VALUES (175, '892954819', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892954819', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.113386', '2023-09-20 15:45:09.113386');
INSERT INTO public.virksomhet VALUES (176, '816644800', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816644800', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.120609', '2023-09-20 15:45:09.120609');
INSERT INTO public.virksomhet VALUES (177, '806220031', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806220031', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.124792', '2023-09-20 15:45:09.124792');
INSERT INTO public.virksomhet VALUES (178, '894638284', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894638284', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.130686', '2023-09-20 15:45:09.130686');
INSERT INTO public.virksomhet VALUES (179, '878312512', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878312512', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.138993', '2023-09-20 15:45:09.138993');
INSERT INTO public.virksomhet VALUES (180, '842491957', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842491957', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.1446', '2023-09-20 15:45:09.1446');
INSERT INTO public.virksomhet VALUES (181, '834513291', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834513291', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.149998', '2023-09-20 15:45:09.149998');
INSERT INTO public.virksomhet VALUES (182, '810550084', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810550084', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.154093', '2023-09-20 15:45:09.154093');
INSERT INTO public.virksomhet VALUES (183, '803121336', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 803121336', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.158919', '2023-09-20 15:45:09.158919');
INSERT INTO public.virksomhet VALUES (184, '828279257', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828279257', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.164181', '2023-09-20 15:45:09.164181');
INSERT INTO public.virksomhet VALUES (185, '859330839', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859330839', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.167772', '2023-09-20 15:45:09.167772');
INSERT INTO public.virksomhet VALUES (186, '830488574', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830488574', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.171389', '2023-09-20 15:45:09.171389');
INSERT INTO public.virksomhet VALUES (187, '857478770', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857478770', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.175633', '2023-09-20 15:45:09.175633');
INSERT INTO public.virksomhet VALUES (188, '887040001', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887040001', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.180569', '2023-09-20 15:45:09.180569');
INSERT INTO public.virksomhet VALUES (189, '891364302', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891364302', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.18842', '2023-09-20 15:45:09.18842');
INSERT INTO public.virksomhet VALUES (190, '843653815', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843653815', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.197895', '2023-09-20 15:45:09.197895');
INSERT INTO public.virksomhet VALUES (191, '845887942', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845887942', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.205525', '2023-09-20 15:45:09.205525');
INSERT INTO public.virksomhet VALUES (192, '861150977', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861150977', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.214183', '2023-09-20 15:45:09.214183');
INSERT INTO public.virksomhet VALUES (193, '868136854', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868136854', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.219866', '2023-09-20 15:45:09.219866');
INSERT INTO public.virksomhet VALUES (194, '870704831', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 870704831', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.225066', '2023-09-20 15:45:09.225066');
INSERT INTO public.virksomhet VALUES (195, '889143962', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889143962', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.230509', '2023-09-20 15:45:09.230509');
INSERT INTO public.virksomhet VALUES (196, '818905666', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818905666', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.236393', '2023-09-20 15:45:09.236393');
INSERT INTO public.virksomhet VALUES (197, '843833062', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843833062', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.243246', '2023-09-20 15:45:09.243246');
INSERT INTO public.virksomhet VALUES (198, '866329394', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866329394', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.249046', '2023-09-20 15:45:09.249046');
INSERT INTO public.virksomhet VALUES (199, '821557660', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821557660', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.256933', '2023-09-20 15:45:09.256933');
INSERT INTO public.virksomhet VALUES (200, '883078463', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883078463', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.264176', '2023-09-20 15:45:09.264176');
INSERT INTO public.virksomhet VALUES (201, '873714856', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873714856', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.276831', '2023-09-20 15:45:09.276831');
INSERT INTO public.virksomhet VALUES (202, '877777665', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877777665', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.284264', '2023-09-20 15:45:09.284264');
INSERT INTO public.virksomhet VALUES (203, '876064107', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876064107', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.288321', '2023-09-20 15:45:09.288321');
INSERT INTO public.virksomhet VALUES (204, '891563436', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891563436', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.292052', '2023-09-20 15:45:09.292052');
INSERT INTO public.virksomhet VALUES (205, '827967499', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827967499', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.297043', '2023-09-20 15:45:09.297043');
INSERT INTO public.virksomhet VALUES (206, '898942783', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898942783', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.303401', '2023-09-20 15:45:09.303401');
INSERT INTO public.virksomhet VALUES (207, '836937976', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836937976', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.309478', '2023-09-20 15:45:09.309478');
INSERT INTO public.virksomhet VALUES (208, '804568928', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804568928', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.314645', '2023-09-20 15:45:09.314645');
INSERT INTO public.virksomhet VALUES (209, '800503985', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800503985', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.333913', '2023-09-20 15:45:09.333913');
INSERT INTO public.virksomhet VALUES (210, '813990535', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813990535', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.341016', '2023-09-20 15:45:09.341016');
INSERT INTO public.virksomhet VALUES (211, '890758402', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890758402', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.345841', '2023-09-20 15:45:09.345841');
INSERT INTO public.virksomhet VALUES (212, '811028317', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811028317', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.350274', '2023-09-20 15:45:09.350274');
INSERT INTO public.virksomhet VALUES (213, '804760052', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804760052', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.355659', '2023-09-20 15:45:09.355659');
INSERT INTO public.virksomhet VALUES (214, '838548431', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 838548431', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.360735', '2023-09-20 15:45:09.360735');
INSERT INTO public.virksomhet VALUES (215, '896612714', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896612714', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.364436', '2023-09-20 15:45:09.364436');
INSERT INTO public.virksomhet VALUES (216, '851496542', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851496542', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.36718', '2023-09-20 15:45:09.36718');
INSERT INTO public.virksomhet VALUES (217, '818563585', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818563585', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.372412', '2023-09-20 15:45:09.372412');
INSERT INTO public.virksomhet VALUES (218, '875669833', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875669833', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.376407', '2023-09-20 15:45:09.376407');
INSERT INTO public.virksomhet VALUES (219, '819785171', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819785171', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.381436', '2023-09-20 15:45:09.381436');
INSERT INTO public.virksomhet VALUES (220, '828584499', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828584499', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.386178', '2023-09-20 15:45:09.386178');
INSERT INTO public.virksomhet VALUES (221, '843434835', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843434835', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.392046', '2023-09-20 15:45:09.392046');
INSERT INTO public.virksomhet VALUES (222, '875354392', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875354392', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.396203', '2023-09-20 15:45:09.396203');
INSERT INTO public.virksomhet VALUES (223, '821764249', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821764249', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.413442', '2023-09-20 15:45:09.413442');
INSERT INTO public.virksomhet VALUES (224, '879884092', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879884092', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.418215', '2023-09-20 15:45:09.418215');
INSERT INTO public.virksomhet VALUES (225, '887508538', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887508538', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.424223', '2023-09-20 15:45:09.424223');
INSERT INTO public.virksomhet VALUES (226, '854025366', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854025366', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.42698', '2023-09-20 15:45:09.42698');
INSERT INTO public.virksomhet VALUES (227, '832495084', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832495084', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.429976', '2023-09-20 15:45:09.429976');
INSERT INTO public.virksomhet VALUES (228, '819546494', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819546494', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.433511', '2023-09-20 15:45:09.433511');
INSERT INTO public.virksomhet VALUES (229, '886234710', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886234710', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.437331', '2023-09-20 15:45:09.437331');
INSERT INTO public.virksomhet VALUES (230, '863114808', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863114808', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.441703', '2023-09-20 15:45:09.441703');
INSERT INTO public.virksomhet VALUES (231, '806585818', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806585818', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.445924', '2023-09-20 15:45:09.445924');
INSERT INTO public.virksomhet VALUES (232, '869277026', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869277026', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.450219', '2023-09-20 15:45:09.450219');
INSERT INTO public.virksomhet VALUES (233, '826601992', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826601992', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.454192', '2023-09-20 15:45:09.454192');
INSERT INTO public.virksomhet VALUES (234, '845768352', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845768352', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.45812', '2023-09-20 15:45:09.45812');
INSERT INTO public.virksomhet VALUES (235, '857606426', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857606426', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.462457', '2023-09-20 15:45:09.462457');
INSERT INTO public.virksomhet VALUES (236, '802627162', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802627162', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.467318', '2023-09-20 15:45:09.467318');
INSERT INTO public.virksomhet VALUES (237, '896062995', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 896062995', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.470959', '2023-09-20 15:45:09.470959');
INSERT INTO public.virksomhet VALUES (238, '802773451', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802773451', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.475617', '2023-09-20 15:45:09.475617');
INSERT INTO public.virksomhet VALUES (239, '897412501', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897412501', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.478348', '2023-09-20 15:45:09.478348');
INSERT INTO public.virksomhet VALUES (240, '877078417', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877078417', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.481709', '2023-09-20 15:45:09.481709');
INSERT INTO public.virksomhet VALUES (241, '862364504', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862364504', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.486577', '2023-09-20 15:45:09.486577');
INSERT INTO public.virksomhet VALUES (242, '819608759', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819608759', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.490676', '2023-09-20 15:45:09.490676');
INSERT INTO public.virksomhet VALUES (243, '847772631', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847772631', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.495092', '2023-09-20 15:45:09.495092');
INSERT INTO public.virksomhet VALUES (244, '867565514', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 867565514', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.499092', '2023-09-20 15:45:09.499092');
INSERT INTO public.virksomhet VALUES (245, '886230666', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886230666', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.503031', '2023-09-20 15:45:09.503031');
INSERT INTO public.virksomhet VALUES (246, '890278607', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890278607', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.508474', '2023-09-20 15:45:09.508474');
INSERT INTO public.virksomhet VALUES (247, '830954144', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 830954144', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.511794', '2023-09-20 15:45:09.511794');
INSERT INTO public.virksomhet VALUES (248, '840495641', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840495641', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.516478', '2023-09-20 15:45:09.516478');
INSERT INTO public.virksomhet VALUES (249, '853665654', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853665654', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.52015', '2023-09-20 15:45:09.52015');
INSERT INTO public.virksomhet VALUES (250, '883098123', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883098123', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.524396', '2023-09-20 15:45:09.524396');
INSERT INTO public.virksomhet VALUES (251, '836163189', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836163189', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.530863', '2023-09-20 15:45:09.530863');
INSERT INTO public.virksomhet VALUES (252, '841569048', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841569048', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.534988', '2023-09-20 15:45:09.534988');
INSERT INTO public.virksomhet VALUES (253, '834225226', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834225226', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.540587', '2023-09-20 15:45:09.540587');
INSERT INTO public.virksomhet VALUES (254, '826987922', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826987922', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.545236', '2023-09-20 15:45:09.545236');
INSERT INTO public.virksomhet VALUES (255, '847906942', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847906942', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.549911', '2023-09-20 15:45:09.549911');
INSERT INTO public.virksomhet VALUES (256, '841372702', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841372702', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.553497', '2023-09-20 15:45:09.553497');
INSERT INTO public.virksomhet VALUES (257, '814696095', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814696095', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.556849', '2023-09-20 15:45:09.556849');
INSERT INTO public.virksomhet VALUES (258, '800004513', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800004513', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.558747', '2023-09-20 15:45:09.558747');
INSERT INTO public.virksomhet VALUES (259, '815510655', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815510655', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.561316', '2023-09-20 15:45:09.561316');
INSERT INTO public.virksomhet VALUES (260, '807833757', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807833757', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.564269', '2023-09-20 15:45:09.564269');
INSERT INTO public.virksomhet VALUES (261, '874913674', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874913674', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.567993', '2023-09-20 15:45:09.567993');
INSERT INTO public.virksomhet VALUES (262, '865707207', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865707207', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.571584', '2023-09-20 15:45:09.571584');
INSERT INTO public.virksomhet VALUES (263, '878813506', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878813506', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.580547', '2023-09-20 15:45:09.580547');
INSERT INTO public.virksomhet VALUES (264, '863559303', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863559303', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.585751', '2023-09-20 15:45:09.585751');
INSERT INTO public.virksomhet VALUES (265, '854841360', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854841360', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.589431', '2023-09-20 15:45:09.589431');
INSERT INTO public.virksomhet VALUES (266, '893682691', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893682691', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.592676', '2023-09-20 15:45:09.592676');
INSERT INTO public.virksomhet VALUES (267, '893949319', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893949319', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.597694', '2023-09-20 15:45:09.597694');
INSERT INTO public.virksomhet VALUES (268, '825876867', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825876867', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.603012', '2023-09-20 15:45:09.603012');
INSERT INTO public.virksomhet VALUES (269, '862102393', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862102393', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.609379', '2023-09-20 15:45:09.609379');
INSERT INTO public.virksomhet VALUES (270, '876576630', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876576630', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.614198', '2023-09-20 15:45:09.614198');
INSERT INTO public.virksomhet VALUES (271, '839374478', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839374478', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.61833', '2023-09-20 15:45:09.61833');
INSERT INTO public.virksomhet VALUES (272, '887074592', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887074592', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.625188', '2023-09-20 15:45:09.625188');
INSERT INTO public.virksomhet VALUES (273, '858115058', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858115058', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.629926', '2023-09-20 15:45:09.629926');
INSERT INTO public.virksomhet VALUES (274, '833758984', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833758984', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.634568', '2023-09-20 15:45:09.634568');
INSERT INTO public.virksomhet VALUES (275, '861845843', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861845843', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.638502', '2023-09-20 15:45:09.638502');
INSERT INTO public.virksomhet VALUES (276, '810021012', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810021012', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.642236', '2023-09-20 15:45:09.642236');
INSERT INTO public.virksomhet VALUES (277, '874383060', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874383060', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.646135', '2023-09-20 15:45:09.646135');
INSERT INTO public.virksomhet VALUES (278, '883377510', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883377510', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.649463', '2023-09-20 15:45:09.649463');
INSERT INTO public.virksomhet VALUES (279, '839661067', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839661067', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.653421', '2023-09-20 15:45:09.653421');
INSERT INTO public.virksomhet VALUES (280, '879881537', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879881537', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.65739', '2023-09-20 15:45:09.65739');
INSERT INTO public.virksomhet VALUES (281, '854298397', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854298397', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.660768', '2023-09-20 15:45:09.660768');
INSERT INTO public.virksomhet VALUES (282, '847858198', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847858198', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.664247', '2023-09-20 15:45:09.664247');
INSERT INTO public.virksomhet VALUES (283, '876707327', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876707327', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.667585', '2023-09-20 15:45:09.667585');
INSERT INTO public.virksomhet VALUES (284, '858699494', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858699494', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.671599', '2023-09-20 15:45:09.671599');
INSERT INTO public.virksomhet VALUES (285, '861873966', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861873966', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.67546', '2023-09-20 15:45:09.67546');
INSERT INTO public.virksomhet VALUES (286, '888525472', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 888525472', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.681997', '2023-09-20 15:45:09.681997');
INSERT INTO public.virksomhet VALUES (287, '827662737', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827662737', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.688445', '2023-09-20 15:45:09.688445');
INSERT INTO public.virksomhet VALUES (288, '819333814', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819333814', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.707852', '2023-09-20 15:45:09.707852');
INSERT INTO public.virksomhet VALUES (289, '854962683', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854962683', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.713645', '2023-09-20 15:45:09.713645');
INSERT INTO public.virksomhet VALUES (290, '826990918', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826990918', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.721312', '2023-09-20 15:45:09.721312');
INSERT INTO public.virksomhet VALUES (291, '874654389', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874654389', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.728449', '2023-09-20 15:45:09.728449');
INSERT INTO public.virksomhet VALUES (292, '871171774', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871171774', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.733959', '2023-09-20 15:45:09.733959');
INSERT INTO public.virksomhet VALUES (293, '857723124', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857723124', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.739787', '2023-09-20 15:45:09.739787');
INSERT INTO public.virksomhet VALUES (294, '817427440', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817427440', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.744691', '2023-09-20 15:45:09.744691');
INSERT INTO public.virksomhet VALUES (295, '827735226', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827735226', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.749593', '2023-09-20 15:45:09.749593');
INSERT INTO public.virksomhet VALUES (296, '810373111', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810373111', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.757133', '2023-09-20 15:45:09.757133');
INSERT INTO public.virksomhet VALUES (297, '828628162', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828628162', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.763631', '2023-09-20 15:45:09.763631');
INSERT INTO public.virksomhet VALUES (298, '808837822', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808837822', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.769733', '2023-09-20 15:45:09.769733');
INSERT INTO public.virksomhet VALUES (299, '813354371', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813354371', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.778664', '2023-09-20 15:45:09.778664');
INSERT INTO public.virksomhet VALUES (300, '875316797', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875316797', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.786351', '2023-09-20 15:45:09.786351');
INSERT INTO public.virksomhet VALUES (301, '811920494', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811920494', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.793431', '2023-09-20 15:45:09.793431');
INSERT INTO public.virksomhet VALUES (302, '892369559', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892369559', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.797991', '2023-09-20 15:45:09.797991');
INSERT INTO public.virksomhet VALUES (303, '873929526', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873929526', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.801349', '2023-09-20 15:45:09.801349');
INSERT INTO public.virksomhet VALUES (304, '814663019', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814663019', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.818331', '2023-09-20 15:45:09.818331');
INSERT INTO public.virksomhet VALUES (305, '873287552', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873287552', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.825318', '2023-09-20 15:45:09.825318');
INSERT INTO public.virksomhet VALUES (306, '819360448', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819360448', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.832446', '2023-09-20 15:45:09.832446');
INSERT INTO public.virksomhet VALUES (307, '801440225', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801440225', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.839442', '2023-09-20 15:45:09.839442');
INSERT INTO public.virksomhet VALUES (308, '868950634', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868950634', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.842725', '2023-09-20 15:45:09.842725');
INSERT INTO public.virksomhet VALUES (309, '817957349', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 817957349', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.848178', '2023-09-20 15:45:09.848178');
INSERT INTO public.virksomhet VALUES (310, '835966398', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835966398', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.853494', '2023-09-20 15:45:09.853494');
INSERT INTO public.virksomhet VALUES (311, '834790743', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834790743', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.857909', '2023-09-20 15:45:09.857909');
INSERT INTO public.virksomhet VALUES (312, '834442274', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834442274', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.862098', '2023-09-20 15:45:09.862098');
INSERT INTO public.virksomhet VALUES (313, '808252171', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808252171', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.869778', '2023-09-20 15:45:09.869778');
INSERT INTO public.virksomhet VALUES (314, '890248760', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890248760', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.87408', '2023-09-20 15:45:09.87408');
INSERT INTO public.virksomhet VALUES (315, '865099482', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865099482', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.878618', '2023-09-20 15:45:09.878618');
INSERT INTO public.virksomhet VALUES (316, '813221338', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813221338', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.885186', '2023-09-20 15:45:09.885186');
INSERT INTO public.virksomhet VALUES (317, '842392037', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842392037', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.888969', '2023-09-20 15:45:09.888969');
INSERT INTO public.virksomhet VALUES (318, '834385233', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834385233', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.893871', '2023-09-20 15:45:09.893871');
INSERT INTO public.virksomhet VALUES (319, '849837990', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849837990', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.899378', '2023-09-20 15:45:09.899378');
INSERT INTO public.virksomhet VALUES (320, '885923358', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885923358', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.906492', '2023-09-20 15:45:09.906492');
INSERT INTO public.virksomhet VALUES (321, '839996495', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839996495', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.909813', '2023-09-20 15:45:09.909813');
INSERT INTO public.virksomhet VALUES (322, '811469589', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811469589', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.915021', '2023-09-20 15:45:09.915021');
INSERT INTO public.virksomhet VALUES (323, '833437439', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833437439', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.918612', '2023-09-20 15:45:09.918612');
INSERT INTO public.virksomhet VALUES (324, '826277182', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826277182', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.924022', '2023-09-20 15:45:09.924022');
INSERT INTO public.virksomhet VALUES (325, '865358050', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 865358050', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.927897', '2023-09-20 15:45:09.927897');
INSERT INTO public.virksomhet VALUES (326, '881698955', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881698955', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.932648', '2023-09-20 15:45:09.932648');
INSERT INTO public.virksomhet VALUES (327, '855827742', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855827742', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.936039', '2023-09-20 15:45:09.936039');
INSERT INTO public.virksomhet VALUES (328, '829288621', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829288621', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.939948', '2023-09-20 15:45:09.939948');
INSERT INTO public.virksomhet VALUES (329, '893779608', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893779608', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.943649', '2023-09-20 15:45:09.943649');
INSERT INTO public.virksomhet VALUES (330, '880882302', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880882302', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.947147', '2023-09-20 15:45:09.947147');
INSERT INTO public.virksomhet VALUES (331, '825497333', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 825497333', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.950457', '2023-09-20 15:45:09.950457');
INSERT INTO public.virksomhet VALUES (332, '898480863', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898480863', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.95439', '2023-09-20 15:45:09.95439');
INSERT INTO public.virksomhet VALUES (333, '848313087', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848313087', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.958696', '2023-09-20 15:45:09.958696');
INSERT INTO public.virksomhet VALUES (334, '806457638', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806457638', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.962475', '2023-09-20 15:45:09.962475');
INSERT INTO public.virksomhet VALUES (335, '874065068', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874065068', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.966832', '2023-09-20 15:45:09.966832');
INSERT INTO public.virksomhet VALUES (336, '877536857', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 877536857', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.971499', '2023-09-20 15:45:09.971499');
INSERT INTO public.virksomhet VALUES (337, '854048609', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854048609', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.977144', '2023-09-20 15:45:09.977144');
INSERT INTO public.virksomhet VALUES (338, '826180431', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826180431', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.981966', '2023-09-20 15:45:09.981966');
INSERT INTO public.virksomhet VALUES (339, '804810763', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804810763', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.989751', '2023-09-20 15:45:09.989751');
INSERT INTO public.virksomhet VALUES (340, '824385833', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824385833', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:09.998099', '2023-09-20 15:45:09.998099');
INSERT INTO public.virksomhet VALUES (341, '854115545', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854115545', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.001227', '2023-09-20 15:45:10.001227');
INSERT INTO public.virksomhet VALUES (342, '892252172', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892252172', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.008492', '2023-09-20 15:45:10.008492');
INSERT INTO public.virksomhet VALUES (343, '856868617', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856868617', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.014095', '2023-09-20 15:45:10.014095');
INSERT INTO public.virksomhet VALUES (344, '835816352', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835816352', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.018126', '2023-09-20 15:45:10.018126');
INSERT INTO public.virksomhet VALUES (345, '808489389', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808489389', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.023519', '2023-09-20 15:45:10.023519');
INSERT INTO public.virksomhet VALUES (346, '842564595', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 842564595', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.028234', '2023-09-20 15:45:10.028234');
INSERT INTO public.virksomhet VALUES (347, '862487391', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862487391', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.033466', '2023-09-20 15:45:10.033466');
INSERT INTO public.virksomhet VALUES (348, '844864220', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 844864220', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.038693', '2023-09-20 15:45:10.038693');
INSERT INTO public.virksomhet VALUES (349, '863745120', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 863745120', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.04257', '2023-09-20 15:45:10.04257');
INSERT INTO public.virksomhet VALUES (350, '811463659', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811463659', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.045483', '2023-09-20 15:45:10.045483');
INSERT INTO public.virksomhet VALUES (351, '859424845', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859424845', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.050849', '2023-09-20 15:45:10.050849');
INSERT INTO public.virksomhet VALUES (352, '826162593', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826162593', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.054831', '2023-09-20 15:45:10.054831');
INSERT INTO public.virksomhet VALUES (353, '854501114', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854501114', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.058492', '2023-09-20 15:45:10.058492');
INSERT INTO public.virksomhet VALUES (354, '837971247', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837971247', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.061126', '2023-09-20 15:45:10.061126');
INSERT INTO public.virksomhet VALUES (355, '814526409', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814526409', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.064819', '2023-09-20 15:45:10.064819');
INSERT INTO public.virksomhet VALUES (356, '889233452', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889233452', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.069179', '2023-09-20 15:45:10.069179');
INSERT INTO public.virksomhet VALUES (357, '851933508', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851933508', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.074094', '2023-09-20 15:45:10.074094');
INSERT INTO public.virksomhet VALUES (358, '886861663', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886861663', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.078407', '2023-09-20 15:45:10.078407');
INSERT INTO public.virksomhet VALUES (359, '861967886', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 861967886', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.081502', '2023-09-20 15:45:10.081502');
INSERT INTO public.virksomhet VALUES (360, '824514650', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824514650', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.086186', '2023-09-20 15:45:10.086186');
INSERT INTO public.virksomhet VALUES (361, '821686436', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821686436', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.090442', '2023-09-20 15:45:10.090442');
INSERT INTO public.virksomhet VALUES (362, '879033196', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 879033196', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.094017', '2023-09-20 15:45:10.094017');
INSERT INTO public.virksomhet VALUES (363, '843548997', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843548997', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.096312', '2023-09-20 15:45:10.096312');
INSERT INTO public.virksomhet VALUES (364, '874858772', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874858772', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.100662', '2023-09-20 15:45:10.100662');
INSERT INTO public.virksomhet VALUES (365, '802656356', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802656356', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.115588', '2023-09-20 15:45:10.115588');
INSERT INTO public.virksomhet VALUES (366, '880863319', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 880863319', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.122401', '2023-09-20 15:45:10.122401');
INSERT INTO public.virksomhet VALUES (367, '818100493', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818100493', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.126077', '2023-09-20 15:45:10.126077');
INSERT INTO public.virksomhet VALUES (368, '887531172', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887531172', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.129606', '2023-09-20 15:45:10.129606');
INSERT INTO public.virksomhet VALUES (369, '897549565', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897549565', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.133644', '2023-09-20 15:45:10.133644');
INSERT INTO public.virksomhet VALUES (370, '833746388', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 833746388', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.137319', '2023-09-20 15:45:10.137319');
INSERT INTO public.virksomhet VALUES (371, '864617557', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 864617557', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.139584', '2023-09-20 15:45:10.139584');
INSERT INTO public.virksomhet VALUES (372, '885749792', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 885749792', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.143263', '2023-09-20 15:45:10.143263');
INSERT INTO public.virksomhet VALUES (373, '854373649', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854373649', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.146441', '2023-09-20 15:45:10.146441');
INSERT INTO public.virksomhet VALUES (374, '848288114', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848288114', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.149786', '2023-09-20 15:45:10.149786');
INSERT INTO public.virksomhet VALUES (375, '822516713', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822516713', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.153945', '2023-09-20 15:45:10.153945');
INSERT INTO public.virksomhet VALUES (376, '850613686', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850613686', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.158288', '2023-09-20 15:45:10.158288');
INSERT INTO public.virksomhet VALUES (377, '852103064', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852103064', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.161534', '2023-09-20 15:45:10.161534');
INSERT INTO public.virksomhet VALUES (378, '887895969', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887895969', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.165356', '2023-09-20 15:45:10.165356');
INSERT INTO public.virksomhet VALUES (379, '897049098', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 897049098', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.169023', '2023-09-20 15:45:10.169023');
INSERT INTO public.virksomhet VALUES (380, '802649242', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802649242', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.17315', '2023-09-20 15:45:10.17315');
INSERT INTO public.virksomhet VALUES (381, '857503747', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 857503747', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.177138', '2023-09-20 15:45:10.177138');
INSERT INTO public.virksomhet VALUES (382, '884369375', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884369375', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.211623', '2023-09-20 15:45:10.211623');
INSERT INTO public.virksomhet VALUES (383, '829935543', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829935543', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.217153', '2023-09-20 15:45:10.217153');
INSERT INTO public.virksomhet VALUES (384, '802777851', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 802777851', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.221762', '2023-09-20 15:45:10.221762');
INSERT INTO public.virksomhet VALUES (385, '841413884', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841413884', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.226738', '2023-09-20 15:45:10.226738');
INSERT INTO public.virksomhet VALUES (386, '823768843', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823768843', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.23016', '2023-09-20 15:45:10.23016');
INSERT INTO public.virksomhet VALUES (387, '871525212', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 871525212', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.234434', '2023-09-20 15:45:10.234434');
INSERT INTO public.virksomhet VALUES (388, '808924277', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808924277', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.244859', '2023-09-20 15:45:10.244859');
INSERT INTO public.virksomhet VALUES (389, '851159913', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 851159913', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.24935', '2023-09-20 15:45:10.24935');
INSERT INTO public.virksomhet VALUES (390, '836866744', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836866744', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.254558', '2023-09-20 15:45:10.254558');
INSERT INTO public.virksomhet VALUES (391, '847553918', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847553918', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.26085', '2023-09-20 15:45:10.26085');
INSERT INTO public.virksomhet VALUES (392, '822664169', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822664169', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.266416', '2023-09-20 15:45:10.266416');
INSERT INTO public.virksomhet VALUES (393, '835875990', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835875990', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.27199', '2023-09-20 15:45:10.27199');
INSERT INTO public.virksomhet VALUES (394, '829279885', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829279885', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.279018', '2023-09-20 15:45:10.279018');
INSERT INTO public.virksomhet VALUES (395, '807835433', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807835433', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.286816', '2023-09-20 15:45:10.286816');
INSERT INTO public.virksomhet VALUES (396, '891539796', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891539796', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.294375', '2023-09-20 15:45:10.294375');
INSERT INTO public.virksomhet VALUES (397, '835688521', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835688521', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.299744', '2023-09-20 15:45:10.299744');
INSERT INTO public.virksomhet VALUES (398, '824680928', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824680928', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.305219', '2023-09-20 15:45:10.305219');
INSERT INTO public.virksomhet VALUES (399, '883936426', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883936426', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.309076', '2023-09-20 15:45:10.309076');
INSERT INTO public.virksomhet VALUES (400, '891833338', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891833338', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.312939', '2023-09-20 15:45:10.312939');
INSERT INTO public.virksomhet VALUES (401, '878031681', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878031681', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.317174', '2023-09-20 15:45:10.317174');
INSERT INTO public.virksomhet VALUES (402, '845521141', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845521141', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.321252', '2023-09-20 15:45:10.321252');
INSERT INTO public.virksomhet VALUES (403, '809976227', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809976227', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.326534', '2023-09-20 15:45:10.326534');
INSERT INTO public.virksomhet VALUES (404, '859355587', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 859355587', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.330402', '2023-09-20 15:45:10.330402');
INSERT INTO public.virksomhet VALUES (405, '807325397', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807325397', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.334396', '2023-09-20 15:45:10.334396');
INSERT INTO public.virksomhet VALUES (406, '891463624', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891463624', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.33985', '2023-09-20 15:45:10.33985');
INSERT INTO public.virksomhet VALUES (407, '895835975', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895835975', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.344314', '2023-09-20 15:45:10.344314');
INSERT INTO public.virksomhet VALUES (408, '809233627', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809233627', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.348742', '2023-09-20 15:45:10.348742');
INSERT INTO public.virksomhet VALUES (409, '889087670', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 889087670', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.352995', '2023-09-20 15:45:10.352995');
INSERT INTO public.virksomhet VALUES (410, '820335833', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 820335833', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.356433', '2023-09-20 15:45:10.356433');
INSERT INTO public.virksomhet VALUES (411, '898003942', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898003942', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.360524', '2023-09-20 15:45:10.360524');
INSERT INTO public.virksomhet VALUES (412, '892725587', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 892725587', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.36489', '2023-09-20 15:45:10.36489');
INSERT INTO public.virksomhet VALUES (413, '874702974', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874702974', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.368471', '2023-09-20 15:45:10.368471');
INSERT INTO public.virksomhet VALUES (414, '814697430', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 814697430', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.372556', '2023-09-20 15:45:10.372556');
INSERT INTO public.virksomhet VALUES (415, '868394680', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868394680', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.375354', '2023-09-20 15:45:10.375354');
INSERT INTO public.virksomhet VALUES (416, '868827435', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868827435', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.379636', '2023-09-20 15:45:10.379636');
INSERT INTO public.virksomhet VALUES (417, '826836538', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826836538', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.383475', '2023-09-20 15:45:10.383475');
INSERT INTO public.virksomhet VALUES (418, '852363701', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852363701', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.386993', '2023-09-20 15:45:10.386993');
INSERT INTO public.virksomhet VALUES (419, '843954573', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843954573', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.391536', '2023-09-20 15:45:10.391536');
INSERT INTO public.virksomhet VALUES (420, '854299147', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854299147', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.395734', '2023-09-20 15:45:10.395734');
INSERT INTO public.virksomhet VALUES (421, '878570568', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878570568', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.399664', '2023-09-20 15:45:10.399664');
INSERT INTO public.virksomhet VALUES (422, '853068332', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853068332', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.40384', '2023-09-20 15:45:10.40384');
INSERT INTO public.virksomhet VALUES (423, '855430467', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 855430467', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.407316', '2023-09-20 15:45:10.407316');
INSERT INTO public.virksomhet VALUES (424, '894685451', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 894685451', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.411227', '2023-09-20 15:45:10.411227');
INSERT INTO public.virksomhet VALUES (425, '822981409', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822981409', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.414738', '2023-09-20 15:45:10.414738');
INSERT INTO public.virksomhet VALUES (426, '831415693', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 831415693', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.421961', '2023-09-20 15:45:10.421961');
INSERT INTO public.virksomhet VALUES (427, '846100277', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846100277', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.427263', '2023-09-20 15:45:10.427263');
INSERT INTO public.virksomhet VALUES (428, '847750948', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 847750948', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.431394', '2023-09-20 15:45:10.431394');
INSERT INTO public.virksomhet VALUES (429, '874157752', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874157752', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.434296', '2023-09-20 15:45:10.434296');
INSERT INTO public.virksomhet VALUES (430, '875537262', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 875537262', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.436919', '2023-09-20 15:45:10.436919');
INSERT INTO public.virksomhet VALUES (431, '818277813', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 818277813', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.44117', '2023-09-20 15:45:10.44117');
INSERT INTO public.virksomhet VALUES (432, '826608733', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826608733', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.445113', '2023-09-20 15:45:10.445113');
INSERT INTO public.virksomhet VALUES (433, '819654730', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 819654730', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.44875', '2023-09-20 15:45:10.44875');
INSERT INTO public.virksomhet VALUES (434, '858734514', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858734514', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.453208', '2023-09-20 15:45:10.453208');
INSERT INTO public.virksomhet VALUES (435, '887394013', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887394013', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.457381', '2023-09-20 15:45:10.457381');
INSERT INTO public.virksomhet VALUES (436, '806978546', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806978546', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.459962', '2023-09-20 15:45:10.459962');
INSERT INTO public.virksomhet VALUES (437, '832921799', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832921799', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.463103', '2023-09-20 15:45:10.463103');
INSERT INTO public.virksomhet VALUES (438, '839653608', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839653608', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.466442', '2023-09-20 15:45:10.466442');
INSERT INTO public.virksomhet VALUES (439, '823764470', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823764470', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.470424', '2023-09-20 15:45:10.470424');
INSERT INTO public.virksomhet VALUES (440, '808654021', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808654021', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.474201', '2023-09-20 15:45:10.474201');
INSERT INTO public.virksomhet VALUES (441, '845791967', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 845791967', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.481088', '2023-09-20 15:45:10.481088');
INSERT INTO public.virksomhet VALUES (442, '813492132', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813492132', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.499614', '2023-09-20 15:45:10.499614');
INSERT INTO public.virksomhet VALUES (443, '886404438', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 886404438', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.503911', '2023-09-20 15:45:10.503911');
INSERT INTO public.virksomhet VALUES (444, '826906234', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826906234', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.508119', '2023-09-20 15:45:10.508119');
INSERT INTO public.virksomhet VALUES (445, '884842532', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 884842532', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.510924', '2023-09-20 15:45:10.510924');
INSERT INTO public.virksomhet VALUES (446, '823806402', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823806402', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.514026', '2023-09-20 15:45:10.514026');
INSERT INTO public.virksomhet VALUES (447, '828511475', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828511475', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.518054', '2023-09-20 15:45:10.518054');
INSERT INTO public.virksomhet VALUES (448, '874812930', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 874812930', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.522343', '2023-09-20 15:45:10.522343');
INSERT INTO public.virksomhet VALUES (449, '826631179', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 826631179', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.526577', '2023-09-20 15:45:10.526577');
INSERT INTO public.virksomhet VALUES (450, '835704192', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 835704192', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.529805', '2023-09-20 15:45:10.529805');
INSERT INTO public.virksomhet VALUES (451, '850136949', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850136949', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.532906', '2023-09-20 15:45:10.532906');
INSERT INTO public.virksomhet VALUES (452, '843057612', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843057612', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.536477', '2023-09-20 15:45:10.536477');
INSERT INTO public.virksomhet VALUES (453, '840861739', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840861739', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.540592', '2023-09-20 15:45:10.540592');
INSERT INTO public.virksomhet VALUES (454, '805101105', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 805101105', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.545533', '2023-09-20 15:45:10.545533');
INSERT INTO public.virksomhet VALUES (455, '887848461', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887848461', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.549087', '2023-09-20 15:45:10.549087');
INSERT INTO public.virksomhet VALUES (456, '893141706', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 893141706', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.551759', '2023-09-20 15:45:10.551759');
INSERT INTO public.virksomhet VALUES (457, '821432696', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821432696', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.555144', '2023-09-20 15:45:10.555144');
INSERT INTO public.virksomhet VALUES (458, '837300396', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 837300396', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.559292', '2023-09-20 15:45:10.559292');
INSERT INTO public.virksomhet VALUES (459, '809023320', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809023320', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.562674', '2023-09-20 15:45:10.562674');
INSERT INTO public.virksomhet VALUES (460, '868307087', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 868307087', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.565011', '2023-09-20 15:45:10.565011');
INSERT INTO public.virksomhet VALUES (461, '843098741', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 843098741', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.56725', '2023-09-20 15:45:10.56725');
INSERT INTO public.virksomhet VALUES (462, '815697017', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 815697017', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.583321', '2023-09-20 15:45:10.583321');
INSERT INTO public.virksomhet VALUES (463, '828447962', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828447962', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.589924', '2023-09-20 15:45:10.589924');
INSERT INTO public.virksomhet VALUES (464, '822609218', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 822609218', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.593037', '2023-09-20 15:45:10.593037');
INSERT INTO public.virksomhet VALUES (465, '836946437', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 836946437', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.5972', '2023-09-20 15:45:10.5972');
INSERT INTO public.virksomhet VALUES (466, '883685594', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 883685594', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.60338', '2023-09-20 15:45:10.60338');
INSERT INTO public.virksomhet VALUES (467, '840392436', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840392436', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.608584', '2023-09-20 15:45:10.608584');
INSERT INTO public.virksomhet VALUES (468, '856806194', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856806194', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.61234', '2023-09-20 15:45:10.61234');
INSERT INTO public.virksomhet VALUES (469, '806990673', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806990673', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.616162', '2023-09-20 15:45:10.616162');
INSERT INTO public.virksomhet VALUES (470, '813595696', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 813595696', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.620723', '2023-09-20 15:45:10.620723');
INSERT INTO public.virksomhet VALUES (471, '891297613', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891297613', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.625481', '2023-09-20 15:45:10.625481');
INSERT INTO public.virksomhet VALUES (472, '853554657', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 853554657', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.62807', '2023-09-20 15:45:10.62807');
INSERT INTO public.virksomhet VALUES (473, '849153261', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849153261', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.630744', '2023-09-20 15:45:10.630744');
INSERT INTO public.virksomhet VALUES (474, '827837752', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827837752', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.635649', '2023-09-20 15:45:10.635649');
INSERT INTO public.virksomhet VALUES (475, '839978531', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 839978531', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.639665', '2023-09-20 15:45:10.639665');
INSERT INTO public.virksomhet VALUES (476, '804482373', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 804482373', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.642933', '2023-09-20 15:45:10.642933');
INSERT INTO public.virksomhet VALUES (477, '828759753', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 828759753', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.647388', '2023-09-20 15:45:10.647388');
INSERT INTO public.virksomhet VALUES (478, '849497625', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 849497625', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.650629', '2023-09-20 15:45:10.650629');
INSERT INTO public.virksomhet VALUES (479, '872494324', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 872494324', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.653302', '2023-09-20 15:45:10.653302');
INSERT INTO public.virksomhet VALUES (480, '891327339', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 891327339', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.656344', '2023-09-20 15:45:10.656344');
INSERT INTO public.virksomhet VALUES (481, '856498534', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856498534', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.659887', '2023-09-20 15:45:10.659887');
INSERT INTO public.virksomhet VALUES (482, '869823047', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 869823047', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.663069', '2023-09-20 15:45:10.663069');
INSERT INTO public.virksomhet VALUES (483, '854842974', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 854842974', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.665686', '2023-09-20 15:45:10.665686');
INSERT INTO public.virksomhet VALUES (484, '887264644', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887264644', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.668485', '2023-09-20 15:45:10.668485');
INSERT INTO public.virksomhet VALUES (485, '827930910', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827930910', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.672514', '2023-09-20 15:45:10.672514');
INSERT INTO public.virksomhet VALUES (486, '834399652', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834399652', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.676762', '2023-09-20 15:45:10.676762');
INSERT INTO public.virksomhet VALUES (487, '850604719', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 850604719', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.67977', '2023-09-20 15:45:10.67977');
INSERT INTO public.virksomhet VALUES (488, '811194793', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 811194793', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.686896', '2023-09-20 15:45:10.686896');
INSERT INTO public.virksomhet VALUES (489, '808172276', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808172276', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.691876', '2023-09-20 15:45:10.691876');
INSERT INTO public.virksomhet VALUES (490, '846382671', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 846382671', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.697754', '2023-09-20 15:45:10.697754');
INSERT INTO public.virksomhet VALUES (491, '890681775', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 890681775', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.702265', '2023-09-20 15:45:10.702265');
INSERT INTO public.virksomhet VALUES (492, '878720665', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 878720665', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.707505', '2023-09-20 15:45:10.707505');
INSERT INTO public.virksomhet VALUES (493, '823309582', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823309582', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.71397', '2023-09-20 15:45:10.71397');
INSERT INTO public.virksomhet VALUES (494, '898744138', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 898744138', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.71745', '2023-09-20 15:45:10.71745');
INSERT INTO public.virksomhet VALUES (495, '829172773', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 829172773', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.721007', '2023-09-20 15:45:10.721007');
INSERT INTO public.virksomhet VALUES (496, '823080067', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 823080067', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.726807', '2023-09-20 15:45:10.726807');
INSERT INTO public.virksomhet VALUES (497, '866404258', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866404258', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.730179', '2023-09-20 15:45:10.730179');
INSERT INTO public.virksomhet VALUES (498, '881286826', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881286826', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.736024', '2023-09-20 15:45:10.736024');
INSERT INTO public.virksomhet VALUES (499, '834002266', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 834002266', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.741838', '2023-09-20 15:45:10.741838');
INSERT INTO public.virksomhet VALUES (500, '806570115', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 806570115', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.745607', '2023-09-20 15:45:10.745607');
INSERT INTO public.virksomhet VALUES (501, '808483887', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 808483887', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.750494', '2023-09-20 15:45:10.750494');
INSERT INTO public.virksomhet VALUES (502, '862698070', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 862698070', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.755802', '2023-09-20 15:45:10.755802');
INSERT INTO public.virksomhet VALUES (503, '807756994', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 807756994', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.764353', '2023-09-20 15:45:10.764353');
INSERT INTO public.virksomhet VALUES (504, '824085351', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824085351', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.769599', '2023-09-20 15:45:10.769599');
INSERT INTO public.virksomhet VALUES (505, '866496146', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 866496146', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.775688', '2023-09-20 15:45:10.775688');
INSERT INTO public.virksomhet VALUES (506, '895153005', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 895153005', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.77945', '2023-09-20 15:45:10.77945');
INSERT INTO public.virksomhet VALUES (507, '840237839', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 840237839', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.78497', '2023-09-20 15:45:10.78497');
INSERT INTO public.virksomhet VALUES (508, '873832109', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 873832109', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.793594', '2023-09-20 15:45:10.793594');
INSERT INTO public.virksomhet VALUES (509, '876884282', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 876884282', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.800584', '2023-09-20 15:45:10.800584');
INSERT INTO public.virksomhet VALUES (510, '858719326', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 858719326', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:10.806383', '2023-09-20 15:45:10.806383');
INSERT INTO public.virksomhet VALUES (511, '827064129', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 827064129', '{adresse}', 'AKTIV', '2023-01-01', 100001, '2023-09-20 15:45:18.58362', '2023-09-20 15:45:18.58362');
INSERT INTO public.virksomhet VALUES (512, '827416008', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '800614728 nvaN', '{adresse}', 'AKTIV', NULL, 827416009, '2023-09-20 15:45:18.604439', '2023-09-20 15:45:24.054711');
INSERT INTO public.virksomhet VALUES (513, '809867706', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '607768908 nvaN', '{adresse}', 'AKTIV', NULL, 809867707, '2023-09-20 15:45:18.625487', '2023-09-20 15:45:24.071259');
INSERT INTO public.virksomhet VALUES (514, '864835591', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '195538468 nvaN', '{adresse}', 'AKTIV', NULL, 864835592, '2023-09-20 15:45:18.630383', '2023-09-20 15:45:24.074409');
INSERT INTO public.virksomhet VALUES (515, '873229058', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '850922378 nvaN', '{adresse}', 'AKTIV', NULL, 873229059, '2023-09-20 15:45:18.635965', '2023-09-20 15:45:24.076299');
INSERT INTO public.virksomhet VALUES (516, '864612934', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '439216468 nvaN', '{adresse}', 'AKTIV', NULL, 864612935, '2023-09-20 15:45:18.639864', '2023-09-20 15:45:24.078797');
INSERT INTO public.virksomhet VALUES (527, '803371521', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', '125173308 nvaN', '{adresse}', 'AKTIV', NULL, 803371522, '2023-09-20 15:45:18.703468', '2023-09-20 15:45:24.081192');
INSERT INTO public.virksomhet VALUES (517, '801778443', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 801778443', '{adresse}', 'FJERNET', '2023-01-01', 801778444, '2023-09-20 15:45:18.656714', '2023-09-20 15:45:24.083538');
INSERT INTO public.virksomhet VALUES (518, '810327990', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 810327990', '{adresse}', 'FJERNET', '2023-01-01', 810327991, '2023-09-20 15:45:18.661047', '2023-09-20 15:45:24.084372');
INSERT INTO public.virksomhet VALUES (519, '824034863', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 824034863', '{adresse}', 'FJERNET', '2023-01-01', 824034864, '2023-09-20 15:45:18.66546', '2023-09-20 15:45:24.085099');
INSERT INTO public.virksomhet VALUES (520, '821066600', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 821066600', '{adresse}', 'FJERNET', '2023-01-01', 821066601, '2023-09-20 15:45:18.668326', '2023-09-20 15:45:24.085779');
INSERT INTO public.virksomhet VALUES (521, '856178317', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 856178317', '{adresse}', 'FJERNET', '2023-01-01', 856178318, '2023-09-20 15:45:18.671044', '2023-09-20 15:45:24.086546');
INSERT INTO public.virksomhet VALUES (522, '881392469', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 881392469', '{adresse}', 'SLETTET', '2023-01-01', 881392470, '2023-09-20 15:45:18.684608', '2023-09-20 15:45:24.087178');
INSERT INTO public.virksomhet VALUES (523, '800325562', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 800325562', '{adresse}', 'SLETTET', '2023-01-01', 800325563, '2023-09-20 15:45:18.6885', '2023-09-20 15:45:24.088057');
INSERT INTO public.virksomhet VALUES (524, '832006833', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 832006833', '{adresse}', 'SLETTET', '2023-01-01', 832006834, '2023-09-20 15:45:18.692734', '2023-09-20 15:45:24.088743');
INSERT INTO public.virksomhet VALUES (525, '841487607', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 841487607', '{adresse}', 'SLETTET', '2023-01-01', 841487608, '2023-09-20 15:45:18.696994', '2023-09-20 15:45:24.089267');
INSERT INTO public.virksomhet VALUES (526, '809374902', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 809374902', '{adresse}', 'SLETTET', '2023-01-01', 809374903, '2023-09-20 15:45:18.69974', '2023-09-20 15:45:24.090013');
INSERT INTO public.virksomhet VALUES (534, '848655009', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848655009', '{adresse}', 'AKTIV', NULL, 848655010, '2023-09-20 15:45:24.101768', '2023-09-20 15:45:24.101768');
INSERT INTO public.virksomhet VALUES (535, '852029252', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 852029252', '{adresse}', 'AKTIV', NULL, 852029253, '2023-09-20 15:45:24.105475', '2023-09-20 15:45:24.105475');
INSERT INTO public.virksomhet VALUES (536, '887038208', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 887038208', '{adresse}', 'AKTIV', NULL, 887038209, '2023-09-20 15:45:24.112993', '2023-09-20 15:45:24.112993');
INSERT INTO public.virksomhet VALUES (537, '848736986', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 848736986', '{adresse}', 'AKTIV', NULL, 848736987, '2023-09-20 15:45:24.117308', '2023-09-20 15:45:24.117308');
INSERT INTO public.virksomhet VALUES (538, '816118579', 'Norge', 'NO', '1234', 'POSTSTED', 'OSLO', '0301', 'Navn 816118579', '{adresse}', 'AKTIV', NULL, 816118580, '2023-09-20 15:45:24.121294', '2023-09-20 15:45:24.121294');


--
-- Data for Name: virksomhet_naringsundergrupper; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet_naringsundergrupper VALUES (1, 1, '90.012', NULL, NULL, '2023-09-20 15:45:07.830869', '2023-09-20 15:45:07.830869');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (2, 2, '70.220', '90.012', NULL, '2023-09-20 15:45:07.857462', '2023-09-20 15:45:07.857462');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (3, 3, '90.012', '70.220', NULL, '2023-09-20 15:45:07.882198', '2023-09-20 15:45:07.882198');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (4, 4, '90.012', NULL, NULL, '2023-09-20 15:45:07.890875', '2023-09-20 15:45:07.890875');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (5, 5, '01.120', NULL, NULL, '2023-09-20 15:45:07.924077', '2023-09-20 15:45:07.924077');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (6, 6, '01.120', '90.012', '70.220', '2023-09-20 15:45:07.929493', '2023-09-20 15:45:07.929493');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (7, 7, '01.120', '90.012', '70.220', '2023-09-20 15:45:07.93907', '2023-09-20 15:45:07.93907');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (8, 8, '01.120', '90.012', NULL, '2023-09-20 15:45:07.944947', '2023-09-20 15:45:07.944947');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (9, 9, '01.120', '90.012', '70.220', '2023-09-20 15:45:07.951017', '2023-09-20 15:45:07.951017');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (10, 10, '01.120', '90.012', '70.220', '2023-09-20 15:45:07.962859', '2023-09-20 15:45:07.962859');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (11, 11, '01.120', NULL, NULL, '2023-09-20 15:45:07.973844', '2023-09-20 15:45:07.973844');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (12, 12, '01.120', '90.012', NULL, '2023-09-20 15:45:07.984534', '2023-09-20 15:45:07.984534');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (13, 13, '01.120', NULL, NULL, '2023-09-20 15:45:07.998294', '2023-09-20 15:45:07.998294');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (14, 14, '01.120', NULL, NULL, '2023-09-20 15:45:08.002105', '2023-09-20 15:45:08.002105');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (15, 15, '01.120', '90.012', NULL, '2023-09-20 15:45:08.00627', '2023-09-20 15:45:08.00627');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (16, 16, '01.120', NULL, NULL, '2023-09-20 15:45:08.010717', '2023-09-20 15:45:08.010717');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (17, 17, '01.120', '90.012', NULL, '2023-09-20 15:45:08.016211', '2023-09-20 15:45:08.016211');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (18, 18, '01.120', '90.012', '70.220', '2023-09-20 15:45:08.023852', '2023-09-20 15:45:08.023852');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (19, 19, '01.120', '90.012', NULL, '2023-09-20 15:45:08.02941', '2023-09-20 15:45:08.02941');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (20, 20, '01.120', NULL, NULL, '2023-09-20 15:45:08.035138', '2023-09-20 15:45:08.035138');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (21, 21, '01.120', NULL, NULL, '2023-09-20 15:45:08.040076', '2023-09-20 15:45:08.040076');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (22, 22, '01.120', NULL, NULL, '2023-09-20 15:45:08.047431', '2023-09-20 15:45:08.047431');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (23, 23, '01.120', NULL, NULL, '2023-09-20 15:45:08.055936', '2023-09-20 15:45:08.055936');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (24, 24, '01.120', '90.012', '70.220', '2023-09-20 15:45:08.05932', '2023-09-20 15:45:08.05932');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (25, 25, '01.120', '90.012', NULL, '2023-09-20 15:45:08.06515', '2023-09-20 15:45:08.06515');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (26, 26, '01.120', NULL, NULL, '2023-09-20 15:45:08.069793', '2023-09-20 15:45:08.069793');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (27, 27, '01.120', '90.012', '70.220', '2023-09-20 15:45:08.076425', '2023-09-20 15:45:08.076425');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (28, 28, '01.120', NULL, NULL, '2023-09-20 15:45:08.083921', '2023-09-20 15:45:08.083921');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (29, 29, '01.120', '90.012', '70.220', '2023-09-20 15:45:08.093683', '2023-09-20 15:45:08.093683');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (30, 30, '01.120', '90.012', '70.220', '2023-09-20 15:45:08.098039', '2023-09-20 15:45:08.098039');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (31, 31, '01.120', NULL, NULL, '2023-09-20 15:45:08.104538', '2023-09-20 15:45:08.104538');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (32, 32, '01.120', NULL, NULL, '2023-09-20 15:45:08.111515', '2023-09-20 15:45:08.111515');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (33, 33, '01.120', '90.012', NULL, '2023-09-20 15:45:08.118086', '2023-09-20 15:45:08.118086');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (34, 34, '01.120', NULL, NULL, '2023-09-20 15:45:08.126699', '2023-09-20 15:45:08.126699');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (35, 35, '01.120', '90.012', NULL, '2023-09-20 15:45:08.133214', '2023-09-20 15:45:08.133214');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (36, 36, '01.120', '90.012', '70.220', '2023-09-20 15:45:08.156801', '2023-09-20 15:45:08.156801');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (37, 37, '01.120', NULL, NULL, '2023-09-20 15:45:08.162333', '2023-09-20 15:45:08.162333');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (38, 38, '01.120', '90.012', '70.220', '2023-09-20 15:45:08.184288', '2023-09-20 15:45:08.184288');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (39, 39, '01.120', NULL, NULL, '2023-09-20 15:45:08.190559', '2023-09-20 15:45:08.190559');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (40, 40, '01.120', NULL, NULL, '2023-09-20 15:45:08.197902', '2023-09-20 15:45:08.197902');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (41, 41, '01.120', '90.012', NULL, '2023-09-20 15:45:08.207368', '2023-09-20 15:45:08.207368');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (42, 42, '01.120', NULL, NULL, '2023-09-20 15:45:08.215644', '2023-09-20 15:45:08.215644');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (43, 43, '01.120', '90.012', NULL, '2023-09-20 15:45:08.22108', '2023-09-20 15:45:08.22108');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (44, 44, '01.120', '90.012', '70.220', '2023-09-20 15:45:08.228329', '2023-09-20 15:45:08.228329');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (45, 45, '01.120', '90.012', NULL, '2023-09-20 15:45:08.233737', '2023-09-20 15:45:08.233737');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (46, 46, '01.120', '90.012', NULL, '2023-09-20 15:45:08.244698', '2023-09-20 15:45:08.244698');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (47, 47, '01.120', NULL, NULL, '2023-09-20 15:45:08.269833', '2023-09-20 15:45:08.269833');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (48, 48, '01.120', '90.012', NULL, '2023-09-20 15:45:08.276535', '2023-09-20 15:45:08.276535');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (49, 49, '01.120', NULL, NULL, '2023-09-20 15:45:08.283749', '2023-09-20 15:45:08.283749');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (50, 50, '01.120', NULL, NULL, '2023-09-20 15:45:08.290285', '2023-09-20 15:45:08.290285');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (51, 51, '01.120', '90.012', '70.220', '2023-09-20 15:45:08.297783', '2023-09-20 15:45:08.297783');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (52, 52, '01.120', '90.012', '70.220', '2023-09-20 15:45:08.305766', '2023-09-20 15:45:08.305766');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (53, 53, '01.120', NULL, NULL, '2023-09-20 15:45:08.312972', '2023-09-20 15:45:08.312972');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (54, 54, '01.120', '90.012', NULL, '2023-09-20 15:45:08.317854', '2023-09-20 15:45:08.317854');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (55, 55, '01.120', NULL, NULL, '2023-09-20 15:45:08.324992', '2023-09-20 15:45:08.324992');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (56, 56, '01.120', NULL, NULL, '2023-09-20 15:45:08.331293', '2023-09-20 15:45:08.331293');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (57, 57, '01.120', NULL, NULL, '2023-09-20 15:45:08.336008', '2023-09-20 15:45:08.336008');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (58, 58, '01.120', '90.012', NULL, '2023-09-20 15:45:08.341811', '2023-09-20 15:45:08.341811');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (59, 59, '01.120', '90.012', '70.220', '2023-09-20 15:45:08.347761', '2023-09-20 15:45:08.347761');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (60, 60, '01.120', '90.012', NULL, '2023-09-20 15:45:08.352663', '2023-09-20 15:45:08.352663');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (61, 61, '01.120', NULL, NULL, '2023-09-20 15:45:08.362664', '2023-09-20 15:45:08.362664');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (62, 62, '01.120', '90.012', NULL, '2023-09-20 15:45:08.367811', '2023-09-20 15:45:08.367811');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (63, 63, '01.120', '90.012', NULL, '2023-09-20 15:45:08.375021', '2023-09-20 15:45:08.375021');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (64, 64, '01.120', NULL, NULL, '2023-09-20 15:45:08.384235', '2023-09-20 15:45:08.384235');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (65, 65, '01.120', NULL, NULL, '2023-09-20 15:45:08.389822', '2023-09-20 15:45:08.389822');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (66, 66, '01.120', NULL, NULL, '2023-09-20 15:45:08.398553', '2023-09-20 15:45:08.398553');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (67, 67, '01.120', NULL, NULL, '2023-09-20 15:45:08.405415', '2023-09-20 15:45:08.405415');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (68, 68, '01.120', '90.012', NULL, '2023-09-20 15:45:08.416125', '2023-09-20 15:45:08.416125');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (69, 69, '01.120', NULL, NULL, '2023-09-20 15:45:08.42549', '2023-09-20 15:45:08.42549');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (70, 70, '01.120', '90.012', '70.220', '2023-09-20 15:45:08.430991', '2023-09-20 15:45:08.430991');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (71, 71, '01.120', '90.012', NULL, '2023-09-20 15:45:08.436982', '2023-09-20 15:45:08.436982');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (72, 72, '01.120', NULL, NULL, '2023-09-20 15:45:08.441653', '2023-09-20 15:45:08.441653');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (73, 73, '01.120', NULL, NULL, '2023-09-20 15:45:08.44812', '2023-09-20 15:45:08.44812');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (74, 74, '01.120', NULL, NULL, '2023-09-20 15:45:08.454856', '2023-09-20 15:45:08.454856');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (75, 75, '01.120', NULL, NULL, '2023-09-20 15:45:08.463999', '2023-09-20 15:45:08.463999');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (76, 76, '01.120', '90.012', NULL, '2023-09-20 15:45:08.468299', '2023-09-20 15:45:08.468299');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (77, 77, '01.120', '90.012', NULL, '2023-09-20 15:45:08.47337', '2023-09-20 15:45:08.47337');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (78, 78, '01.120', '90.012', '70.220', '2023-09-20 15:45:08.47704', '2023-09-20 15:45:08.47704');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (79, 79, '01.120', '90.012', '70.220', '2023-09-20 15:45:08.481549', '2023-09-20 15:45:08.481549');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (80, 80, '01.120', NULL, NULL, '2023-09-20 15:45:08.498211', '2023-09-20 15:45:08.498211');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (81, 81, '01.120', '90.012', NULL, '2023-09-20 15:45:08.506769', '2023-09-20 15:45:08.506769');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (82, 82, '01.120', '90.012', NULL, '2023-09-20 15:45:08.511573', '2023-09-20 15:45:08.511573');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (83, 83, '01.120', '90.012', NULL, '2023-09-20 15:45:08.516564', '2023-09-20 15:45:08.516564');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (84, 84, '01.120', NULL, NULL, '2023-09-20 15:45:08.520896', '2023-09-20 15:45:08.520896');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (85, 85, '01.120', NULL, NULL, '2023-09-20 15:45:08.544667', '2023-09-20 15:45:08.544667');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (86, 86, '01.120', NULL, NULL, '2023-09-20 15:45:08.551364', '2023-09-20 15:45:08.551364');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (87, 87, '01.120', '90.012', NULL, '2023-09-20 15:45:08.560183', '2023-09-20 15:45:08.560183');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (88, 88, '01.120', NULL, NULL, '2023-09-20 15:45:08.568964', '2023-09-20 15:45:08.568964');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (89, 89, '01.120', '90.012', NULL, '2023-09-20 15:45:08.576132', '2023-09-20 15:45:08.576132');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (90, 90, '01.120', NULL, NULL, '2023-09-20 15:45:08.583641', '2023-09-20 15:45:08.583641');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (91, 91, '01.120', NULL, NULL, '2023-09-20 15:45:08.588219', '2023-09-20 15:45:08.588219');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (92, 92, '01.120', '90.012', NULL, '2023-09-20 15:45:08.595232', '2023-09-20 15:45:08.595232');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (93, 93, '01.120', '90.012', NULL, '2023-09-20 15:45:08.604463', '2023-09-20 15:45:08.604463');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (94, 94, '01.120', NULL, NULL, '2023-09-20 15:45:08.609075', '2023-09-20 15:45:08.609075');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (95, 95, '01.120', '90.012', NULL, '2023-09-20 15:45:08.616804', '2023-09-20 15:45:08.616804');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (96, 96, '01.120', '90.012', NULL, '2023-09-20 15:45:08.621936', '2023-09-20 15:45:08.621936');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (97, 97, '01.120', '90.012', NULL, '2023-09-20 15:45:08.625046', '2023-09-20 15:45:08.625046');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (98, 98, '01.120', NULL, NULL, '2023-09-20 15:45:08.62849', '2023-09-20 15:45:08.62849');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (99, 99, '01.120', NULL, NULL, '2023-09-20 15:45:08.634896', '2023-09-20 15:45:08.634896');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (100, 100, '01.120', '90.012', '70.220', '2023-09-20 15:45:08.63963', '2023-09-20 15:45:08.63963');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (101, 101, '01.120', '90.012', '70.220', '2023-09-20 15:45:08.644251', '2023-09-20 15:45:08.644251');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (102, 102, '01.120', '90.012', NULL, '2023-09-20 15:45:08.647867', '2023-09-20 15:45:08.647867');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (103, 103, '01.120', '90.012', '70.220', '2023-09-20 15:45:08.652076', '2023-09-20 15:45:08.652076');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (104, 104, '01.120', NULL, NULL, '2023-09-20 15:45:08.656173', '2023-09-20 15:45:08.656173');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (105, 105, '01.120', NULL, NULL, '2023-09-20 15:45:08.660498', '2023-09-20 15:45:08.660498');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (106, 106, '01.120', '90.012', NULL, '2023-09-20 15:45:08.664847', '2023-09-20 15:45:08.664847');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (107, 107, '01.120', '90.012', NULL, '2023-09-20 15:45:08.669622', '2023-09-20 15:45:08.669622');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (108, 108, '01.120', '90.012', NULL, '2023-09-20 15:45:08.673964', '2023-09-20 15:45:08.673964');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (109, 109, '01.120', '90.012', '70.220', '2023-09-20 15:45:08.679891', '2023-09-20 15:45:08.679891');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (110, 110, '01.120', '90.012', NULL, '2023-09-20 15:45:08.68619', '2023-09-20 15:45:08.68619');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (111, 111, '01.120', '90.012', NULL, '2023-09-20 15:45:08.689467', '2023-09-20 15:45:08.689467');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (112, 112, '01.120', NULL, NULL, '2023-09-20 15:45:08.699611', '2023-09-20 15:45:08.699611');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (113, 113, '01.120', NULL, NULL, '2023-09-20 15:45:08.707565', '2023-09-20 15:45:08.707565');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (114, 114, '01.120', NULL, NULL, '2023-09-20 15:45:08.716489', '2023-09-20 15:45:08.716489');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (115, 115, '01.120', NULL, NULL, '2023-09-20 15:45:08.725162', '2023-09-20 15:45:08.725162');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (116, 116, '01.120', NULL, NULL, '2023-09-20 15:45:08.730941', '2023-09-20 15:45:08.730941');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (117, 117, '01.120', '90.012', NULL, '2023-09-20 15:45:08.73884', '2023-09-20 15:45:08.73884');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (118, 118, '01.120', '90.012', NULL, '2023-09-20 15:45:08.744', '2023-09-20 15:45:08.744');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (119, 119, '01.120', '90.012', NULL, '2023-09-20 15:45:08.749974', '2023-09-20 15:45:08.749974');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (120, 120, '01.120', NULL, NULL, '2023-09-20 15:45:08.756554', '2023-09-20 15:45:08.756554');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (121, 121, '01.120', '90.012', NULL, '2023-09-20 15:45:08.763476', '2023-09-20 15:45:08.763476');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (122, 122, '01.120', '90.012', NULL, '2023-09-20 15:45:08.76776', '2023-09-20 15:45:08.76776');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (123, 123, '01.120', NULL, NULL, '2023-09-20 15:45:08.777237', '2023-09-20 15:45:08.777237');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (124, 124, '01.120', '90.012', '70.220', '2023-09-20 15:45:08.784447', '2023-09-20 15:45:08.784447');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (125, 125, '01.120', NULL, NULL, '2023-09-20 15:45:08.789644', '2023-09-20 15:45:08.789644');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (126, 126, '01.120', NULL, NULL, '2023-09-20 15:45:08.796074', '2023-09-20 15:45:08.796074');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (127, 127, '01.120', NULL, NULL, '2023-09-20 15:45:08.802371', '2023-09-20 15:45:08.802371');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (128, 128, '01.120', NULL, NULL, '2023-09-20 15:45:08.811697', '2023-09-20 15:45:08.811697');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (129, 129, '01.120', NULL, NULL, '2023-09-20 15:45:08.816071', '2023-09-20 15:45:08.816071');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (130, 130, '01.120', '90.012', NULL, '2023-09-20 15:45:08.822074', '2023-09-20 15:45:08.822074');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (131, 131, '01.120', NULL, NULL, '2023-09-20 15:45:08.827083', '2023-09-20 15:45:08.827083');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (132, 132, '01.120', '90.012', '70.220', '2023-09-20 15:45:08.831221', '2023-09-20 15:45:08.831221');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (133, 133, '01.120', '90.012', NULL, '2023-09-20 15:45:08.835253', '2023-09-20 15:45:08.835253');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (134, 134, '01.120', NULL, NULL, '2023-09-20 15:45:08.841229', '2023-09-20 15:45:08.841229');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (135, 135, '01.120', NULL, NULL, '2023-09-20 15:45:08.847244', '2023-09-20 15:45:08.847244');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (136, 136, '01.120', '90.012', '70.220', '2023-09-20 15:45:08.855851', '2023-09-20 15:45:08.855851');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (137, 137, '01.120', NULL, NULL, '2023-09-20 15:45:08.864424', '2023-09-20 15:45:08.864424');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (138, 138, '01.120', '90.012', NULL, '2023-09-20 15:45:08.872694', '2023-09-20 15:45:08.872694');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (139, 139, '01.120', NULL, NULL, '2023-09-20 15:45:08.87657', '2023-09-20 15:45:08.87657');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (140, 140, '01.120', '90.012', NULL, '2023-09-20 15:45:08.895007', '2023-09-20 15:45:08.895007');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (141, 141, '01.120', '90.012', NULL, '2023-09-20 15:45:08.901081', '2023-09-20 15:45:08.901081');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (142, 142, '01.120', '90.012', NULL, '2023-09-20 15:45:08.905428', '2023-09-20 15:45:08.905428');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (143, 143, '01.120', '90.012', NULL, '2023-09-20 15:45:08.920468', '2023-09-20 15:45:08.920468');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (144, 144, '01.120', NULL, NULL, '2023-09-20 15:45:08.924847', '2023-09-20 15:45:08.924847');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (145, 145, '01.120', '90.012', '70.220', '2023-09-20 15:45:08.930552', '2023-09-20 15:45:08.930552');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (146, 146, '01.120', '90.012', '70.220', '2023-09-20 15:45:08.935083', '2023-09-20 15:45:08.935083');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (147, 147, '01.120', '90.012', NULL, '2023-09-20 15:45:08.940927', '2023-09-20 15:45:08.940927');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (148, 148, '01.120', '90.012', '70.220', '2023-09-20 15:45:08.945699', '2023-09-20 15:45:08.945699');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (149, 149, '01.120', NULL, NULL, '2023-09-20 15:45:08.972448', '2023-09-20 15:45:08.972448');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (150, 150, '01.120', '90.012', NULL, '2023-09-20 15:45:08.978598', '2023-09-20 15:45:08.978598');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (151, 151, '01.120', NULL, NULL, '2023-09-20 15:45:08.98518', '2023-09-20 15:45:08.98518');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (152, 152, '01.120', '90.012', NULL, '2023-09-20 15:45:08.990324', '2023-09-20 15:45:08.990324');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (153, 153, '01.120', NULL, NULL, '2023-09-20 15:45:08.997734', '2023-09-20 15:45:08.997734');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (154, 154, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.002816', '2023-09-20 15:45:09.002816');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (155, 155, '01.120', NULL, NULL, '2023-09-20 15:45:09.008344', '2023-09-20 15:45:09.008344');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (156, 156, '01.120', NULL, NULL, '2023-09-20 15:45:09.015023', '2023-09-20 15:45:09.015023');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (157, 157, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.023622', '2023-09-20 15:45:09.023622');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (158, 158, '01.120', NULL, NULL, '2023-09-20 15:45:09.030658', '2023-09-20 15:45:09.030658');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (159, 159, '01.120', '90.012', NULL, '2023-09-20 15:45:09.034891', '2023-09-20 15:45:09.034891');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (160, 160, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.040066', '2023-09-20 15:45:09.040066');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (161, 161, '01.120', NULL, NULL, '2023-09-20 15:45:09.043882', '2023-09-20 15:45:09.043882');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (162, 162, '01.120', NULL, NULL, '2023-09-20 15:45:09.047704', '2023-09-20 15:45:09.047704');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (163, 163, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.051648', '2023-09-20 15:45:09.051648');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (164, 164, '01.120', '90.012', NULL, '2023-09-20 15:45:09.056033', '2023-09-20 15:45:09.056033');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (165, 165, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.060292', '2023-09-20 15:45:09.060292');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (166, 166, '01.120', '90.012', NULL, '2023-09-20 15:45:09.064881', '2023-09-20 15:45:09.064881');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (167, 167, '01.120', '90.012', NULL, '2023-09-20 15:45:09.070033', '2023-09-20 15:45:09.070033');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (168, 168, '01.120', '90.012', NULL, '2023-09-20 15:45:09.082781', '2023-09-20 15:45:09.082781');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (169, 169, '01.120', NULL, NULL, '2023-09-20 15:45:09.088256', '2023-09-20 15:45:09.088256');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (170, 170, '01.120', '90.012', NULL, '2023-09-20 15:45:09.093932', '2023-09-20 15:45:09.093932');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (171, 171, '01.120', NULL, NULL, '2023-09-20 15:45:09.097903', '2023-09-20 15:45:09.097903');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (172, 172, '01.120', '90.012', NULL, '2023-09-20 15:45:09.102617', '2023-09-20 15:45:09.102617');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (173, 173, '01.120', '90.012', NULL, '2023-09-20 15:45:09.10604', '2023-09-20 15:45:09.10604');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (174, 174, '01.120', NULL, NULL, '2023-09-20 15:45:09.109562', '2023-09-20 15:45:09.109562');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (175, 175, '01.120', NULL, NULL, '2023-09-20 15:45:09.118013', '2023-09-20 15:45:09.118013');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (176, 176, '01.120', '90.012', NULL, '2023-09-20 15:45:09.122877', '2023-09-20 15:45:09.122877');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (177, 177, '01.120', '90.012', NULL, '2023-09-20 15:45:09.126813', '2023-09-20 15:45:09.126813');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (178, 178, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.136101', '2023-09-20 15:45:09.136101');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (179, 179, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.140818', '2023-09-20 15:45:09.140818');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (180, 180, '01.120', NULL, NULL, '2023-09-20 15:45:09.146793', '2023-09-20 15:45:09.146793');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (181, 181, '01.120', NULL, NULL, '2023-09-20 15:45:09.151587', '2023-09-20 15:45:09.151587');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (182, 182, '01.120', '90.012', NULL, '2023-09-20 15:45:09.155889', '2023-09-20 15:45:09.155889');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (183, 183, '01.120', NULL, NULL, '2023-09-20 15:45:09.161475', '2023-09-20 15:45:09.161475');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (184, 184, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.165569', '2023-09-20 15:45:09.165569');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (185, 185, '01.120', NULL, NULL, '2023-09-20 15:45:09.169116', '2023-09-20 15:45:09.169116');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (186, 186, '01.120', NULL, NULL, '2023-09-20 15:45:09.172895', '2023-09-20 15:45:09.172895');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (187, 187, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.17761', '2023-09-20 15:45:09.17761');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (188, 188, '01.120', NULL, NULL, '2023-09-20 15:45:09.184054', '2023-09-20 15:45:09.184054');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (189, 189, '01.120', '90.012', NULL, '2023-09-20 15:45:09.191583', '2023-09-20 15:45:09.191583');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (190, 190, '01.120', NULL, NULL, '2023-09-20 15:45:09.201115', '2023-09-20 15:45:09.201115');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (191, 191, '01.120', NULL, NULL, '2023-09-20 15:45:09.207821', '2023-09-20 15:45:09.207821');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (192, 192, '01.120', NULL, NULL, '2023-09-20 15:45:09.216322', '2023-09-20 15:45:09.216322');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (193, 193, '01.120', NULL, NULL, '2023-09-20 15:45:09.221859', '2023-09-20 15:45:09.221859');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (194, 194, '01.120', '90.012', NULL, '2023-09-20 15:45:09.226867', '2023-09-20 15:45:09.226867');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (195, 195, '01.120', '90.012', NULL, '2023-09-20 15:45:09.234525', '2023-09-20 15:45:09.234525');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (196, 196, '01.120', NULL, NULL, '2023-09-20 15:45:09.239738', '2023-09-20 15:45:09.239738');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (197, 197, '01.120', NULL, NULL, '2023-09-20 15:45:09.246079', '2023-09-20 15:45:09.246079');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (198, 198, '01.120', NULL, NULL, '2023-09-20 15:45:09.251807', '2023-09-20 15:45:09.251807');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (199, 199, '01.120', '90.012', NULL, '2023-09-20 15:45:09.259717', '2023-09-20 15:45:09.259717');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (200, 200, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.272599', '2023-09-20 15:45:09.272599');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (201, 201, '01.120', '90.012', NULL, '2023-09-20 15:45:09.281352', '2023-09-20 15:45:09.281352');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (202, 202, '01.120', '90.012', NULL, '2023-09-20 15:45:09.286599', '2023-09-20 15:45:09.286599');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (203, 203, '01.120', '90.012', NULL, '2023-09-20 15:45:09.289661', '2023-09-20 15:45:09.289661');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (204, 204, '01.120', '90.012', NULL, '2023-09-20 15:45:09.294571', '2023-09-20 15:45:09.294571');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (205, 205, '01.120', '90.012', NULL, '2023-09-20 15:45:09.298821', '2023-09-20 15:45:09.298821');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (206, 206, '01.120', NULL, NULL, '2023-09-20 15:45:09.307229', '2023-09-20 15:45:09.307229');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (207, 207, '01.120', NULL, NULL, '2023-09-20 15:45:09.311679', '2023-09-20 15:45:09.311679');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (208, 208, '01.120', NULL, NULL, '2023-09-20 15:45:09.316853', '2023-09-20 15:45:09.316853');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (209, 209, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.336139', '2023-09-20 15:45:09.336139');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (210, 210, '01.120', '90.012', NULL, '2023-09-20 15:45:09.343637', '2023-09-20 15:45:09.343637');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (211, 211, '01.120', '90.012', NULL, '2023-09-20 15:45:09.348409', '2023-09-20 15:45:09.348409');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (212, 212, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.352451', '2023-09-20 15:45:09.352451');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (213, 213, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.35851', '2023-09-20 15:45:09.35851');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (214, 214, '01.120', NULL, NULL, '2023-09-20 15:45:09.362183', '2023-09-20 15:45:09.362183');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (215, 215, '01.120', NULL, NULL, '2023-09-20 15:45:09.365483', '2023-09-20 15:45:09.365483');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (216, 216, '01.120', NULL, NULL, '2023-09-20 15:45:09.369751', '2023-09-20 15:45:09.369751');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (217, 217, '01.120', '90.012', NULL, '2023-09-20 15:45:09.374761', '2023-09-20 15:45:09.374761');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (218, 218, '01.120', NULL, NULL, '2023-09-20 15:45:09.378095', '2023-09-20 15:45:09.378095');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (219, 219, '01.120', NULL, NULL, '2023-09-20 15:45:09.383357', '2023-09-20 15:45:09.383357');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (220, 220, '01.120', '90.012', NULL, '2023-09-20 15:45:09.390129', '2023-09-20 15:45:09.390129');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (221, 221, '01.120', NULL, NULL, '2023-09-20 15:45:09.394128', '2023-09-20 15:45:09.394128');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (222, 222, '01.120', NULL, NULL, '2023-09-20 15:45:09.397826', '2023-09-20 15:45:09.397826');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (223, 223, '01.120', NULL, NULL, '2023-09-20 15:45:09.415171', '2023-09-20 15:45:09.415171');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (224, 224, '01.120', NULL, NULL, '2023-09-20 15:45:09.420414', '2023-09-20 15:45:09.420414');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (225, 225, '01.120', NULL, NULL, '2023-09-20 15:45:09.425246', '2023-09-20 15:45:09.425246');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (226, 226, '01.120', NULL, NULL, '2023-09-20 15:45:09.428241', '2023-09-20 15:45:09.428241');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (227, 227, '01.120', '90.012', NULL, '2023-09-20 15:45:09.431047', '2023-09-20 15:45:09.431047');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (228, 228, '01.120', NULL, NULL, '2023-09-20 15:45:09.435047', '2023-09-20 15:45:09.435047');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (229, 229, '01.120', '90.012', NULL, '2023-09-20 15:45:09.439557', '2023-09-20 15:45:09.439557');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (230, 230, '01.120', '90.012', NULL, '2023-09-20 15:45:09.443536', '2023-09-20 15:45:09.443536');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (231, 231, '01.120', NULL, NULL, '2023-09-20 15:45:09.447413', '2023-09-20 15:45:09.447413');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (232, 232, '01.120', NULL, NULL, '2023-09-20 15:45:09.451518', '2023-09-20 15:45:09.451518');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (233, 233, '01.120', NULL, NULL, '2023-09-20 15:45:09.456161', '2023-09-20 15:45:09.456161');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (234, 234, '01.120', '90.012', NULL, '2023-09-20 15:45:09.459876', '2023-09-20 15:45:09.459876');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (235, 235, '01.120', '90.012', NULL, '2023-09-20 15:45:09.464188', '2023-09-20 15:45:09.464188');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (236, 236, '01.120', NULL, NULL, '2023-09-20 15:45:09.469389', '2023-09-20 15:45:09.469389');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (237, 237, '01.120', NULL, NULL, '2023-09-20 15:45:09.4733', '2023-09-20 15:45:09.4733');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (238, 238, '01.120', '90.012', NULL, '2023-09-20 15:45:09.476793', '2023-09-20 15:45:09.476793');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (239, 239, '01.120', '90.012', NULL, '2023-09-20 15:45:09.479439', '2023-09-20 15:45:09.479439');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (240, 240, '01.120', NULL, NULL, '2023-09-20 15:45:09.483352', '2023-09-20 15:45:09.483352');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (241, 241, '01.120', '90.012', NULL, '2023-09-20 15:45:09.48844', '2023-09-20 15:45:09.48844');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (242, 242, '01.120', NULL, NULL, '2023-09-20 15:45:09.492873', '2023-09-20 15:45:09.492873');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (243, 243, '01.120', NULL, NULL, '2023-09-20 15:45:09.497081', '2023-09-20 15:45:09.497081');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (244, 244, '01.120', NULL, NULL, '2023-09-20 15:45:09.500943', '2023-09-20 15:45:09.500943');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (245, 245, '01.120', NULL, NULL, '2023-09-20 15:45:09.505185', '2023-09-20 15:45:09.505185');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (246, 246, '01.120', '90.012', NULL, '2023-09-20 15:45:09.510052', '2023-09-20 15:45:09.510052');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (247, 247, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.513894', '2023-09-20 15:45:09.513894');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (248, 248, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.518309', '2023-09-20 15:45:09.518309');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (249, 249, '01.120', NULL, NULL, '2023-09-20 15:45:09.521728', '2023-09-20 15:45:09.521728');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (250, 250, '01.120', NULL, NULL, '2023-09-20 15:45:09.526815', '2023-09-20 15:45:09.526815');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (251, 251, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.532283', '2023-09-20 15:45:09.532283');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (252, 252, '01.120', NULL, NULL, '2023-09-20 15:45:09.537413', '2023-09-20 15:45:09.537413');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (253, 253, '01.120', NULL, NULL, '2023-09-20 15:45:09.542517', '2023-09-20 15:45:09.542517');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (254, 254, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.546968', '2023-09-20 15:45:09.546968');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (255, 255, '01.120', NULL, NULL, '2023-09-20 15:45:09.550853', '2023-09-20 15:45:09.550853');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (256, 256, '01.120', '90.012', NULL, '2023-09-20 15:45:09.555116', '2023-09-20 15:45:09.555116');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (257, 257, '01.120', NULL, NULL, '2023-09-20 15:45:09.557648', '2023-09-20 15:45:09.557648');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (258, 258, '01.120', '90.012', NULL, '2023-09-20 15:45:09.559574', '2023-09-20 15:45:09.559574');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (259, 259, '01.120', '90.012', NULL, '2023-09-20 15:45:09.562654', '2023-09-20 15:45:09.562654');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (260, 260, '01.120', '90.012', NULL, '2023-09-20 15:45:09.565889', '2023-09-20 15:45:09.565889');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (261, 261, '01.120', NULL, NULL, '2023-09-20 15:45:09.569531', '2023-09-20 15:45:09.569531');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (262, 262, '01.120', NULL, NULL, '2023-09-20 15:45:09.576081', '2023-09-20 15:45:09.576081');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (263, 263, '01.120', NULL, NULL, '2023-09-20 15:45:09.583437', '2023-09-20 15:45:09.583437');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (264, 264, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.587675', '2023-09-20 15:45:09.587675');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (265, 265, '01.120', NULL, NULL, '2023-09-20 15:45:09.590556', '2023-09-20 15:45:09.590556');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (266, 266, '01.120', NULL, NULL, '2023-09-20 15:45:09.595021', '2023-09-20 15:45:09.595021');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (267, 267, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.600187', '2023-09-20 15:45:09.600187');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (268, 268, '01.120', NULL, NULL, '2023-09-20 15:45:09.607426', '2023-09-20 15:45:09.607426');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (269, 269, '01.120', NULL, NULL, '2023-09-20 15:45:09.610764', '2023-09-20 15:45:09.610764');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (270, 270, '01.120', NULL, NULL, '2023-09-20 15:45:09.615992', '2023-09-20 15:45:09.615992');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (271, 271, '01.120', '90.012', NULL, '2023-09-20 15:45:09.623134', '2023-09-20 15:45:09.623134');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (272, 272, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.627382', '2023-09-20 15:45:09.627382');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (273, 273, '01.120', NULL, NULL, '2023-09-20 15:45:09.631594', '2023-09-20 15:45:09.631594');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (274, 274, '01.120', NULL, NULL, '2023-09-20 15:45:09.635949', '2023-09-20 15:45:09.635949');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (275, 275, '01.120', NULL, NULL, '2023-09-20 15:45:09.640335', '2023-09-20 15:45:09.640335');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (276, 276, '01.120', NULL, NULL, '2023-09-20 15:45:09.644488', '2023-09-20 15:45:09.644488');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (277, 277, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.647941', '2023-09-20 15:45:09.647941');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (278, 278, '01.120', NULL, NULL, '2023-09-20 15:45:09.651165', '2023-09-20 15:45:09.651165');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (279, 279, '01.120', NULL, NULL, '2023-09-20 15:45:09.655387', '2023-09-20 15:45:09.655387');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (280, 280, '01.120', '90.012', NULL, '2023-09-20 15:45:09.658872', '2023-09-20 15:45:09.658872');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (281, 281, '01.120', NULL, NULL, '2023-09-20 15:45:09.662038', '2023-09-20 15:45:09.662038');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (282, 282, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.665439', '2023-09-20 15:45:09.665439');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (283, 283, '01.120', NULL, NULL, '2023-09-20 15:45:09.669151', '2023-09-20 15:45:09.669151');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (284, 284, '01.120', '90.012', NULL, '2023-09-20 15:45:09.67335', '2023-09-20 15:45:09.67335');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (285, 285, '01.120', NULL, NULL, '2023-09-20 15:45:09.676947', '2023-09-20 15:45:09.676947');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (286, 286, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.684762', '2023-09-20 15:45:09.684762');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (287, 287, '01.120', NULL, NULL, '2023-09-20 15:45:09.690352', '2023-09-20 15:45:09.690352');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (288, 288, '01.120', NULL, NULL, '2023-09-20 15:45:09.710949', '2023-09-20 15:45:09.710949');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (289, 289, '01.120', NULL, NULL, '2023-09-20 15:45:09.718268', '2023-09-20 15:45:09.718268');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (290, 290, '01.120', NULL, NULL, '2023-09-20 15:45:09.725118', '2023-09-20 15:45:09.725118');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (291, 291, '01.120', NULL, NULL, '2023-09-20 15:45:09.731345', '2023-09-20 15:45:09.731345');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (292, 292, '01.120', '90.012', NULL, '2023-09-20 15:45:09.736363', '2023-09-20 15:45:09.736363');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (293, 293, '01.120', NULL, NULL, '2023-09-20 15:45:09.741926', '2023-09-20 15:45:09.741926');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (294, 294, '01.120', '90.012', NULL, '2023-09-20 15:45:09.746856', '2023-09-20 15:45:09.746856');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (295, 295, '01.120', '90.012', NULL, '2023-09-20 15:45:09.752695', '2023-09-20 15:45:09.752695');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (296, 296, '01.120', '90.012', NULL, '2023-09-20 15:45:09.760176', '2023-09-20 15:45:09.760176');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (297, 297, '01.120', NULL, NULL, '2023-09-20 15:45:09.766642', '2023-09-20 15:45:09.766642');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (298, 298, '01.120', NULL, NULL, '2023-09-20 15:45:09.773623', '2023-09-20 15:45:09.773623');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (299, 299, '01.120', NULL, NULL, '2023-09-20 15:45:09.783081', '2023-09-20 15:45:09.783081');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (300, 300, '01.120', '90.012', NULL, '2023-09-20 15:45:09.788591', '2023-09-20 15:45:09.788591');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (301, 301, '01.120', NULL, NULL, '2023-09-20 15:45:09.79543', '2023-09-20 15:45:09.79543');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (302, 302, '01.120', NULL, NULL, '2023-09-20 15:45:09.799333', '2023-09-20 15:45:09.799333');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (303, 303, '01.120', '90.012', NULL, '2023-09-20 15:45:09.803722', '2023-09-20 15:45:09.803722');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (304, 304, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.822091', '2023-09-20 15:45:09.822091');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (305, 305, '01.120', NULL, NULL, '2023-09-20 15:45:09.827307', '2023-09-20 15:45:09.827307');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (306, 306, '01.120', NULL, NULL, '2023-09-20 15:45:09.835136', '2023-09-20 15:45:09.835136');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (307, 307, '01.120', NULL, NULL, '2023-09-20 15:45:09.840701', '2023-09-20 15:45:09.840701');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (308, 308, '01.120', NULL, NULL, '2023-09-20 15:45:09.844866', '2023-09-20 15:45:09.844866');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (309, 309, '01.120', NULL, NULL, '2023-09-20 15:45:09.850134', '2023-09-20 15:45:09.850134');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (310, 310, '01.120', NULL, NULL, '2023-09-20 15:45:09.855147', '2023-09-20 15:45:09.855147');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (311, 311, '01.120', NULL, NULL, '2023-09-20 15:45:09.85953', '2023-09-20 15:45:09.85953');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (312, 312, '01.120', NULL, NULL, '2023-09-20 15:45:09.865203', '2023-09-20 15:45:09.865203');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (313, 313, '01.120', '90.012', NULL, '2023-09-20 15:45:09.872082', '2023-09-20 15:45:09.872082');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (314, 314, '01.120', NULL, NULL, '2023-09-20 15:45:09.876215', '2023-09-20 15:45:09.876215');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (315, 315, '01.120', '90.012', NULL, '2023-09-20 15:45:09.880805', '2023-09-20 15:45:09.880805');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (316, 316, '01.120', '90.012', NULL, '2023-09-20 15:45:09.887178', '2023-09-20 15:45:09.887178');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (317, 317, '01.120', '90.012', NULL, '2023-09-20 15:45:09.890343', '2023-09-20 15:45:09.890343');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (318, 318, '01.120', '90.012', NULL, '2023-09-20 15:45:09.895868', '2023-09-20 15:45:09.895868');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (319, 319, '01.120', NULL, NULL, '2023-09-20 15:45:09.901034', '2023-09-20 15:45:09.901034');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (320, 320, '01.120', NULL, NULL, '2023-09-20 15:45:09.908116', '2023-09-20 15:45:09.908116');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (321, 321, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.91172', '2023-09-20 15:45:09.91172');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (322, 322, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.916813', '2023-09-20 15:45:09.916813');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (323, 323, '01.120', NULL, NULL, '2023-09-20 15:45:09.921431', '2023-09-20 15:45:09.921431');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (324, 324, '01.120', NULL, NULL, '2023-09-20 15:45:09.925797', '2023-09-20 15:45:09.925797');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (325, 325, '01.120', '90.012', NULL, '2023-09-20 15:45:09.929661', '2023-09-20 15:45:09.929661');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (326, 326, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.934048', '2023-09-20 15:45:09.934048');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (327, 327, '01.120', '90.012', NULL, '2023-09-20 15:45:09.937451', '2023-09-20 15:45:09.937451');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (328, 328, '01.120', NULL, NULL, '2023-09-20 15:45:09.941334', '2023-09-20 15:45:09.941334');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (329, 329, '01.120', '90.012', NULL, '2023-09-20 15:45:09.945246', '2023-09-20 15:45:09.945246');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (330, 330, '01.120', '90.012', NULL, '2023-09-20 15:45:09.948451', '2023-09-20 15:45:09.948451');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (331, 331, '01.120', NULL, NULL, '2023-09-20 15:45:09.951762', '2023-09-20 15:45:09.951762');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (332, 332, '01.120', NULL, NULL, '2023-09-20 15:45:09.956072', '2023-09-20 15:45:09.956072');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (333, 333, '01.120', '90.012', NULL, '2023-09-20 15:45:09.960098', '2023-09-20 15:45:09.960098');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (334, 334, '01.120', NULL, NULL, '2023-09-20 15:45:09.964537', '2023-09-20 15:45:09.964537');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (335, 335, '01.120', '90.012', NULL, '2023-09-20 15:45:09.968233', '2023-09-20 15:45:09.968233');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (336, 336, '01.120', NULL, NULL, '2023-09-20 15:45:09.973099', '2023-09-20 15:45:09.973099');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (337, 337, '01.120', NULL, NULL, '2023-09-20 15:45:09.979848', '2023-09-20 15:45:09.979848');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (338, 338, '01.120', '90.012', NULL, '2023-09-20 15:45:09.984419', '2023-09-20 15:45:09.984419');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (339, 339, '01.120', '90.012', '70.220', '2023-09-20 15:45:09.994093', '2023-09-20 15:45:09.994093');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (340, 340, '01.120', '90.012', NULL, '2023-09-20 15:45:09.99949', '2023-09-20 15:45:09.99949');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (341, 341, '01.120', '90.012', NULL, '2023-09-20 15:45:10.004229', '2023-09-20 15:45:10.004229');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (342, 342, '01.120', '90.012', NULL, '2023-09-20 15:45:10.010465', '2023-09-20 15:45:10.010465');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (343, 343, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.015806', '2023-09-20 15:45:10.015806');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (344, 344, '01.120', NULL, NULL, '2023-09-20 15:45:10.019742', '2023-09-20 15:45:10.019742');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (345, 345, '01.120', NULL, NULL, '2023-09-20 15:45:10.026199', '2023-09-20 15:45:10.026199');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (346, 346, '01.120', NULL, NULL, '2023-09-20 15:45:10.031057', '2023-09-20 15:45:10.031057');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (347, 347, '01.120', NULL, NULL, '2023-09-20 15:45:10.035078', '2023-09-20 15:45:10.035078');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (348, 348, '01.120', NULL, NULL, '2023-09-20 15:45:10.040261', '2023-09-20 15:45:10.040261');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (349, 349, '01.120', '90.012', NULL, '2023-09-20 15:45:10.043866', '2023-09-20 15:45:10.043866');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (350, 350, '01.120', NULL, NULL, '2023-09-20 15:45:10.047201', '2023-09-20 15:45:10.047201');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (351, 351, '01.120', NULL, NULL, '2023-09-20 15:45:10.052534', '2023-09-20 15:45:10.052534');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (352, 352, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.05641', '2023-09-20 15:45:10.05641');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (353, 353, '01.120', NULL, NULL, '2023-09-20 15:45:10.059681', '2023-09-20 15:45:10.059681');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (354, 354, '01.120', '90.012', NULL, '2023-09-20 15:45:10.062619', '2023-09-20 15:45:10.062619');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (355, 355, '01.120', '90.012', NULL, '2023-09-20 15:45:10.066108', '2023-09-20 15:45:10.066108');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (356, 356, '01.120', NULL, NULL, '2023-09-20 15:45:10.071334', '2023-09-20 15:45:10.071334');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (357, 357, '01.120', NULL, NULL, '2023-09-20 15:45:10.076114', '2023-09-20 15:45:10.076114');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (358, 358, '01.120', '90.012', NULL, '2023-09-20 15:45:10.079654', '2023-09-20 15:45:10.079654');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (359, 359, '01.120', '90.012', NULL, '2023-09-20 15:45:10.084005', '2023-09-20 15:45:10.084005');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (360, 360, '01.120', '90.012', NULL, '2023-09-20 15:45:10.089134', '2023-09-20 15:45:10.089134');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (361, 361, '01.120', NULL, NULL, '2023-09-20 15:45:10.091964', '2023-09-20 15:45:10.091964');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (362, 362, '01.120', NULL, NULL, '2023-09-20 15:45:10.095055', '2023-09-20 15:45:10.095055');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (363, 363, '01.120', '90.012', NULL, '2023-09-20 15:45:10.097661', '2023-09-20 15:45:10.097661');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (364, 364, '01.120', '90.012', NULL, '2023-09-20 15:45:10.103148', '2023-09-20 15:45:10.103148');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (365, 365, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.118085', '2023-09-20 15:45:10.118085');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (366, 366, '01.120', NULL, NULL, '2023-09-20 15:45:10.123617', '2023-09-20 15:45:10.123617');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (367, 367, '01.120', NULL, NULL, '2023-09-20 15:45:10.127534', '2023-09-20 15:45:10.127534');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (368, 368, '01.120', NULL, NULL, '2023-09-20 15:45:10.131057', '2023-09-20 15:45:10.131057');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (369, 369, '01.120', NULL, NULL, '2023-09-20 15:45:10.135105', '2023-09-20 15:45:10.135105');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (370, 370, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.13801', '2023-09-20 15:45:10.13801');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (371, 371, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.141336', '2023-09-20 15:45:10.141336');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (372, 372, '01.120', NULL, NULL, '2023-09-20 15:45:10.144908', '2023-09-20 15:45:10.144908');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (373, 373, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.148067', '2023-09-20 15:45:10.148067');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (374, 374, '01.120', '90.012', NULL, '2023-09-20 15:45:10.151343', '2023-09-20 15:45:10.151343');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (375, 375, '01.120', NULL, NULL, '2023-09-20 15:45:10.155487', '2023-09-20 15:45:10.155487');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (376, 376, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.159865', '2023-09-20 15:45:10.159865');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (377, 377, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.163416', '2023-09-20 15:45:10.163416');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (378, 378, '01.120', NULL, NULL, '2023-09-20 15:45:10.166615', '2023-09-20 15:45:10.166615');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (379, 379, '01.120', NULL, NULL, '2023-09-20 15:45:10.170533', '2023-09-20 15:45:10.170533');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (380, 380, '01.120', '90.012', NULL, '2023-09-20 15:45:10.174967', '2023-09-20 15:45:10.174967');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (381, 381, '01.120', '90.012', NULL, '2023-09-20 15:45:10.178824', '2023-09-20 15:45:10.178824');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (382, 382, '01.120', '90.012', NULL, '2023-09-20 15:45:10.214703', '2023-09-20 15:45:10.214703');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (383, 383, '01.120', NULL, NULL, '2023-09-20 15:45:10.21959', '2023-09-20 15:45:10.21959');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (384, 384, '01.120', NULL, NULL, '2023-09-20 15:45:10.224008', '2023-09-20 15:45:10.224008');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (385, 385, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.228397', '2023-09-20 15:45:10.228397');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (386, 386, '01.120', '90.012', NULL, '2023-09-20 15:45:10.231757', '2023-09-20 15:45:10.231757');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (387, 387, '01.120', NULL, NULL, '2023-09-20 15:45:10.238883', '2023-09-20 15:45:10.238883');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (388, 388, '01.120', NULL, NULL, '2023-09-20 15:45:10.246649', '2023-09-20 15:45:10.246649');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (389, 389, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.251063', '2023-09-20 15:45:10.251063');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (390, 390, '01.120', NULL, NULL, '2023-09-20 15:45:10.256616', '2023-09-20 15:45:10.256616');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (391, 391, '01.120', NULL, NULL, '2023-09-20 15:45:10.263622', '2023-09-20 15:45:10.263622');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (392, 392, '01.120', '90.012', NULL, '2023-09-20 15:45:10.269589', '2023-09-20 15:45:10.269589');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (393, 393, '01.120', NULL, NULL, '2023-09-20 15:45:10.275111', '2023-09-20 15:45:10.275111');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (394, 394, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.283504', '2023-09-20 15:45:10.283504');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (395, 395, '01.120', NULL, NULL, '2023-09-20 15:45:10.289464', '2023-09-20 15:45:10.289464');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (396, 396, '01.120', NULL, NULL, '2023-09-20 15:45:10.296652', '2023-09-20 15:45:10.296652');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (397, 397, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.301705', '2023-09-20 15:45:10.301705');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (398, 398, '01.120', NULL, NULL, '2023-09-20 15:45:10.306834', '2023-09-20 15:45:10.306834');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (399, 399, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.310319', '2023-09-20 15:45:10.310319');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (400, 400, '01.120', NULL, NULL, '2023-09-20 15:45:10.314799', '2023-09-20 15:45:10.314799');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (401, 401, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.318684', '2023-09-20 15:45:10.318684');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (402, 402, '01.120', NULL, NULL, '2023-09-20 15:45:10.323215', '2023-09-20 15:45:10.323215');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (403, 403, '01.120', NULL, NULL, '2023-09-20 15:45:10.328217', '2023-09-20 15:45:10.328217');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (404, 404, '01.120', NULL, NULL, '2023-09-20 15:45:10.332465', '2023-09-20 15:45:10.332465');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (405, 405, '01.120', '90.012', NULL, '2023-09-20 15:45:10.335733', '2023-09-20 15:45:10.335733');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (406, 406, '01.120', '90.012', NULL, '2023-09-20 15:45:10.341868', '2023-09-20 15:45:10.341868');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (407, 407, '01.120', NULL, NULL, '2023-09-20 15:45:10.345966', '2023-09-20 15:45:10.345966');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (408, 408, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.350718', '2023-09-20 15:45:10.350718');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (409, 409, '01.120', NULL, NULL, '2023-09-20 15:45:10.354094', '2023-09-20 15:45:10.354094');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (410, 410, '01.120', '90.012', NULL, '2023-09-20 15:45:10.358295', '2023-09-20 15:45:10.358295');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (411, 411, '01.120', NULL, NULL, '2023-09-20 15:45:10.36308', '2023-09-20 15:45:10.36308');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (412, 412, '01.120', '90.012', NULL, '2023-09-20 15:45:10.366696', '2023-09-20 15:45:10.366696');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (413, 413, '01.120', NULL, NULL, '2023-09-20 15:45:10.370074', '2023-09-20 15:45:10.370074');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (414, 414, '01.120', NULL, NULL, '2023-09-20 15:45:10.373384', '2023-09-20 15:45:10.373384');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (415, 415, '01.120', NULL, NULL, '2023-09-20 15:45:10.376946', '2023-09-20 15:45:10.376946');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (416, 416, '01.120', NULL, NULL, '2023-09-20 15:45:10.38158', '2023-09-20 15:45:10.38158');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (417, 417, '01.120', '90.012', NULL, '2023-09-20 15:45:10.384477', '2023-09-20 15:45:10.384477');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (418, 418, '01.120', '90.012', NULL, '2023-09-20 15:45:10.388902', '2023-09-20 15:45:10.388902');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (419, 419, '01.120', '90.012', NULL, '2023-09-20 15:45:10.393576', '2023-09-20 15:45:10.393576');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (420, 420, '01.120', NULL, NULL, '2023-09-20 15:45:10.397332', '2023-09-20 15:45:10.397332');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (421, 421, '01.120', '90.012', NULL, '2023-09-20 15:45:10.401095', '2023-09-20 15:45:10.401095');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (422, 422, '01.120', NULL, NULL, '2023-09-20 15:45:10.405564', '2023-09-20 15:45:10.405564');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (423, 423, '01.120', '90.012', NULL, '2023-09-20 15:45:10.408867', '2023-09-20 15:45:10.408867');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (424, 424, '01.120', NULL, NULL, '2023-09-20 15:45:10.41262', '2023-09-20 15:45:10.41262');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (425, 425, '01.120', NULL, NULL, '2023-09-20 15:45:10.416206', '2023-09-20 15:45:10.416206');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (426, 426, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.425195', '2023-09-20 15:45:10.425195');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (427, 427, '01.120', NULL, NULL, '2023-09-20 15:45:10.429439', '2023-09-20 15:45:10.429439');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (428, 428, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.432659', '2023-09-20 15:45:10.432659');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (429, 429, '01.120', '90.012', NULL, '2023-09-20 15:45:10.435468', '2023-09-20 15:45:10.435468');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (430, 430, '01.120', '90.012', NULL, '2023-09-20 15:45:10.438733', '2023-09-20 15:45:10.438733');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (431, 431, '01.120', NULL, NULL, '2023-09-20 15:45:10.442309', '2023-09-20 15:45:10.442309');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (432, 432, '01.120', NULL, NULL, '2023-09-20 15:45:10.446844', '2023-09-20 15:45:10.446844');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (433, 433, '01.120', '90.012', NULL, '2023-09-20 15:45:10.450353', '2023-09-20 15:45:10.450353');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (434, 434, '01.120', '90.012', NULL, '2023-09-20 15:45:10.455366', '2023-09-20 15:45:10.455366');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (435, 435, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.45853', '2023-09-20 15:45:10.45853');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (436, 436, '01.120', NULL, NULL, '2023-09-20 15:45:10.461293', '2023-09-20 15:45:10.461293');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (437, 437, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.465076', '2023-09-20 15:45:10.465076');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (438, 438, '01.120', NULL, NULL, '2023-09-20 15:45:10.468231', '2023-09-20 15:45:10.468231');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (439, 439, '01.120', NULL, NULL, '2023-09-20 15:45:10.471907', '2023-09-20 15:45:10.471907');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (440, 440, '01.120', NULL, NULL, '2023-09-20 15:45:10.475332', '2023-09-20 15:45:10.475332');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (441, 441, '01.120', '90.012', NULL, '2023-09-20 15:45:10.483112', '2023-09-20 15:45:10.483112');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (442, 442, '01.120', NULL, NULL, '2023-09-20 15:45:10.501602', '2023-09-20 15:45:10.501602');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (443, 443, '01.120', NULL, NULL, '2023-09-20 15:45:10.505874', '2023-09-20 15:45:10.505874');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (444, 444, '01.120', '90.012', NULL, '2023-09-20 15:45:10.50946', '2023-09-20 15:45:10.50946');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (445, 445, '01.120', NULL, NULL, '2023-09-20 15:45:10.512245', '2023-09-20 15:45:10.512245');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (446, 446, '01.120', NULL, NULL, '2023-09-20 15:45:10.515472', '2023-09-20 15:45:10.515472');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (447, 447, '01.120', NULL, NULL, '2023-09-20 15:45:10.519688', '2023-09-20 15:45:10.519688');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (448, 448, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.524469', '2023-09-20 15:45:10.524469');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (449, 449, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.528281', '2023-09-20 15:45:10.528281');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (450, 450, '01.120', '90.012', NULL, '2023-09-20 15:45:10.531101', '2023-09-20 15:45:10.531101');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (451, 451, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.534134', '2023-09-20 15:45:10.534134');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (452, 452, '01.120', '90.012', NULL, '2023-09-20 15:45:10.537593', '2023-09-20 15:45:10.537593');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (453, 453, '01.120', NULL, NULL, '2023-09-20 15:45:10.542221', '2023-09-20 15:45:10.542221');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (454, 454, '01.120', '90.012', NULL, '2023-09-20 15:45:10.54732', '2023-09-20 15:45:10.54732');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (455, 455, '01.120', NULL, NULL, '2023-09-20 15:45:10.550212', '2023-09-20 15:45:10.550212');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (456, 456, '01.120', NULL, NULL, '2023-09-20 15:45:10.553363', '2023-09-20 15:45:10.553363');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (457, 457, '01.120', '90.012', NULL, '2023-09-20 15:45:10.556377', '2023-09-20 15:45:10.556377');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (458, 458, '01.120', NULL, NULL, '2023-09-20 15:45:10.560872', '2023-09-20 15:45:10.560872');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (459, 459, '01.120', NULL, NULL, '2023-09-20 15:45:10.563758', '2023-09-20 15:45:10.563758');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (460, 460, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.565869', '2023-09-20 15:45:10.565869');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (461, 461, '01.120', NULL, NULL, '2023-09-20 15:45:10.568823', '2023-09-20 15:45:10.568823');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (462, 462, '01.120', NULL, NULL, '2023-09-20 15:45:10.586722', '2023-09-20 15:45:10.586722');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (463, 463, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.591038', '2023-09-20 15:45:10.591038');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (464, 464, '01.120', '90.012', NULL, '2023-09-20 15:45:10.594166', '2023-09-20 15:45:10.594166');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (465, 465, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.600445', '2023-09-20 15:45:10.600445');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (466, 466, '01.120', NULL, NULL, '2023-09-20 15:45:10.606395', '2023-09-20 15:45:10.606395');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (467, 467, '01.120', '90.012', NULL, '2023-09-20 15:45:10.609807', '2023-09-20 15:45:10.609807');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (468, 468, '01.120', NULL, NULL, '2023-09-20 15:45:10.613619', '2023-09-20 15:45:10.613619');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (469, 469, '01.120', '90.012', NULL, '2023-09-20 15:45:10.617254', '2023-09-20 15:45:10.617254');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (470, 470, '01.120', NULL, NULL, '2023-09-20 15:45:10.622034', '2023-09-20 15:45:10.622034');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (471, 471, '01.120', '90.012', NULL, '2023-09-20 15:45:10.626673', '2023-09-20 15:45:10.626673');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (472, 472, '01.120', NULL, NULL, '2023-09-20 15:45:10.628862', '2023-09-20 15:45:10.628862');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (473, 473, '01.120', NULL, NULL, '2023-09-20 15:45:10.633439', '2023-09-20 15:45:10.633439');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (474, 474, '01.120', '90.012', NULL, '2023-09-20 15:45:10.638031', '2023-09-20 15:45:10.638031');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (475, 475, '01.120', NULL, NULL, '2023-09-20 15:45:10.640943', '2023-09-20 15:45:10.640943');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (476, 476, '01.120', '90.012', NULL, '2023-09-20 15:45:10.644733', '2023-09-20 15:45:10.644733');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (477, 477, '01.120', NULL, NULL, '2023-09-20 15:45:10.648764', '2023-09-20 15:45:10.648764');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (478, 478, '01.120', '90.012', NULL, '2023-09-20 15:45:10.651714', '2023-09-20 15:45:10.651714');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (479, 479, '01.120', '90.012', NULL, '2023-09-20 15:45:10.654647', '2023-09-20 15:45:10.654647');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (480, 480, '01.120', '90.012', NULL, '2023-09-20 15:45:10.657796', '2023-09-20 15:45:10.657796');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (481, 481, '01.120', NULL, NULL, '2023-09-20 15:45:10.661479', '2023-09-20 15:45:10.661479');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (482, 482, '01.120', NULL, NULL, '2023-09-20 15:45:10.664268', '2023-09-20 15:45:10.664268');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (483, 483, '01.120', '90.012', NULL, '2023-09-20 15:45:10.666783', '2023-09-20 15:45:10.666783');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (484, 484, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.670333', '2023-09-20 15:45:10.670333');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (485, 485, '01.120', NULL, NULL, '2023-09-20 15:45:10.674939', '2023-09-20 15:45:10.674939');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (486, 486, '01.120', '90.012', NULL, '2023-09-20 15:45:10.677981', '2023-09-20 15:45:10.677981');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (487, 487, '01.120', NULL, NULL, '2023-09-20 15:45:10.682963', '2023-09-20 15:45:10.682963');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (488, 488, '01.120', NULL, NULL, '2023-09-20 15:45:10.689701', '2023-09-20 15:45:10.689701');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (489, 489, '01.120', NULL, NULL, '2023-09-20 15:45:10.694039', '2023-09-20 15:45:10.694039');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (490, 490, '01.120', '90.012', NULL, '2023-09-20 15:45:10.699231', '2023-09-20 15:45:10.699231');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (491, 491, '01.120', NULL, NULL, '2023-09-20 15:45:10.70424', '2023-09-20 15:45:10.70424');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (492, 492, '01.120', NULL, NULL, '2023-09-20 15:45:10.710199', '2023-09-20 15:45:10.710199');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (493, 493, '01.120', '90.012', NULL, '2023-09-20 15:45:10.715205', '2023-09-20 15:45:10.715205');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (494, 494, '01.120', '90.012', NULL, '2023-09-20 15:45:10.7192', '2023-09-20 15:45:10.7192');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (495, 495, '01.120', NULL, NULL, '2023-09-20 15:45:10.725158', '2023-09-20 15:45:10.725158');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (496, 496, '01.120', NULL, NULL, '2023-09-20 15:45:10.728211', '2023-09-20 15:45:10.728211');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (497, 497, '01.120', NULL, NULL, '2023-09-20 15:45:10.732053', '2023-09-20 15:45:10.732053');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (498, 498, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.737906', '2023-09-20 15:45:10.737906');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (499, 499, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.743868', '2023-09-20 15:45:10.743868');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (500, 500, '01.120', NULL, NULL, '2023-09-20 15:45:10.747528', '2023-09-20 15:45:10.747528');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (501, 501, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.752383', '2023-09-20 15:45:10.752383');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (502, 502, '01.120', '90.012', NULL, '2023-09-20 15:45:10.759018', '2023-09-20 15:45:10.759018');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (503, 503, '01.120', NULL, NULL, '2023-09-20 15:45:10.766173', '2023-09-20 15:45:10.766173');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (504, 504, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.77369', '2023-09-20 15:45:10.77369');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (505, 505, '01.120', NULL, NULL, '2023-09-20 15:45:10.776988', '2023-09-20 15:45:10.776988');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (506, 506, '01.120', NULL, NULL, '2023-09-20 15:45:10.782645', '2023-09-20 15:45:10.782645');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (507, 507, '01.120', '90.012', NULL, '2023-09-20 15:45:10.787941', '2023-09-20 15:45:10.787941');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (508, 508, '01.120', '90.012', '70.220', '2023-09-20 15:45:10.797474', '2023-09-20 15:45:10.797474');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (509, 509, '01.120', NULL, NULL, '2023-09-20 15:45:10.803045', '2023-09-20 15:45:10.803045');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (510, 510, '01.120', NULL, NULL, '2023-09-20 15:45:10.810085', '2023-09-20 15:45:10.810085');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (511, 511, '01.120', NULL, NULL, '2023-09-20 15:45:18.587776', '2023-09-20 15:45:18.587776');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (517, 517, '01.120', '90.012', '70.220', '2023-09-20 15:45:18.658743', '2023-09-20 15:45:18.658743');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (518, 518, '01.120', NULL, NULL, '2023-09-20 15:45:18.663362', '2023-09-20 15:45:18.663362');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (519, 519, '01.120', '90.012', NULL, '2023-09-20 15:45:18.666613', '2023-09-20 15:45:18.666613');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (520, 520, '01.120', '90.012', '70.220', '2023-09-20 15:45:18.669475', '2023-09-20 15:45:18.669475');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (521, 521, '01.120', '90.012', '70.220', '2023-09-20 15:45:18.673006', '2023-09-20 15:45:18.673006');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (522, 522, '01.120', NULL, NULL, '2023-09-20 15:45:18.686156', '2023-09-20 15:45:18.686156');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (523, 523, '01.120', NULL, NULL, '2023-09-20 15:45:18.690117', '2023-09-20 15:45:18.690117');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (524, 524, '01.120', NULL, NULL, '2023-09-20 15:45:18.695531', '2023-09-20 15:45:18.695531');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (525, 525, '01.120', '90.012', NULL, '2023-09-20 15:45:18.69836', '2023-09-20 15:45:18.69836');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (526, 526, '01.120', NULL, NULL, '2023-09-20 15:45:18.700898', '2023-09-20 15:45:18.700898');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (512, 512, '01.120', NULL, NULL, '2023-09-20 15:45:24.05684', '2023-09-20 15:45:18.613249');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (513, 513, '01.120', '90.012', '70.220', '2023-09-20 15:45:24.07306', '2023-09-20 15:45:18.628141');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (514, 514, '01.120', NULL, NULL, '2023-09-20 15:45:24.075313', '2023-09-20 15:45:18.633048');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (515, 515, '01.120', NULL, NULL, '2023-09-20 15:45:24.077252', '2023-09-20 15:45:18.638146');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (516, 516, '01.120', '90.012', NULL, '2023-09-20 15:45:24.079366', '2023-09-20 15:45:18.642027');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (527, 527, '01.120', '01.110', '70.220', '2023-09-20 15:45:24.082157', '2023-09-20 15:45:18.70524');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (534, 534, '01.120', NULL, NULL, '2023-09-20 15:45:24.103396', '2023-09-20 15:45:24.103396');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (535, 535, '01.120', NULL, NULL, '2023-09-20 15:45:24.108976', '2023-09-20 15:45:24.108976');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (536, 536, '01.120', NULL, NULL, '2023-09-20 15:45:24.114919', '2023-09-20 15:45:24.114919');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (537, 537, '01.120', NULL, NULL, '2023-09-20 15:45:24.118578', '2023-09-20 15:45:24.118578');
INSERT INTO public.virksomhet_naringsundergrupper VALUES (538, 538, '01.120', '90.012', NULL, '2023-09-20 15:45:24.123546', '2023-09-20 15:45:24.123546');


--
-- Data for Name: virksomhet_statistikk_metadata; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.virksomhet_statistikk_metadata VALUES (1, '987654321', 'VIRKSOMHET', '1', '2023-09-20 15:45:14.598141');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (3, '123456789', 'VIRKSOMHET', '1', '2023-09-20 15:45:14.645251');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (5, '555555555', 'VIRKSOMHET', '1', '2023-09-20 15:45:14.645251');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (6, '817218179', 'VIRKSOMHET', '1', '2023-09-20 15:45:14.645251');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (8, '858315727', 'VIRKSOMHET', '1', '2023-09-20 15:45:14.678209');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (10, '867886062', 'VIRKSOMHET', '1', '2023-09-20 15:45:14.678209');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (12, '855774607', 'VIRKSOMHET', '1', '2023-09-20 15:45:14.701663');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (14, '827015467', 'VIRKSOMHET', '3', '2023-09-20 15:45:14.701663');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (15, '805290389', 'VIRKSOMHET', '2', '2023-09-20 15:45:14.701663');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (16, '857768316', 'VIRKSOMHET', '1', '2023-09-20 15:45:14.701663');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (17, '878440626', 'VIRKSOMHET', '2', '2023-09-20 15:45:14.720093');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (18, '837670234', 'VIRKSOMHET', '1', '2023-09-20 15:45:14.720093');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (19, '869337023', 'VIRKSOMHET', '2', '2023-09-20 15:45:14.720093');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (20, '868310560', 'VIRKSOMHET', '1', '2023-09-20 15:45:14.720093');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (21, '854189604', 'VIRKSOMHET', '9', '2023-09-20 15:45:14.735295');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (22, '868245401', 'VIRKSOMHET', '2', '2023-09-20 15:45:14.735295');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (23, '887421757', 'VIRKSOMHET', '1', '2023-09-20 15:45:14.735295');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (24, '801201600', 'VIRKSOMHET', '3', '2023-09-20 15:45:14.749455');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (25, '853912646', 'VIRKSOMHET', '9', '2023-09-20 15:45:14.760767');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (26, '871483086', 'VIRKSOMHET', '1', '2023-09-20 15:45:14.760767');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (27, '889480505', 'VIRKSOMHET', '1', '2023-09-20 15:45:14.760767');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (28, '889747942', 'VIRKSOMHET', '9', '2023-09-20 15:45:14.779467');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (29, '862875196', 'VIRKSOMHET', '9', '2023-09-20 15:45:14.779467');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (30, '855525313', 'VIRKSOMHET', '3', '2023-09-20 15:45:14.779467');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (31, '811443790', 'VIRKSOMHET', '1', '2023-09-20 15:45:14.799224');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (32, '833573552', 'VIRKSOMHET', '9', '2023-09-20 15:45:14.799224');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (33, '819462272', 'VIRKSOMHET', '3', '2023-09-20 15:45:14.829634');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (34, '856293477', 'VIRKSOMHET', '3', '2023-09-20 15:45:14.829634');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (35, '882254761', 'VIRKSOMHET', '3', '2023-09-20 15:45:14.829634');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (36, '855039001', 'VIRKSOMHET', '9', '2023-09-20 15:45:14.829634');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (37, '824009121', 'VIRKSOMHET', '9', '2023-09-20 15:45:14.85226');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (38, '800497744', 'VIRKSOMHET', '3', '2023-09-20 15:45:14.85226');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (39, '844731879', 'VIRKSOMHET', '1', '2023-09-20 15:45:14.85226');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (40, '840016805', 'VIRKSOMHET', '3', '2023-09-20 15:45:14.868626');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (41, '888553487', 'VIRKSOMHET', '9', '2023-09-20 15:45:14.868626');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (42, '806720589', 'VIRKSOMHET', '1', '2023-09-20 15:45:14.868626');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (43, '837337985', 'VIRKSOMHET', '3', '2023-09-20 15:45:14.868626');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (44, '874871261', 'VIRKSOMHET', '2', '2023-09-20 15:45:14.897425');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (45, '801074620', 'VIRKSOMHET', '9', '2023-09-20 15:45:14.897425');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (46, '876853959', 'VIRKSOMHET', '1', '2023-09-20 15:45:14.914932');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (47, '889812652', 'VIRKSOMHET', '3', '2023-09-20 15:45:14.914932');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (48, '839437706', 'VIRKSOMHET', '2', '2023-09-20 15:45:14.914932');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (49, '845771147', 'VIRKSOMHET', '9', '2023-09-20 15:45:14.951698');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (50, '855530089', 'VIRKSOMHET', '3', '2023-09-20 15:45:14.951698');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (51, '892871410', 'VIRKSOMHET', '2', '2023-09-20 15:45:14.951698');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (52, '874569933', 'VIRKSOMHET', '2', '2023-09-20 15:45:14.981799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (53, '890920316', 'VIRKSOMHET', '1', '2023-09-20 15:45:14.981799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (54, '806574144', 'VIRKSOMHET', '1', '2023-09-20 15:45:14.981799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (55, '897019567', 'VIRKSOMHET', '1', '2023-09-20 15:45:14.981799');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (56, '899744758', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.056899');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (57, '879055458', 'VIRKSOMHET', '2', '2023-09-20 15:45:15.056899');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (58, '849291295', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.056899');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (59, '876484129', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.056899');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (60, '804794544', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.056899');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (61, '801414721', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.08549');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (62, '853084595', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.08549');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (63, '814750942', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.08549');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (64, '894248802', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.105651');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (65, '895438962', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.105651');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (66, '894222980', 'VIRKSOMHET', '2', '2023-09-20 15:45:15.105651');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (67, '892644608', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.105651');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (68, '861296525', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.105651');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (69, '856974053', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.127541');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (70, '893401740', 'VIRKSOMHET', '2', '2023-09-20 15:45:15.127541');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (71, '898873892', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.144326');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (72, '890416553', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.144326');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (73, '883382387', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.144326');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (74, '819780616', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.16632');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (75, '840103549', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.16632');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (76, '858398076', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.18536');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (77, '820203200', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.18536');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (78, '815962275', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.18536');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (79, '858135043', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.18536');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (80, '808027924', 'VIRKSOMHET', '2', '2023-09-20 15:45:15.204997');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (81, '825903416', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.204997');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (82, '824836141', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.204997');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (83, '832710844', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.220624');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (84, '842362113', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.220624');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (85, '850606669', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.220624');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (86, '850242937', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.234271');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (87, '828871863', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.234271');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (88, '822859420', 'VIRKSOMHET', '2', '2023-09-20 15:45:15.234271');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (89, '843001698', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.234271');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (90, '831692857', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.253142');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (91, '886195004', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.253142');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (92, '813134297', 'VIRKSOMHET', '2', '2023-09-20 15:45:15.253142');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (93, '854341349', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.265724');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (94, '852255739', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.265724');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (95, '831919224', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.265724');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (96, '893956693', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.265724');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (97, '887068890', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.283357');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (98, '859377546', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.283357');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (99, '808337271', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.283357');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (100, '892079041', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.283357');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (101, '825309841', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.31364');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (102, '899283543', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.31364');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (103, '836105668', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.31364');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (104, '899617322', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.31364');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (105, '897369016', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.336272');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (106, '847909287', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.336272');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (107, '885363201', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.336272');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (108, '895703494', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.336272');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (109, '805582082', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.351472');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (110, '831313921', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.351472');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (111, '887250798', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.351472');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (112, '876662451', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.351472');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (113, '829725165', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.367307');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (114, '862196487', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.367307');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (115, '851434861', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.367307');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (116, '861181928', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.386323');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (117, '852787577', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.406165');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (118, '801830575', 'VIRKSOMHET', '2', '2023-09-20 15:45:15.406165');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (119, '836614467', 'VIRKSOMHET', '2', '2023-09-20 15:45:15.406165');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (120, '893864437', 'VIRKSOMHET', '2', '2023-09-20 15:45:15.426654');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (121, '831824518', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.451484');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (122, '824296444', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.451484');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (123, '869460321', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.451484');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (124, '808176785', 'VIRKSOMHET', '2', '2023-09-20 15:45:15.472018');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (125, '863481189', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.472018');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (126, '891032390', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.488779');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (127, '827341816', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.488779');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (128, '897698399', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.519875');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (129, '890446075', 'VIRKSOMHET', '2', '2023-09-20 15:45:15.519875');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (130, '845411087', 'VIRKSOMHET', '2', '2023-09-20 15:45:15.519875');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (131, '873878975', 'VIRKSOMHET', '2', '2023-09-20 15:45:15.538953');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (132, '823474091', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.538953');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (133, '807676378', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.538953');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (134, '832530561', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.564919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (135, '848331429', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.564919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (136, '857977631', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.564919');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (137, '821437524', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.586179');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (138, '813058997', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.586179');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (139, '817599634', 'VIRKSOMHET', '2', '2023-09-20 15:45:15.586179');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (140, '841754369', 'VIRKSOMHET', '2', '2023-09-20 15:45:15.586179');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (141, '848123425', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.586179');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (142, '823949946', 'VIRKSOMHET', '2', '2023-09-20 15:45:15.609433');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (143, '830259693', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.623557');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (144, '825960020', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.623557');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (145, '821955914', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.623557');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (146, '840273134', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.651979');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (147, '804095151', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.670363');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (148, '895219474', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.670363');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (149, '801800235', 'VIRKSOMHET', '2', '2023-09-20 15:45:15.670363');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (150, '807003856', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.696448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (151, '841429259', 'VIRKSOMHET', '2', '2023-09-20 15:45:15.696448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (152, '881670559', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.696448');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (153, '843481844', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.717103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (154, '884326615', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.717103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (155, '853080669', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.717103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (156, '865040557', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.717103');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (157, '817210443', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.731796');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (158, '862357563', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.731796');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (159, '882527092', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.731796');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (160, '851225319', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.731796');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (161, '899519607', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.752181');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (162, '896316258', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.792074');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (163, '800366945', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.792074');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (164, '898008510', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.792074');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (165, '829686729', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.816222');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (166, '846341319', 'VIRKSOMHET', '2', '2023-09-20 15:45:15.816222');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (167, '894967226', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.816222');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (168, '833597055', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.84512');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (169, '874119945', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.84512');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (170, '868445187', 'VIRKSOMHET', '2', '2023-09-20 15:45:15.84512');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (171, '871094397', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.86611');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (172, '802898734', 'VIRKSOMHET', '2', '2023-09-20 15:45:15.896075');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (173, '834917051', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.896075');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (174, '807563291', 'VIRKSOMHET', '2', '2023-09-20 15:45:15.896075');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (175, '835160605', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.896075');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (176, '885992640', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.925757');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (177, '869936536', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.925757');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (178, '859402121', 'VIRKSOMHET', '3', '2023-09-20 15:45:15.925757');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (179, '892954819', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.947942');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (180, '816644800', 'VIRKSOMHET', '9', '2023-09-20 15:45:15.990038');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (181, '806220031', 'VIRKSOMHET', '1', '2023-09-20 15:45:15.990038');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (182, '894638284', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.011467');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (183, '878312512', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.011467');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (184, '842491957', 'VIRKSOMHET', '1', '2023-09-20 15:45:16.011467');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (185, '834513291', 'VIRKSOMHET', '1', '2023-09-20 15:45:16.011467');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (186, '810550084', 'VIRKSOMHET', '1', '2023-09-20 15:45:16.039664');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (187, '803121336', 'VIRKSOMHET', '1', '2023-09-20 15:45:16.063911');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (188, '828279257', 'VIRKSOMHET', '1', '2023-09-20 15:45:16.063911');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (189, '859330839', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.063911');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (190, '830488574', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.1228');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (191, '857478770', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.1228');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (192, '887040001', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.158066');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (193, '891364302', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.158066');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (194, '843653815', 'VIRKSOMHET', '1', '2023-09-20 15:45:16.158066');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (195, '845887942', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.158066');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (196, '861150977', 'VIRKSOMHET', '1', '2023-09-20 15:45:16.228579');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (197, '868136854', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.247421');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (198, '870704831', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.247421');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (199, '889143962', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.247421');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (200, '818905666', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.247421');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (201, '843833062', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.247421');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (202, '866329394', 'VIRKSOMHET', '1', '2023-09-20 15:45:16.247421');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (203, '821557660', 'VIRKSOMHET', '1', '2023-09-20 15:45:16.247421');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (204, '883078463', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.247421');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (205, '873714856', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.268462');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (206, '877777665', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.268462');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (207, '876064107', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.268462');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (208, '891563436', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.293387');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (209, '827967499', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.293387');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (210, '898942783', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.293387');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (211, '836937976', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.321658');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (212, '804568928', 'VIRKSOMHET', '1', '2023-09-20 15:45:16.321658');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (213, '800503985', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.33622');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (214, '813990535', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.33622');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (215, '890758402', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.33622');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (216, '811028317', 'VIRKSOMHET', '1', '2023-09-20 15:45:16.33622');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (217, '804760052', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.33622');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (218, '838548431', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.352953');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (219, '896612714', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.352953');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (220, '851496542', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.352953');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (221, '818563585', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.380966');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (222, '875669833', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.399231');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (223, '819785171', 'VIRKSOMHET', '1', '2023-09-20 15:45:16.399231');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (224, '828584499', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.399231');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (225, '843434835', 'VIRKSOMHET', '1', '2023-09-20 15:45:16.399231');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (226, '875354392', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.425429');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (227, '821764249', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.425429');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (228, '879884092', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.425429');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (229, '887508538', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.450978');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (230, '854025366', 'VIRKSOMHET', '1', '2023-09-20 15:45:16.450978');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (231, '832495084', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.450978');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (232, '819546494', 'VIRKSOMHET', '1', '2023-09-20 15:45:16.471518');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (233, '886234710', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.471518');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (234, '863114808', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.490199');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (235, '806585818', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.490199');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (236, '869277026', 'VIRKSOMHET', '1', '2023-09-20 15:45:16.513211');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (237, '826601992', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.513211');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (238, '845768352', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.531763');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (239, '857606426', 'VIRKSOMHET', '1', '2023-09-20 15:45:16.531763');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (240, '802627162', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.531763');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (241, '896062995', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.531763');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (242, '802773451', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.555434');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (243, '897412501', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.555434');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (244, '877078417', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.555434');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (245, '862364504', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.583127');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (246, '819608759', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.583127');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (247, '847772631', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.583127');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (248, '867565514', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.583127');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (249, '886230666', 'VIRKSOMHET', '1', '2023-09-20 15:45:16.583127');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (250, '890278607', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.605321');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (251, '830954144', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.605321');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (252, '840495641', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.627804');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (253, '853665654', 'VIRKSOMHET', '1', '2023-09-20 15:45:16.627804');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (254, '883098123', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.627804');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (255, '836163189', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.627804');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (256, '841569048', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.641911');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (257, '834225226', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.641911');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (258, '826987922', 'VIRKSOMHET', '1', '2023-09-20 15:45:16.641911');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (259, '847906942', 'VIRKSOMHET', '1', '2023-09-20 15:45:16.641911');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (260, '841372702', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.641911');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (261, '814696095', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.671146');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (262, '800004513', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.671146');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (263, '815510655', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.687166');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (264, '807833757', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.687166');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (265, '874913674', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.687166');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (266, '865707207', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.687166');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (267, '878813506', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.709225');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (268, '863559303', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.709225');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (269, '854841360', 'VIRKSOMHET', '1', '2023-09-20 15:45:16.728218');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (270, '893682691', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.728218');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (271, '893949319', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.728218');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (272, '825876867', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.747829');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (273, '862102393', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.747829');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (274, '876576630', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.76577');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (275, '839374478', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.76577');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (276, '887074592', 'VIRKSOMHET', '1', '2023-09-20 15:45:16.76577');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (277, '858115058', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.76577');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (278, '833758984', 'VIRKSOMHET', '1', '2023-09-20 15:45:16.790566');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (279, '861845843', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.805562');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (280, '810021012', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.805562');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (281, '874383060', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.805562');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (282, '883377510', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.819441');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (283, '839661067', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.819441');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (284, '879881537', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.83865');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (285, '854298397', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.83865');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (286, '847858198', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.83865');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (287, '876707327', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.83865');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (288, '858699494', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.853847');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (289, '861873966', 'VIRKSOMHET', '1', '2023-09-20 15:45:16.853847');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (290, '888525472', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.853847');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (291, '827662737', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.865277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (292, '819333814', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.865277');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (293, '854962683', 'VIRKSOMHET', '1', '2023-09-20 15:45:16.881937');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (294, '826990918', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.899418');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (295, '874654389', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.918035');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (296, '871171774', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.918035');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (297, '857723124', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.931616');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (298, '817427440', 'VIRKSOMHET', '1', '2023-09-20 15:45:16.931616');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (299, '827735226', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.931616');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (300, '810373111', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.953091');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (301, '828628162', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.953091');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (302, '808837822', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.975787');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (303, '813354371', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.975787');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (304, '875316797', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.975787');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (305, '811920494', 'VIRKSOMHET', '3', '2023-09-20 15:45:16.975787');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (306, '892369559', 'VIRKSOMHET', '2', '2023-09-20 15:45:16.998358');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (307, '873929526', 'VIRKSOMHET', '9', '2023-09-20 15:45:16.998358');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (308, '814663019', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.014686');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (309, '873287552', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.014686');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (310, '819360448', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.040536');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (311, '801440225', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.040536');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (312, '868950634', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.065584');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (313, '817957349', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.065584');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (314, '835966398', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.065584');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (315, '834790743', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.087866');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (316, '834442274', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.087866');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (317, '808252171', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.087866');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (318, '890248760', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.087866');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (319, '865099482', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.104399');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (320, '813221338', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.104399');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (321, '842392037', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.121785');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (322, '834385233', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.121785');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (323, '849837990', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.143629');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (324, '885923358', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.143629');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (325, '839996495', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.143629');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (326, '811469589', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.164627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (327, '833437439', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.164627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (328, '826277182', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.164627');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (329, '865358050', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.179961');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (330, '881698955', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.179961');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (331, '855827742', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.179961');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (332, '829288621', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.191764');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (333, '893779608', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.191764');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (334, '880882302', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.219105');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (335, '825497333', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.219105');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (336, '898480863', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.219105');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (337, '848313087', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.234632');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (338, '806457638', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.234632');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (339, '874065068', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.247949');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (340, '877536857', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.247949');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (341, '854048609', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.247949');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (342, '826180431', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.247949');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (343, '804810763', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.266434');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (344, '824385833', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.266434');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (345, '854115545', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.266434');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (346, '892252172', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.283026');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (347, '856868617', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.283026');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (348, '835816352', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.304061');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (349, '808489389', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.304061');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (350, '842564595', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.304061');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (351, '862487391', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.335568');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (352, '844864220', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.335568');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (353, '863745120', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.335568');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (354, '811463659', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.335568');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (355, '859424845', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.357247');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (356, '826162593', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.357247');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (357, '854501114', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.357247');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (358, '837971247', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.376011');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (359, '814526409', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.376011');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (360, '889233452', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.376011');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (361, '851933508', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.376011');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (362, '886861663', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.376011');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (363, '861967886', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.406092');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (364, '824514650', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.406092');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (365, '821686436', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.406092');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (366, '879033196', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.406092');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (367, '843548997', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.425462');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (368, '874858772', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.425462');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (369, '802656356', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.425462');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (370, '880863319', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.487406');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (371, '818100493', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.487406');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (372, '887531172', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.487406');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (373, '897549565', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.487406');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (374, '833746388', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.510267');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (375, '864617557', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.510267');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (376, '885749792', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.510267');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (377, '854373649', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.510267');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (378, '848288114', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.539046');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (379, '822516713', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.539046');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (380, '850613686', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.539046');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (381, '852103064', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.539046');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (382, '887895969', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.539046');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (383, '897049098', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.539046');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (384, '802649242', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.539046');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (385, '857503747', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.556027');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (386, '884369375', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.556027');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (387, '829935543', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.556027');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (388, '802777851', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.556027');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (389, '841413884', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.556027');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (390, '823768843', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.574473');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (391, '871525212', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.574473');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (392, '808924277', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.574473');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (393, '851159913', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.574473');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (394, '836866744', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.574473');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (395, '847553918', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.591182');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (396, '822664169', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.591182');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (397, '835875990', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.591182');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (398, '829279885', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.605401');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (399, '807835433', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.628765');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (400, '891539796', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.628765');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (401, '835688521', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.628765');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (402, '824680928', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.628765');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (403, '883936426', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.665813');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (404, '891833338', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.665813');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (405, '878031681', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.69134');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (406, '845521141', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.69134');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (407, '809976227', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.69134');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (408, '859355587', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.69134');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (409, '807325397', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.709002');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (410, '891463624', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.709002');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (411, '895835975', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.726659');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (412, '809233627', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.726659');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (413, '889087670', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.744153');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (414, '820335833', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.744153');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (415, '898003942', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.761175');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (416, '892725587', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.761175');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (417, '874702974', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.761175');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (418, '814697430', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.761175');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (419, '868394680', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.779011');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (420, '868827435', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.779011');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (421, '826836538', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.779011');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (422, '852363701', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.796768');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (423, '843954573', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.796768');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (424, '854299147', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.815172');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (425, '878570568', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.833834');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (426, '853068332', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.833834');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (427, '855430467', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.833834');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (428, '894685451', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.855701');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (429, '822981409', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.855701');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (430, '831415693', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.855701');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (431, '846100277', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.881267');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (432, '847750948', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.881267');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (433, '874157752', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.881267');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (434, '875537262', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.881267');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (435, '818277813', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.881267');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (436, '826608733', 'VIRKSOMHET', '2', '2023-09-20 15:45:17.942807');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (437, '819654730', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.942807');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (438, '858734514', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.942807');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (439, '887394013', 'VIRKSOMHET', '9', '2023-09-20 15:45:17.942807');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (440, '806978546', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.976577');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (441, '832921799', 'VIRKSOMHET', '3', '2023-09-20 15:45:17.976577');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (442, '839653608', 'VIRKSOMHET', '1', '2023-09-20 15:45:17.976577');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (443, '823764470', 'VIRKSOMHET', '3', '2023-09-20 15:45:18.000989');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (444, '808654021', 'VIRKSOMHET', '9', '2023-09-20 15:45:18.000989');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (445, '845791967', 'VIRKSOMHET', '2', '2023-09-20 15:45:18.000989');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (446, '813492132', 'VIRKSOMHET', '3', '2023-09-20 15:45:18.02145');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (447, '886404438', 'VIRKSOMHET', '9', '2023-09-20 15:45:18.02145');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (448, '826906234', 'VIRKSOMHET', '2', '2023-09-20 15:45:18.02145');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (449, '884842532', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.046541');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (450, '823806402', 'VIRKSOMHET', '2', '2023-09-20 15:45:18.046541');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (451, '828511475', 'VIRKSOMHET', '3', '2023-09-20 15:45:18.046541');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (452, '874812930', 'VIRKSOMHET', '3', '2023-09-20 15:45:18.069756');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (453, '826631179', 'VIRKSOMHET', '3', '2023-09-20 15:45:18.069756');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (454, '835704192', 'VIRKSOMHET', '2', '2023-09-20 15:45:18.069756');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (455, '850136949', 'VIRKSOMHET', '3', '2023-09-20 15:45:18.090619');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (456, '843057612', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.090619');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (457, '840861739', 'VIRKSOMHET', '2', '2023-09-20 15:45:18.090619');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (458, '805101105', 'VIRKSOMHET', '3', '2023-09-20 15:45:18.090619');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (459, '887848461', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.117259');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (460, '893141706', 'VIRKSOMHET', '9', '2023-09-20 15:45:18.117259');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (461, '821432696', 'VIRKSOMHET', '9', '2023-09-20 15:45:18.117259');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (462, '837300396', 'VIRKSOMHET', '3', '2023-09-20 15:45:18.136146');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (463, '809023320', 'VIRKSOMHET', '3', '2023-09-20 15:45:18.136146');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (464, '868307087', 'VIRKSOMHET', '2', '2023-09-20 15:45:18.136146');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (465, '843098741', 'VIRKSOMHET', '2', '2023-09-20 15:45:18.136146');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (466, '815697017', 'VIRKSOMHET', '3', '2023-09-20 15:45:18.163391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (467, '828447962', 'VIRKSOMHET', '2', '2023-09-20 15:45:18.163391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (468, '822609218', 'VIRKSOMHET', '2', '2023-09-20 15:45:18.163391');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (469, '836946437', 'VIRKSOMHET', '3', '2023-09-20 15:45:18.181935');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (470, '883685594', 'VIRKSOMHET', '9', '2023-09-20 15:45:18.197599');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (471, '840392436', 'VIRKSOMHET', '3', '2023-09-20 15:45:18.197599');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (472, '856806194', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.197599');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (473, '806990673', 'VIRKSOMHET', '9', '2023-09-20 15:45:18.197599');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (474, '813595696', 'VIRKSOMHET', '2', '2023-09-20 15:45:18.219026');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (475, '891297613', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.219026');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (476, '853554657', 'VIRKSOMHET', '9', '2023-09-20 15:45:18.244495');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (477, '849153261', 'VIRKSOMHET', '9', '2023-09-20 15:45:18.244495');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (478, '827837752', 'VIRKSOMHET', '9', '2023-09-20 15:45:18.244495');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (479, '839978531', 'VIRKSOMHET', '3', '2023-09-20 15:45:18.260765');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (480, '804482373', 'VIRKSOMHET', '9', '2023-09-20 15:45:18.260765');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (481, '828759753', 'VIRKSOMHET', '2', '2023-09-20 15:45:18.260765');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (482, '849497625', 'VIRKSOMHET', '3', '2023-09-20 15:45:18.260765');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (483, '872494324', 'VIRKSOMHET', '9', '2023-09-20 15:45:18.278845');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (484, '891327339', 'VIRKSOMHET', '9', '2023-09-20 15:45:18.278845');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (485, '856498534', 'VIRKSOMHET', '2', '2023-09-20 15:45:18.278845');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (486, '869823047', 'VIRKSOMHET', '2', '2023-09-20 15:45:18.299123');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (487, '854842974', 'VIRKSOMHET', '3', '2023-09-20 15:45:18.320944');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (488, '887264644', 'VIRKSOMHET', '9', '2023-09-20 15:45:18.320944');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (489, '827930910', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.320944');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (490, '834399652', 'VIRKSOMHET', '3', '2023-09-20 15:45:18.355586');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (491, '850604719', 'VIRKSOMHET', '2', '2023-09-20 15:45:18.355586');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (492, '811194793', 'VIRKSOMHET', '3', '2023-09-20 15:45:18.355586');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (493, '808172276', 'VIRKSOMHET', '3', '2023-09-20 15:45:18.376671');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (494, '846382671', 'VIRKSOMHET', '2', '2023-09-20 15:45:18.376671');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (495, '890681775', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.376671');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (496, '878720665', 'VIRKSOMHET', '2', '2023-09-20 15:45:18.376671');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (497, '823309582', 'VIRKSOMHET', '2', '2023-09-20 15:45:18.395965');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (498, '898744138', 'VIRKSOMHET', '9', '2023-09-20 15:45:18.395965');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (499, '829172773', 'VIRKSOMHET', '3', '2023-09-20 15:45:18.395965');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (500, '823080067', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.395965');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (501, '866404258', 'VIRKSOMHET', '9', '2023-09-20 15:45:18.419336');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (502, '881286826', 'VIRKSOMHET', '3', '2023-09-20 15:45:18.419336');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (503, '834002266', 'VIRKSOMHET', '2', '2023-09-20 15:45:18.419336');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (504, '806570115', 'VIRKSOMHET', '3', '2023-09-20 15:45:18.419336');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (505, '808483887', 'VIRKSOMHET', '9', '2023-09-20 15:45:18.436396');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (506, '862698070', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.436396');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (507, '807756994', 'VIRKSOMHET', '9', '2023-09-20 15:45:18.436396');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (508, '824085351', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.470697');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (509, '866496146', 'VIRKSOMHET', '2', '2023-09-20 15:45:18.470697');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (510, '895153005', 'VIRKSOMHET', '2', '2023-09-20 15:45:18.470697');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (511, '840237839', 'VIRKSOMHET', '9', '2023-09-20 15:45:18.490912');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (512, '873832109', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.490912');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (513, '876884282', 'VIRKSOMHET', '9', '2023-09-20 15:45:18.490912');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (514, '858719326', 'VIRKSOMHET', '2', '2023-09-20 15:45:18.490912');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (515, '827064129', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.876116');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (516, '827416008', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.893724');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (517, '809867706', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.911254');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (518, '864835591', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.911254');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (519, '873229058', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.911254');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (520, '864612934', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.929522');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (521, '801778443', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.929522');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (522, '810327990', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.946768');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (523, '824034863', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.946768');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (524, '821066600', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.946768');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (525, '856178317', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.946768');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (526, '881392469', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.975258');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (527, '800325562', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.975258');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (528, '832006833', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.991353');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (529, '841487607', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.991353');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (530, '809374902', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.991353');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (531, '803371521', 'VIRKSOMHET', '1', '2023-09-20 15:45:18.991353');
INSERT INTO public.virksomhet_statistikk_metadata VALUES (532, '848006818', 'VIRKSOMHET', '1', '2023-09-20 15:45:19.020051');


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
-- PostgreSQL database dump complete
--

