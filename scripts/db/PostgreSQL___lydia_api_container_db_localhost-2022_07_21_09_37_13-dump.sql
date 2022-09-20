--
-- PostgreSQL database dump
--

-- Dumped from database version 14.3 (Debian 14.3-1.pgdg110+1)
-- Dumped by pg_dump version 14.0

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.flyway_schema_history OWNER TO postgres;

--
-- Name: hendelse_begrunnelse; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hendelse_begrunnelse (
    hendelse_id character varying NOT NULL,
    aarsak character varying NOT NULL,
    begrunnelse character varying NOT NULL,
    aarsak_enum character varying NOT NULL,
    begrunnelse_enum character varying NOT NULL
);


ALTER TABLE public.hendelse_begrunnelse OWNER TO postgres;

--
-- Name: ia_sak; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.ia_sak OWNER TO postgres;

--
-- Name: ia_sak_hendelse; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ia_sak_hendelse (
    id character varying NOT NULL,
    saksnummer character varying NOT NULL,
    orgnr character varying(20) NOT NULL,
    type character varying NOT NULL,
    opprettet_av character varying NOT NULL,
    opprettet timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.ia_sak_hendelse OWNER TO postgres;

--
-- Name: naring; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.naring (
    kode character varying NOT NULL,
    navn character varying NOT NULL,
    kort_navn character varying
);


ALTER TABLE public.naring OWNER TO postgres;

--
-- Name: sektor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sektor (
    kode character varying NOT NULL,
    navn character varying(255) NOT NULL
);


ALTER TABLE public.sektor OWNER TO postgres;

--
-- Name: sykefravar_statistikk_grunnlag; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.sykefravar_statistikk_grunnlag OWNER TO postgres;

--
-- Name: sykefravar_statistikk_grunnlag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sykefravar_statistikk_grunnlag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sykefravar_statistikk_grunnlag_id_seq OWNER TO postgres;

--
-- Name: sykefravar_statistikk_grunnlag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sykefravar_statistikk_grunnlag_id_seq OWNED BY public.sykefravar_statistikk_grunnlag.id;


--
-- Name: sykefravar_statistikk_land; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.sykefravar_statistikk_land OWNER TO postgres;

--
-- Name: sykefravar_statistikk_land_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sykefravar_statistikk_land_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sykefravar_statistikk_land_id_seq OWNER TO postgres;

--
-- Name: sykefravar_statistikk_land_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sykefravar_statistikk_land_id_seq OWNED BY public.sykefravar_statistikk_land.id;


--
-- Name: sykefravar_statistikk_naring; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.sykefravar_statistikk_naring OWNER TO postgres;

--
-- Name: sykefravar_statistikk_naring_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sykefravar_statistikk_naring_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sykefravar_statistikk_naring_id_seq OWNER TO postgres;

--
-- Name: sykefravar_statistikk_naring_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sykefravar_statistikk_naring_id_seq OWNED BY public.sykefravar_statistikk_naring.id;


--
-- Name: sykefravar_statistikk_naringsundergruppe; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.sykefravar_statistikk_naringsundergruppe OWNER TO postgres;

--
-- Name: sykefravar_statistikk_naringsundergruppe_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sykefravar_statistikk_naringsundergruppe_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sykefravar_statistikk_naringsundergruppe_id_seq OWNER TO postgres;

--
-- Name: sykefravar_statistikk_naringsundergruppe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sykefravar_statistikk_naringsundergruppe_id_seq OWNED BY public.sykefravar_statistikk_naringsundergruppe.id;


--
-- Name: sykefravar_statistikk_sektor; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.sykefravar_statistikk_sektor OWNER TO postgres;

--
-- Name: sykefravar_statistikk_sektor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sykefravar_statistikk_sektor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sykefravar_statistikk_sektor_id_seq OWNER TO postgres;

--
-- Name: sykefravar_statistikk_sektor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sykefravar_statistikk_sektor_id_seq OWNED BY public.sykefravar_statistikk_sektor.id;


--
-- Name: sykefravar_statistikk_virksomhet; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.sykefravar_statistikk_virksomhet OWNER TO postgres;

--
-- Name: sykefravar_statistikk_virksomhet_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sykefravar_statistikk_virksomhet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sykefravar_statistikk_virksomhet_id_seq OWNER TO postgres;

--
-- Name: sykefravar_statistikk_virksomhet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sykefravar_statistikk_virksomhet_id_seq OWNED BY public.sykefravar_statistikk_virksomhet.id;


--
-- Name: virksomhet; Type: TABLE; Schema: public; Owner: postgres
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
    sistendrettidspunkt timestamp without time zone
);


ALTER TABLE public.virksomhet OWNER TO postgres;

--
-- Name: virksomhet_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.virksomhet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.virksomhet_id_seq OWNER TO postgres;

--
-- Name: virksomhet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.virksomhet_id_seq OWNED BY public.virksomhet.id;


--
-- Name: virksomhet_statistikk_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.virksomhet_statistikk_metadata (
    id integer NOT NULL,
    orgnr character varying NOT NULL,
    kategori character varying NOT NULL,
    sektor character varying NOT NULL,
    opprettet timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.virksomhet_statistikk_metadata OWNER TO postgres;

--
-- Name: virksomhet_metadata_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.virksomhet_metadata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.virksomhet_metadata_id_seq OWNER TO postgres;

--
-- Name: virksomhet_metadata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.virksomhet_metadata_id_seq OWNED BY public.virksomhet_statistikk_metadata.id;


--
-- Name: virksomhet_naring; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.virksomhet_naring (
    virksomhet integer NOT NULL,
    narings_kode character varying NOT NULL
);


ALTER TABLE public.virksomhet_naring OWNER TO postgres;

--
-- Name: sykefravar_statistikk_grunnlag id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sykefravar_statistikk_grunnlag ALTER COLUMN id SET DEFAULT nextval('public.sykefravar_statistikk_grunnlag_id_seq'::regclass);


--
-- Name: sykefravar_statistikk_land id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sykefravar_statistikk_land ALTER COLUMN id SET DEFAULT nextval('public.sykefravar_statistikk_land_id_seq'::regclass);


--
-- Name: sykefravar_statistikk_naring id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sykefravar_statistikk_naring ALTER COLUMN id SET DEFAULT nextval('public.sykefravar_statistikk_naring_id_seq'::regclass);


--
-- Name: sykefravar_statistikk_naringsundergruppe id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sykefravar_statistikk_naringsundergruppe ALTER COLUMN id SET DEFAULT nextval('public.sykefravar_statistikk_naringsundergruppe_id_seq'::regclass);


--
-- Name: sykefravar_statistikk_sektor id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sykefravar_statistikk_sektor ALTER COLUMN id SET DEFAULT nextval('public.sykefravar_statistikk_sektor_id_seq'::regclass);


--
-- Name: sykefravar_statistikk_virksomhet id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sykefravar_statistikk_virksomhet ALTER COLUMN id SET DEFAULT nextval('public.sykefravar_statistikk_virksomhet_id_seq'::regclass);


--
-- Name: virksomhet id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.virksomhet ALTER COLUMN id SET DEFAULT nextval('public.virksomhet_id_seq'::regclass);


--
-- Name: virksomhet_statistikk_metadata id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.virksomhet_statistikk_metadata ALTER COLUMN id SET DEFAULT nextval('public.virksomhet_metadata_id_seq'::regclass);


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1	init	SQL	V1__init.sql	1782034767	postgres	2022-07-21 09:34:25.524572	25	t
2	2	create virksomhet adresse	SQL	V2__create_virksomhet_adresse.sql	-64248919	postgres	2022-07-21 09:34:25.598176	19	t
3	3	legg til navn pa virksomhet	SQL	V3__legg_til_navn_pa_virksomhet.sql	60790216	postgres	2022-07-21 09:34:25.643665	10	t
4	4	endre prosent til sykefraversprosent	SQL	V4__endre_prosent_til_sykefraversprosent.sql	125199402	postgres	2022-07-21 09:34:25.68151	9	t
5	5	endre type paa postnummer	SQL	V5__endre_type_paa_postnummer.sql	1895026063	postgres	2022-07-21 09:34:25.7067	12	t
6	6	unique constraint sykefravarstatistikk	SQL	V6__unique_constraint_sykefravarstatistikk.sql	-1493468680	postgres	2022-07-21 09:34:25.739815	5	t
7	7	unique constraint virksomhet	SQL	V7__unique_constraint_virksomhet.sql	2085819180	postgres	2022-07-21 09:34:25.753148	10	t
8	8	unique constraint virksomhet metadata	SQL	V8__unique_constraint_virksomhet_metadata.sql	1632274980	postgres	2022-07-21 09:34:25.77513	6	t
9	9	legg til narings kode tabeller	SQL	V9__legg_til_narings_kode_tabeller.sql	1866713049	postgres	2022-07-21 09:34:25.792712	10	t
10	10	legg til uoppgitt naeringskode	SQL	V10__legg_til_uoppgitt_naeringskode.sql	715256750	postgres	2022-07-21 09:34:25.818475	5	t
11	11	fjern naringskode fra metadata tabell	SQL	V11__fjern_naringskode_fra_metadata_tabell.sql	-23097316	postgres	2022-07-21 09:34:25.833852	15	t
12	12	legg til adresse i virksomhet	SQL	V12__legg_til_adresse_i_virksomhet.sql	-1159443775	postgres	2022-07-21 09:34:25.861208	6	t
13	13	ia prosess	SQL	V13__ia_prosess.sql	-1755516749	postgres	2022-07-21 09:34:25.879711	8	t
14	14	endre ia prosess til ia sak	SQL	V14__endre_ia_prosess_til_ia_sak.sql	-751106797	postgres	2022-07-21 09:34:25.898431	8	t
15	15	endre saknummer	SQL	V15__endre_saknummer.sql	-1379621340	postgres	2022-07-21 09:34:25.913929	5	t
16	16	ia sak hendelse	SQL	V16__ia_sak_hendelse.sql	586872662	postgres	2022-07-21 09:34:25.933582	14	t
17	17	legg til eidAv i ia sak	SQL	V17__legg_til_eidAv_i_ia_sak.sql	-1075526830	postgres	2022-07-21 09:34:25.958869	5	t
18	18	sykefravar statistikk grunnlag	SQL	V18__sykefravar_statistikk_grunnlag.sql	-925423348	postgres	2022-07-21 09:34:25.987189	18	t
19	19	legg til begrunnelser	SQL	V19__legg_til_begrunnelser.sql	779259005	postgres	2022-07-21 09:34:26.022676	11	t
20	20	legg til flere indekser	SQL	V20__legg_til_flere_indekser.sql	-843857404	postgres	2022-07-21 09:34:26.045086	8	t
21	21	fjern enkelt begrunnelse	SQL	V21__fjern_enkelt_begrunnelse.sql	1129743939	postgres	2022-07-21 09:34:26.062066	5	t
22	22	legg til endret felt på statistikk	SQL	V22__legg_til_endret_felt_på_statistikk.sql	-1542988905	postgres	2022-07-21 09:34:26.074011	3	t
23	23	legg til statistikk for sektor	SQL	V23__legg_til_statistikk_for_sektor.sql	-417896716	postgres	2022-07-21 09:34:26.08573	5	t
24	24	unique constraint endre sektor statistikk sektor	SQL	V24__unique_constraint_endre_sektor_statistikk_sektor.sql	773753929	postgres	2022-07-21 09:34:26.098298	8	t
25	25	legg til statistikk for naring og land	SQL	V25__legg_til_statistikk_for_naring_og_land.sql	-336115428	postgres	2022-07-21 09:34:26.117465	13	t
26	26	fjern type fra ia sak	SQL	V26__fjern_type_fra_ia_sak.sql	1889267882	postgres	2022-07-21 09:34:26.138239	3	t
27	27	drop idx orgnr virksomhet	SQL	V27__drop_idx_orgnr_virksomhet.sql	1323783627	postgres	2022-07-21 09:34:26.151031	4	t
28	28	legg til uopgitt tosifret kode	SQL	V28__legg_til_uopgitt_tosifret_kode.sql	-912681527	postgres	2022-07-21 09:34:26.162398	4	t
29	29	index tapte dagsverk	SQL	V29__index_tapte_dagsverk.sql	1914625834	postgres	2022-07-21 09:34:26.176656	5	t
30	30	virksomhet flere felter ifbm oppdatering	SQL	V30__virksomhet_flere_felter_ifbm_oppdatering.sql	-558279761	postgres	2022-07-21 09:34:26.191966	5	t
31	\N	gi tilgang til cloudsqliamuser	SQL	R__gi_tilgang_til_cloudsqliamuser.sql	-103155657	postgres	2022-07-21 09:34:26.208106	8	t
32	\N	gi tilgang til cloudsqliamuser	SQL	R__gi_tilgang_til_cloudsqliamuser.sql	628432999	postgres	2022-07-21 09:34:31.810043	35	t
\.


--
-- Data for Name: hendelse_begrunnelse; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hendelse_begrunnelse (hendelse_id, aarsak, begrunnelse, aarsak_enum, begrunnelse_enum) FROM stdin;
\.


--
-- Data for Name: ia_sak; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ia_sak (saksnummer, orgnr, status, opprettet_av, opprettet, endret_av, endret, endret_av_hendelse, eid_av) FROM stdin;
\.


--
-- Data for Name: ia_sak_hendelse; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ia_sak_hendelse (id, saksnummer, orgnr, type, opprettet_av, opprettet) FROM stdin;
\.


--
-- Data for Name: naring; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.naring (kode, navn, kort_navn) FROM stdin;
00.000	Uoppgitt	Uoppgitt
00	Uoppgitt	Uoppgitt
90	Næring	Kortnavn for 90
90.012	Utøvende kunstnere og underholdningsvirksomhet innen scenekunst	Kortnavn for 90.012
70	Næring	Kortnavn for 70
70.220	Bedriftsrådgivning og annen administrativ rådgivning	Kortnavn for 70.220
01	Næring	Kortnavn for 01
01.120	Dyrking av ris	Kortnavn for 01.120
\.


--
-- Data for Name: sektor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sektor (kode, navn) FROM stdin;
\.


--
-- Data for Name: sykefravar_statistikk_grunnlag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sykefravar_statistikk_grunnlag (id, saksnummer, hendelse_id, orgnr, arstall, kvartal, antall_personer, tapte_dagsverk, mulige_dagsverk, prosent, maskert, opprettet) FROM stdin;
\.


--
-- Data for Name: sykefravar_statistikk_land; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sykefravar_statistikk_land (id, arstall, kvartal, land, antall_personer, tapte_dagsverk, mulige_dagsverk, prosent, maskert, opprettet) FROM stdin;
1	2022	2	NO	2500000	10000000	500000000	2	f	2022-07-21 09:34:34.936128
2	2021	4	NO	2500000	10000000	500000000	2	f	2022-07-21 09:34:35.03926
\.


--
-- Data for Name: sykefravar_statistikk_naring; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sykefravar_statistikk_naring (id, arstall, kvartal, naring, antall_personer, tapte_dagsverk, mulige_dagsverk, prosent, maskert, opprettet) FROM stdin;
1	2022	2	01	150	100	5000	2	f	2022-07-21 09:34:34.936128
2	2021	4	01	150	100	5000	2	f	2022-07-21 09:34:35.03926
\.


--
-- Data for Name: sykefravar_statistikk_naringsundergruppe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sykefravar_statistikk_naringsundergruppe (id, arstall, kvartal, naringsundergruppe, antall_personer, tapte_dagsverk, mulige_dagsverk, prosent, maskert, opprettet) FROM stdin;
1	2022	2	01.110	1250	40	4000	1	f	2022-07-21 09:34:34.936128
2	2021	4	01.110	1250	40	4000	1	f	2022-07-21 09:34:35.03926
\.


--
-- Data for Name: sykefravar_statistikk_sektor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sykefravar_statistikk_sektor (id, arstall, kvartal, sektor_kode, antall_personer, tapte_dagsverk, mulige_dagsverk, prosent, maskert, opprettet) FROM stdin;
1	2022	2	1	33000	1340	8000	1.5	f	2022-07-21 09:34:34.936128
2	2021	4	1	33000	1340	8000	1.5	f	2022-07-21 09:34:35.03926
6	2022	2	3	33000	1340	8000	1.5	f	2022-07-21 09:34:35.166389
7	2022	2	0	33000	1340	8000	1.5	f	2022-07-21 09:34:35.166389
8	2022	2	2	33000	1340	8000	1.5	f	2022-07-21 09:34:35.166389
\.


--
-- Data for Name: sykefravar_statistikk_virksomhet; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sykefravar_statistikk_virksomhet (id, orgnr, arstall, kvartal, antall_personer, tapte_dagsverk, mulige_dagsverk, sykefraversprosent, maskert, opprettet, endret) FROM stdin;
1	987654321	2022	2	6	6404.96468276275	500	2	f	2022-07-21 09:34:34.936128	\N
2	987654321	2021	4	6	6404.96468276275	500	2	f	2022-07-21 09:34:35.03926	\N
3	123456789	2022	2	636.424712752585	598.788894655632	500	7	f	2022-07-21 09:34:35.03926	\N
4	123456789	2021	4	636.424712752585	598.788894655632	500	7	f	2022-07-21 09:34:35.166389	\N
5	984247664	2022	2	1001	4620.95589092275	500	2	f	2022-07-21 09:34:35.166389	\N
6	984247664	2021	4	1001	4620.95589092275	500	2	f	2022-07-21 09:34:35.166389	\N
7	555555555	2022	2	568.661953508203	2235.00058263303	500	2	f	2022-07-21 09:34:35.166389	\N
8	881532376	2022	2	224.680558291364	5242.96624072596	500	6	f	2022-07-21 09:34:35.166389	\N
9	881532376	2021	4	224.680558291364	5242.96624072596	500	6	f	2022-07-21 09:34:35.166389	\N
10	883874352	2022	2	42	1042.72971859856	500	6	f	2022-07-21 09:34:35.166389	\N
11	883874352	2021	4	42	1042.72971859856	500	6	f	2022-07-21 09:34:35.166389	\N
12	848147638	2022	2	950.22175613382	4099.80586336926	500	2	f	2022-07-21 09:34:35.166389	\N
13	876763949	2022	2	634.942701092246	4283.89649136679	500	2	f	2022-07-21 09:34:35.166389	\N
14	871871807	2022	2	961.353943652678	9883.04482729776	500	2	f	2022-07-21 09:34:35.166389	\N
15	864079801	2022	2	478.677164679084	5579.64989642089	500	2	f	2022-07-21 09:34:35.166389	\N
16	836041617	2022	2	677.644155656896	7629.12820988714	500	2	f	2022-07-21 09:34:35.166389	\N
17	857842260	2022	2	596.374196818278	6234.34733252187	500	2	f	2022-07-21 09:34:35.166389	\N
18	885073621	2022	2	769.119421399909	594.127851478808	500	2	f	2022-07-21 09:34:35.166389	\N
19	864754605	2022	2	413.370557634479	5542.05321581646	500	2	f	2022-07-21 09:34:35.166389	\N
20	846347581	2022	2	661.556558253159	3122.85842660902	500	2	f	2022-07-21 09:34:35.166389	\N
21	824680794	2022	2	344.606898895092	7899.99265818153	500	2	f	2022-07-21 09:34:35.166389	\N
22	839415001	2022	2	993.376187659934	7581.69051338703	500	2	f	2022-07-21 09:34:35.166389	\N
23	861744528	2022	2	15.9516148654661	2217.9646222091	500	2	f	2022-07-21 09:34:35.166389	\N
24	860138909	2022	2	244.44639346186	9085.76070851068	500	2	f	2022-07-21 09:34:35.166389	\N
25	843242104	2022	2	552.309126191346	4314.99816992251	500	2	f	2022-07-21 09:34:35.166389	\N
26	890093850	2022	2	464.739762452266	487.879459604146	500	2	f	2022-07-21 09:34:35.166389	\N
27	892511017	2022	2	212.79962177776	8646.0307860548	500	2	f	2022-07-21 09:34:35.166389	\N
28	842605109	2022	2	454.967962240591	2233.26341550659	500	2	f	2022-07-21 09:34:35.166389	\N
29	870491047	2022	2	440.926745754025	1842.60945669371	500	2	f	2022-07-21 09:34:35.166389	\N
30	863507760	2022	2	365.459919913844	9963.39810111445	500	2	f	2022-07-21 09:34:35.166389	\N
31	817257908	2022	2	298.533491150844	1263.42619385188	500	2	f	2022-07-21 09:34:35.166389	\N
32	809042383	2022	2	461.764281544068	4181.52648199784	500	2	f	2022-07-21 09:34:35.166389	\N
33	810734693	2022	2	303.866445671379	1961.56595367946	500	2	f	2022-07-21 09:34:35.303572	\N
34	804629062	2022	2	988.746518807751	5663.58350261211	500	2	f	2022-07-21 09:34:35.303572	\N
35	873621335	2022	2	303.210268512722	8404.16456282689	500	2	f	2022-07-21 09:34:35.303572	\N
36	835058832	2022	2	708.915818783018	7685.6645328644	500	2	f	2022-07-21 09:34:35.303572	\N
37	803826652	2022	2	742.451977983577	7407.36217075511	500	2	f	2022-07-21 09:34:35.303572	\N
38	874394467	2022	2	952.759123351611	2720.86852227396	500	2	f	2022-07-21 09:34:35.303572	\N
39	838903289	2022	2	788.746705127033	1982.80754561393	500	2	f	2022-07-21 09:34:35.303572	\N
40	882051647	2022	2	960.799594145693	3235.69654351442	500	2	f	2022-07-21 09:34:35.303572	\N
41	879681201	2022	2	35.5210882513399	9190.33568041887	500	2	f	2022-07-21 09:34:35.303572	\N
42	852409131	2022	2	136.232240637976	139.174256718487	500	2	f	2022-07-21 09:34:35.303572	\N
43	808215075	2022	2	888.833971390504	1205.71110455608	500	2	f	2022-07-21 09:34:35.303572	\N
44	865074415	2022	2	437.481076755686	6603.66857392713	500	2	f	2022-07-21 09:34:35.43037	\N
45	836669149	2022	2	511.744841952909	5567.58097930399	500	2	f	2022-07-21 09:34:35.43037	\N
46	884369776	2022	2	787.356435208539	6008.52688839788	500	2	f	2022-07-21 09:34:35.43037	\N
47	873418367	2022	2	480.484422461618	7319.37908978514	500	2	f	2022-07-21 09:34:35.43037	\N
48	802905016	2022	2	274.202515184622	5378.63666537027	500	2	f	2022-07-21 09:34:35.43037	\N
49	885609899	2022	2	366.568318911169	8262.95406204339	500	2	f	2022-07-21 09:34:35.43037	\N
50	860836918	2022	2	620.836760242585	418.926479738967	500	2	f	2022-07-21 09:34:35.43037	\N
51	829745509	2022	2	31.4636555665015	917.024764554256	500	2	f	2022-07-21 09:34:35.43037	\N
52	844246611	2022	2	945.872691765029	7622.28104326998	500	2	f	2022-07-21 09:34:35.43037	\N
53	867216743	2022	2	988.585307627775	9199.45839222905	500	2	f	2022-07-21 09:34:35.43037	\N
54	890941228	2022	2	145.206279393464	6217.25158961129	500	2	f	2022-07-21 09:34:35.43037	\N
55	838540049	2022	2	569.41679119301	1754.70703124417	500	2	f	2022-07-21 09:34:35.43037	\N
56	809501750	2022	2	695.927876379387	5602.1646599366	500	2	f	2022-07-21 09:34:35.43037	\N
57	844496478	2022	2	633.4674310083	3850.79483985675	500	2	f	2022-07-21 09:34:35.43037	\N
58	863501025	2022	2	938.422967249128	1511.49363862383	500	2	f	2022-07-21 09:34:35.43037	\N
59	839166324	2022	2	217.34553258075	1691.02499678979	500	2	f	2022-07-21 09:34:35.43037	\N
60	879962157	2022	2	49.4372570957733	4392.42115147134	500	2	f	2022-07-21 09:34:35.43037	\N
61	848543645	2022	2	680.401197005633	3230.04941806183	500	2	f	2022-07-21 09:34:35.43037	\N
62	880279851	2022	2	648.289119414913	858.751994036728	500	2	f	2022-07-21 09:34:35.532195	\N
63	808671188	2022	2	486.835220381254	8389.1578763444	500	2	f	2022-07-21 09:34:35.532195	\N
64	851333885	2022	2	503.164284269909	8725.05906112026	500	2	f	2022-07-21 09:34:35.532195	\N
65	815366017	2022	2	909.403123483153	8380.44793379408	500	2	f	2022-07-21 09:34:35.532195	\N
66	891113900	2022	2	896.399988653579	84.058947819691	500	2	f	2022-07-21 09:34:35.532195	\N
67	894926128	2022	2	325.123681818016	1674.79627873892	500	2	f	2022-07-21 09:34:35.532195	\N
68	802290404	2022	2	488.645704044351	5499.70604389042	500	2	f	2022-07-21 09:34:35.532195	\N
69	896239097	2022	2	538.277083508224	9564.82823418107	500	2	f	2022-07-21 09:34:35.532195	\N
70	816868949	2022	2	513.011731781051	889.040222026959	500	2	f	2022-07-21 09:34:35.532195	\N
71	895298219	2022	2	816.060005235872	6416.17699831294	500	2	f	2022-07-21 09:34:35.532195	\N
72	842893897	2022	2	995.36131884753	7620.55370301533	500	2	f	2022-07-21 09:34:35.532195	\N
73	814670938	2022	2	773.74066195833	6566.79269650328	500	2	f	2022-07-21 09:34:35.532195	\N
74	820433803	2022	2	726.368094024971	576.938855275797	500	2	f	2022-07-21 09:34:35.611706	\N
75	874104569	2022	2	673.556585163716	9668.07893237195	500	2	f	2022-07-21 09:34:35.611706	\N
76	856520283	2022	2	531.289011038457	6465.04757978349	500	2	f	2022-07-21 09:34:35.611706	\N
77	879090305	2022	2	372.409095046859	1118.58669406759	500	2	f	2022-07-21 09:34:35.611706	\N
78	809468321	2022	2	911.660350355835	3078.66951193507	500	2	f	2022-07-21 09:34:35.611706	\N
79	826378947	2022	2	637.719662321106	7691.33149195019	500	2	f	2022-07-21 09:34:35.611706	\N
80	866390365	2022	2	777.346227844243	5364.63753233104	500	2	f	2022-07-21 09:34:35.611706	\N
81	862771013	2022	2	121.295402683452	8297.99985945775	500	2	f	2022-07-21 09:34:35.611706	\N
82	864363318	2022	2	944.106999406572	7656.86243389046	500	2	f	2022-07-21 09:34:35.611706	\N
83	896438075	2022	2	859.112305360937	1411.93851679326	500	2	f	2022-07-21 09:34:35.611706	\N
84	829368106	2022	2	994.750355701344	3508.95615382312	500	2	f	2022-07-21 09:34:35.611706	\N
85	867407313	2022	2	572.337283075773	5503.57891833357	500	2	f	2022-07-21 09:34:35.611706	\N
86	896587504	2022	2	65.2887415738145	156.618063263784	500	2	f	2022-07-21 09:34:35.611706	\N
87	847845944	2022	2	44.4233055457634	3761.14951857198	500	2	f	2022-07-21 09:34:35.611706	\N
88	826389298	2022	2	358.936054659182	6476.54716093036	500	2	f	2022-07-21 09:34:35.611706	\N
89	848399886	2022	2	395.724258170032	4786.9524389635	500	2	f	2022-07-21 09:34:35.709179	\N
90	854846835	2022	2	254.350275858632	3349.19278180025	500	2	f	2022-07-21 09:34:35.709179	\N
91	800634899	2022	2	954.75527333948	4251.4992557119	500	2	f	2022-07-21 09:34:35.709179	\N
92	857110616	2022	2	405.323668305223	139.4377548908	500	2	f	2022-07-21 09:34:35.709179	\N
93	808271586	2022	2	788.879339925182	5145.86721925101	500	2	f	2022-07-21 09:34:35.709179	\N
94	819801010	2022	2	72.9308536471555	2954.2443537871	500	2	f	2022-07-21 09:34:35.709179	\N
95	848578637	2022	2	431.729116824605	8685.5462527219	500	2	f	2022-07-21 09:34:35.709179	\N
96	827490752	2022	2	924.732922372098	6569.58048071168	500	2	f	2022-07-21 09:34:35.752865	\N
97	835736810	2022	2	135.859761774296	6287.89422910821	500	2	f	2022-07-21 09:34:35.752865	\N
98	857544475	2022	2	318.2502042475	3811.00654849809	500	2	f	2022-07-21 09:34:35.752865	\N
99	847721823	2022	2	273.649995123057	9423.50821844045	500	2	f	2022-07-21 09:34:35.752865	\N
100	862581603	2022	2	636.417213242883	2496.34184563403	500	2	f	2022-07-21 09:34:35.752865	\N
101	810313500	2022	2	842.983962318569	2873.01621176363	500	2	f	2022-07-21 09:34:35.752865	\N
102	885129733	2022	2	158.765225739314	3085.52776976449	500	2	f	2022-07-21 09:34:35.752865	\N
103	898243796	2022	2	442.541681276428	6316.14413118507	500	2	f	2022-07-21 09:34:35.752865	\N
104	887079787	2022	2	915.114567837694	5822.42230591363	500	2	f	2022-07-21 09:34:35.752865	\N
105	861058672	2022	2	266.936805340162	6876.06708988657	500	2	f	2022-07-21 09:34:35.752865	\N
106	876537913	2022	2	401.418437408359	5065.08481056786	500	2	f	2022-07-21 09:34:35.752865	\N
107	890597928	2022	2	311.620409626727	7220.01509277742	500	2	f	2022-07-21 09:34:35.752865	\N
108	842982051	2022	2	121.267448575915	8544.41204806988	500	2	f	2022-07-21 09:34:35.752865	\N
109	842389667	2022	2	188.976904306229	2218.65749763696	500	2	f	2022-07-21 09:34:35.752865	\N
110	820004072	2022	2	426.792060906631	9519.87951447846	500	2	f	2022-07-21 09:34:35.831632	\N
111	897688257	2022	2	866.824618085766	8840.97248721585	500	2	f	2022-07-21 09:34:35.831632	\N
112	837534390	2022	2	293.581575682826	1384.89094200026	500	2	f	2022-07-21 09:34:35.831632	\N
113	808543637	2022	2	399.790701308322	1638.93384365625	500	2	f	2022-07-21 09:34:35.831632	\N
114	870201888	2022	2	120.928880277056	1040.67214502678	500	2	f	2022-07-21 09:34:35.887995	\N
115	817311070	2022	2	784.212118275158	3166.80257605319	500	2	f	2022-07-21 09:34:35.887995	\N
116	868012776	2022	2	591.856763974027	6296.10229479368	500	2	f	2022-07-21 09:34:35.887995	\N
117	896429753	2022	2	35.2800314582509	3113.92542873631	500	2	f	2022-07-21 09:34:35.887995	\N
118	851603425	2022	2	401.291326134366	4389.77778256426	500	2	f	2022-07-21 09:34:35.887995	\N
119	827443317	2022	2	938.634115361109	5096.42543921311	500	2	f	2022-07-21 09:34:35.887995	\N
120	833362642	2022	2	522.563314575093	6028.56286251497	500	2	f	2022-07-21 09:34:35.937595	\N
121	882069408	2022	2	134.51226819698	444.098049487299	500	2	f	2022-07-21 09:34:35.937595	\N
122	863878944	2022	2	720.935314818698	7389.54506592993	500	2	f	2022-07-21 09:34:35.937595	\N
123	866558221	2022	2	600.977082375273	3851.51750894749	500	2	f	2022-07-21 09:34:35.937595	\N
124	868767855	2022	2	215.237451121335	5123.28114363613	500	2	f	2022-07-21 09:34:35.980044	\N
125	875885300	2022	2	623.509994871574	4233.78952390522	500	2	f	2022-07-21 09:34:35.980044	\N
126	842216735	2022	2	754.55423518133	9432.37762206277	500	2	f	2022-07-21 09:34:35.980044	\N
127	856920437	2022	2	46.5898264296705	5786.32957671859	500	2	f	2022-07-21 09:34:35.980044	\N
128	830858963	2022	2	186.485026279685	6378.17164830301	500	2	f	2022-07-21 09:34:35.980044	\N
129	812434114	2022	2	951.060115282409	6001.65427095902	500	2	f	2022-07-21 09:34:36.026482	\N
130	847041353	2022	2	790.278412001515	9409.78129982461	500	2	f	2022-07-21 09:34:36.026482	\N
131	803269327	2022	2	939.716565320932	2861.73606192059	500	2	f	2022-07-21 09:34:36.026482	\N
132	843457384	2022	2	901.417773335291	9887.12541887315	500	2	f	2022-07-21 09:34:36.026482	\N
133	818306281	2022	2	506.977007236613	3498.50853912717	500	2	f	2022-07-21 09:34:36.085339	\N
134	844449510	2022	2	757.609638703255	2959.33120425108	500	2	f	2022-07-21 09:34:36.085339	\N
135	867177223	2022	2	777.021692707776	1178.62068206357	500	2	f	2022-07-21 09:34:36.085339	\N
136	883963814	2022	2	701.944399420266	3651.49633266956	500	2	f	2022-07-21 09:34:36.085339	\N
137	886253015	2022	2	569.486197285582	8983.31805832022	500	2	f	2022-07-21 09:34:36.13995	\N
138	895281822	2022	2	981.459440630317	9783.7937642635	500	2	f	2022-07-21 09:34:36.13995	\N
139	840533481	2022	2	382.599372208984	7425.56496669002	500	2	f	2022-07-21 09:34:36.13995	\N
140	839216776	2022	2	830.99202859133	7930.03144429228	500	2	f	2022-07-21 09:34:36.13995	\N
141	803533948	2022	2	353.66394410952	5977.93412114791	500	2	f	2022-07-21 09:34:36.175052	\N
142	827095124	2022	2	66.0768602534742	9265.30696590386	500	2	f	2022-07-21 09:34:36.175052	\N
143	808251981	2022	2	929.694378176954	1635.43944653899	500	2	f	2022-07-21 09:34:36.198414	\N
144	817358823	2022	2	789.439537449284	1381.5430927592	500	2	f	2022-07-21 09:34:36.224836	\N
145	871910327	2022	2	673.950806757025	7224.48354919773	500	2	f	2022-07-21 09:34:36.224836	\N
146	866587133	2022	2	699.119515311206	4978.81877546973	500	2	f	2022-07-21 09:34:36.266879	\N
147	842840788	2022	2	619.056607143042	3833.00848975199	500	2	f	2022-07-21 09:34:36.266879	\N
148	812781923	2022	2	579.762417387222	5013.78051247033	500	2	f	2022-07-21 09:34:36.349754	\N
149	804058381	2022	2	92.2380905049203	8445.8091715042	500	2	f	2022-07-21 09:34:36.349754	\N
150	811423248	2022	2	818.846757486616	5599.21021112525	500	2	f	2022-07-21 09:34:36.349754	\N
151	840837641	2022	2	659.763484121703	3195.91020053335	500	2	f	2022-07-21 09:34:36.349754	\N
152	818816392	2022	2	331.004288116774	8747.85266472641	500	2	f	2022-07-21 09:34:36.349754	\N
153	806494928	2022	2	874.664520386286	6727.48595433409	500	2	f	2022-07-21 09:34:36.415375	\N
154	893055618	2022	2	914.718067199352	1688.28925252185	500	2	f	2022-07-21 09:34:36.415375	\N
155	875340822	2022	2	943.649082941957	419.586038175073	500	2	f	2022-07-21 09:34:36.415375	\N
156	818463756	2022	2	447.921851315653	8425.421332387	500	2	f	2022-07-21 09:34:36.415375	\N
157	884152302	2022	2	551.108118290216	1346.38663278093	500	2	f	2022-07-21 09:34:36.415375	\N
158	849742742	2022	2	806.972512419044	5223.98842389445	500	2	f	2022-07-21 09:34:36.47184	\N
159	804979817	2022	2	796.569574218743	7678.38716614715	500	2	f	2022-07-21 09:34:36.47184	\N
160	814190896	2022	2	669.393525335499	4497.62539406682	500	2	f	2022-07-21 09:34:36.47184	\N
161	822331640	2022	2	166.093025232523	6202.79497301082	500	2	f	2022-07-21 09:34:36.47184	\N
162	862678317	2022	2	214.366453178853	1328.97302143629	500	2	f	2022-07-21 09:34:36.47184	\N
163	831093023	2022	2	511.136914756899	5562.01840137709	500	2	f	2022-07-21 09:34:36.553889	\N
164	874226454	2022	2	883.190371831164	7318.08420398198	500	2	f	2022-07-21 09:34:36.553889	\N
165	832436811	2022	2	33.6219988488991	5405.63848608059	500	2	f	2022-07-21 09:34:36.553889	\N
166	838432048	2022	2	210.260470822099	9682.67131810337	500	2	f	2022-07-21 09:34:36.553889	\N
167	870022919	2022	2	486.777879937225	3636.86661633446	500	2	f	2022-07-21 09:34:36.553889	\N
168	879268334	2022	2	621.817794629527	2728.09220435192	500	2	f	2022-07-21 09:34:36.620902	\N
169	806599852	2022	2	852.817289338379	1217.0956562751	500	2	f	2022-07-21 09:34:36.620902	\N
170	863181199	2022	2	562.137419211228	1312.14799891588	500	2	f	2022-07-21 09:34:36.620902	\N
171	863767568	2022	2	779.684763859864	4924.74185283426	500	2	f	2022-07-21 09:34:36.620902	\N
172	844014636	2022	2	34.5941666837808	3448.75025531171	500	2	f	2022-07-21 09:34:36.674854	\N
173	866404710	2022	2	346.822782905708	9630.22767286669	500	2	f	2022-07-21 09:34:36.674854	\N
174	833129946	2022	2	873.355460604531	7416.41476881926	500	2	f	2022-07-21 09:34:36.674854	\N
175	846977998	2022	2	281.209305584622	4164.38653086249	500	2	f	2022-07-21 09:34:36.674854	\N
176	811030348	2022	2	267.935172704979	6603.64091420211	500	2	f	2022-07-21 09:34:36.674854	\N
177	890815907	2022	2	884.167363233126	4959.30483927362	500	2	f	2022-07-21 09:34:36.674854	\N
178	822694021	2022	2	32.6499041161777	5582.95410284959	500	2	f	2022-07-21 09:34:36.719608	\N
179	852558904	2022	2	396.48101338931	680.325465302828	500	2	f	2022-07-21 09:34:36.719608	\N
180	822874914	2022	2	948.517377649223	5598.64767176605	500	2	f	2022-07-21 09:34:36.719608	\N
181	866646453	2022	2	607.528306022311	6977.99039145702	500	2	f	2022-07-21 09:34:36.719608	\N
182	881021956	2022	2	216.704758584235	506.995336326532	500	2	f	2022-07-21 09:34:36.766241	\N
183	899291735	2022	2	658.698942445937	8429.96504216932	500	2	f	2022-07-21 09:34:36.766241	\N
184	867918928	2022	2	171.133607816872	8944.17413248591	500	2	f	2022-07-21 09:34:36.766241	\N
185	823439458	2022	2	456.939351745739	7538.17526589978	500	2	f	2022-07-21 09:34:36.766241	\N
186	837805347	2022	2	985.180537639554	2905.88764686462	500	2	f	2022-07-21 09:34:36.766241	\N
187	805499088	2022	2	237.190755728262	5761.91224624497	500	2	f	2022-07-21 09:34:36.766241	\N
188	845822610	2022	2	979.3336250299	1831.55121529051	500	2	f	2022-07-21 09:34:36.820576	\N
189	841405633	2022	2	362.675339719063	520.255814277746	500	2	f	2022-07-21 09:34:36.820576	\N
190	889675608	2022	2	156.256816528079	1409.29369533667	500	2	f	2022-07-21 09:34:36.820576	\N
191	899025387	2022	2	247.409830823421	1135.89904825064	500	2	f	2022-07-21 09:34:36.820576	\N
192	863280835	2022	2	618.489456434318	6921.53029030251	500	2	f	2022-07-21 09:34:36.862179	\N
193	860629673	2022	2	980.457224646755	6511.6721726747	500	2	f	2022-07-21 09:34:36.862179	\N
194	833667497	2022	2	310.553191267205	716.506658797812	500	2	f	2022-07-21 09:34:36.862179	\N
195	842471044	2022	2	340.600068092675	7187.38343333968	500	2	f	2022-07-21 09:34:36.862179	\N
196	861459803	2022	2	269.524676490179	4785.57686079666	500	2	f	2022-07-21 09:34:36.900809	\N
197	812926032	2022	2	255.83855516382	1456.50033697707	500	2	f	2022-07-21 09:34:36.900809	\N
198	871631319	2022	2	191.280232626934	7362.07470221911	500	2	f	2022-07-21 09:34:36.900809	\N
199	865439281	2022	2	37.6169596996972	5719.43600496902	500	2	f	2022-07-21 09:34:36.951097	\N
200	824210548	2022	2	553.38955212117	3420.55079441518	500	2	f	2022-07-21 09:34:36.951097	\N
201	805486005	2022	2	874.279128266426	9910.88375082115	500	2	f	2022-07-21 09:34:36.951097	\N
202	832448472	2022	2	837.146162920717	9125.69949617879	500	2	f	2022-07-21 09:34:36.951097	\N
203	805820685	2022	2	300.256050981147	3669.09103263077	500	2	f	2022-07-21 09:34:36.990931	\N
204	883768894	2022	2	641.096850430859	2564.50214775952	500	2	f	2022-07-21 09:34:36.990931	\N
205	856903021	2022	2	869.905955609938	3184.41840719034	500	2	f	2022-07-21 09:34:36.990931	\N
206	850012745	2022	2	808.213314745129	7281.22104697709	500	2	f	2022-07-21 09:34:36.990931	\N
207	820149848	2022	2	875.095063512034	5452.22469541619	500	2	f	2022-07-21 09:34:37.033151	\N
208	822705108	2022	2	959.1341059847	5515.96973716914	500	2	f	2022-07-21 09:34:37.033151	\N
209	857573851	2022	2	547.107373134564	121.205166930867	500	2	f	2022-07-21 09:34:37.074545	\N
210	856078198	2022	2	732.201318650176	8313.1812342132	500	2	f	2022-07-21 09:34:37.074545	\N
211	859225721	2022	2	759.446513601743	9809.18235887793	500	2	f	2022-07-21 09:34:37.074545	\N
212	873879874	2022	2	286.446641936829	8775.44658188025	500	2	f	2022-07-21 09:34:37.119498	\N
213	890065285	2022	2	512.705701292766	179.906991133402	500	2	f	2022-07-21 09:34:37.119498	\N
214	893423280	2022	2	662.30443077795	2500.62150577855	500	2	f	2022-07-21 09:34:37.119498	\N
215	816273126	2022	2	841.705926280187	8217.04591633736	500	2	f	2022-07-21 09:34:37.190544	\N
216	874977909	2022	2	206.776942912069	2179.72994166492	500	2	f	2022-07-21 09:34:37.190544	\N
217	888632161	2022	2	275.343661790472	9298.04240783037	500	2	f	2022-07-21 09:34:37.190544	\N
218	852452427	2022	2	439.842819742421	3549.99655796368	500	2	f	2022-07-21 09:34:37.224691	\N
219	807389236	2022	2	658.012048488526	7575.85488830417	500	2	f	2022-07-21 09:34:37.224691	\N
220	833163111	2022	2	676.672954635076	5731.28195347379	500	2	f	2022-07-21 09:34:37.224691	\N
221	813080832	2022	2	616.407653807416	2581.80920119117	500	2	f	2022-07-21 09:34:37.224691	\N
222	896489260	2022	2	44.6945391307249	7458.11522077407	500	2	f	2022-07-21 09:34:37.286057	\N
223	845881839	2022	2	168.966603481244	8750.63954377024	500	2	f	2022-07-21 09:34:37.286057	\N
224	898157169	2022	2	750.338042914692	5819.64364438911	500	2	f	2022-07-21 09:34:37.286057	\N
225	882940656	2022	2	188.907159653024	4744.18741538724	500	2	f	2022-07-21 09:34:37.286057	\N
226	887589106	2022	2	196.727938270079	6789.63782095629	500	2	f	2022-07-21 09:34:37.286057	\N
227	856439808	2022	2	367.416478453113	2933.14447678692	500	2	f	2022-07-21 09:34:37.346377	\N
228	869911712	2022	2	586.872844479969	2042.81782562846	500	2	f	2022-07-21 09:34:37.346377	\N
229	836420677	2022	2	435.667006376882	6263.08128215317	500	2	f	2022-07-21 09:34:37.346377	\N
230	810521018	2022	2	505.773999583889	7812.18240196245	500	2	f	2022-07-21 09:34:37.346377	\N
231	863021621	2022	2	566.888575310014	5514.14073586185	500	2	f	2022-07-21 09:34:37.346377	\N
232	846289494	2022	2	404.423883495063	4303.78187390045	500	2	f	2022-07-21 09:34:37.423306	\N
233	834191416	2022	2	788.033180345118	9432.13245930421	500	2	f	2022-07-21 09:34:37.423306	\N
234	837420340	2022	2	24.9741383230504	6354.63898211476	500	2	f	2022-07-21 09:34:37.423306	\N
235	871949311	2022	2	477.142814544098	7901.94199396266	500	2	f	2022-07-21 09:34:37.423306	\N
236	821633142	2022	2	898.202117695278	4095.49963521324	500	2	f	2022-07-21 09:34:37.423306	\N
237	893463166	2022	2	293.852674980704	4314.15203195751	500	2	f	2022-07-21 09:34:37.474542	\N
238	833218825	2022	2	376.550944030539	4587.33149005474	500	2	f	2022-07-21 09:34:37.474542	\N
239	807456455	2022	2	424.598016412333	8655.94168061836	500	2	f	2022-07-21 09:34:37.474542	\N
240	821381486	2022	2	135.634371909634	3026.97369823986	500	2	f	2022-07-21 09:34:37.474542	\N
241	814324199	2022	2	157.845654170167	2616.81582251184	500	2	f	2022-07-21 09:34:37.474542	\N
242	805904949	2022	2	500.129187454129	7610.37167254097	500	2	f	2022-07-21 09:34:37.474542	\N
243	813242515	2022	2	586.473948279747	3037.85328016185	500	2	f	2022-07-21 09:34:37.474542	\N
244	839415843	2022	2	264.299321897932	4700.79888731034	500	2	f	2022-07-21 09:34:37.517838	\N
245	804234371	2022	2	187.789613809136	5683.93179111537	500	2	f	2022-07-21 09:34:37.517838	\N
246	816585946	2022	2	681.734578632809	9794.89190540037	500	2	f	2022-07-21 09:34:37.517838	\N
247	824097835	2022	2	382.016711771968	2134.4811290076	500	2	f	2022-07-21 09:34:37.517838	\N
248	880538674	2022	2	353.881293823813	2664.10465526699	500	2	f	2022-07-21 09:34:37.517838	\N
249	875775705	2022	2	483.247151909113	8054.70630662476	500	2	f	2022-07-21 09:34:37.517838	\N
250	877421692	2022	2	265.518400660286	5177.44453372732	500	2	f	2022-07-21 09:34:37.517838	\N
251	871547736	2022	2	944.726453184499	6479.30616969682	500	2	f	2022-07-21 09:34:37.561492	\N
252	857653378	2022	2	832.330852324355	1643.97007310643	500	2	f	2022-07-21 09:34:37.561492	\N
253	829980700	2022	2	836.096897933594	7698.02871119499	500	2	f	2022-07-21 09:34:37.561492	\N
254	852627790	2022	2	755.728924908733	7224.93592335554	500	2	f	2022-07-21 09:34:37.561492	\N
255	865978526	2022	2	770.661116848114	7624.31313037174	500	2	f	2022-07-21 09:34:37.561492	\N
256	840145629	2022	2	184.192049448211	8808.86695928459	500	2	f	2022-07-21 09:34:37.596777	\N
257	875016141	2022	2	21.0055883161085	3874.70462934898	500	2	f	2022-07-21 09:34:37.596777	\N
258	869419134	2022	2	413.742071959361	4978.78355923186	500	2	f	2022-07-21 09:34:37.596777	\N
259	813944600	2022	2	81.0197232777251	2261.3511875744	500	2	f	2022-07-21 09:34:37.596777	\N
260	885600454	2022	2	55.0332272379929	2681.16276123576	500	2	f	2022-07-21 09:34:37.647623	\N
261	877550656	2022	2	977.956604860146	3375.2825399222	500	2	f	2022-07-21 09:34:37.647623	\N
262	804227830	2022	2	724.045648103324	3896.91919405862	500	2	f	2022-07-21 09:34:37.695993	\N
263	858956619	2022	2	297.201445764313	5431.14218698847	500	2	f	2022-07-21 09:34:37.695993	\N
264	865153645	2022	2	855.450432312511	4215.53924491571	500	2	f	2022-07-21 09:34:37.695993	\N
265	817941723	2022	2	528.624233426673	1874.26062482618	500	2	f	2022-07-21 09:34:37.717062	\N
266	811667993	2022	2	270.910218830752	4485.82130926774	500	2	f	2022-07-21 09:34:37.717062	\N
267	859462534	2022	2	536.030397392295	2708.8990309924	500	2	f	2022-07-21 09:34:37.717062	\N
268	822317092	2022	2	407.137557716086	900.834598776788	500	2	f	2022-07-21 09:34:37.717062	\N
269	877772835	2022	2	589.251451086951	2553.06149269119	500	2	f	2022-07-21 09:34:37.760161	\N
270	846495295	2022	2	469.566159844139	5310.94406788496	500	2	f	2022-07-21 09:34:37.760161	\N
271	804775869	2022	2	760.376574145467	4494.6849529312	500	2	f	2022-07-21 09:34:37.796164	\N
272	831030012	2022	2	446.099301224871	9084.87747758328	500	2	f	2022-07-21 09:34:37.796164	\N
273	802809462	2022	2	419.441822912056	9440.2933901473	500	2	f	2022-07-21 09:34:37.796164	\N
274	896200151	2022	2	833.882778666927	9914.57328393099	500	2	f	2022-07-21 09:34:37.796164	\N
275	873610100	2022	2	479.739338995491	1041.09925867228	500	2	f	2022-07-21 09:34:37.796164	\N
276	847931581	2022	2	871.777484463343	1485.41063268268	500	2	f	2022-07-21 09:34:37.837755	\N
277	870810427	2022	2	271.129030654183	6268.44668635248	500	2	f	2022-07-21 09:34:37.837755	\N
278	816457914	2022	2	475.301122880699	5957.2296999891	500	2	f	2022-07-21 09:34:37.897061	\N
279	816760477	2022	2	112.426094734306	8143.24255651767	500	2	f	2022-07-21 09:34:37.897061	\N
280	821449527	2022	2	842.670995798795	5427.0280928649	500	2	f	2022-07-21 09:34:37.897061	\N
281	897412997	2022	2	276.670295520641	5902.82361953042	500	2	f	2022-07-21 09:34:37.897061	\N
282	801856356	2022	2	922.523424695769	3713.2188998965	500	2	f	2022-07-21 09:34:37.950872	\N
283	898170941	2022	2	700.388184560723	6722.20768284297	500	2	f	2022-07-21 09:34:37.950872	\N
284	884390144	2022	2	142.002429529047	1059.26626147262	500	2	f	2022-07-21 09:34:37.950872	\N
285	894424841	2022	2	846.927990468132	1477.44322199297	500	2	f	2022-07-21 09:34:37.950872	\N
286	828972512	2022	2	872.169758494922	6067.45784903016	500	2	f	2022-07-21 09:34:37.950872	\N
287	815082581	2022	2	159.083105878328	5719.75479769876	500	2	f	2022-07-21 09:34:37.987347	\N
288	887159012	2022	2	885.244893979287	3032.32712961459	500	2	f	2022-07-21 09:34:37.987347	\N
289	829493874	2022	2	454.103157129607	7713.2374037865	500	2	f	2022-07-21 09:34:37.987347	\N
290	814929193	2022	2	425.196149990358	1292.27295478425	500	2	f	2022-07-21 09:34:37.987347	\N
291	859907302	2022	2	758.924596888899	2445.31217287798	500	2	f	2022-07-21 09:34:37.987347	\N
292	895124699	2022	2	269.09147906912	9008.83769684412	500	2	f	2022-07-21 09:34:37.987347	\N
293	813239227	2022	2	404.88418857226	5301.92886277326	500	2	f	2022-07-21 09:34:38.051668	\N
294	840430296	2022	2	202.281070495236	808.063410290548	500	2	f	2022-07-21 09:34:38.051668	\N
295	858726639	2022	2	731.072556349967	304.051503334614	500	2	f	2022-07-21 09:34:38.051668	\N
296	823234800	2022	2	91.4521760680814	5092.1849707694	500	2	f	2022-07-21 09:34:38.080469	\N
297	874361830	2022	2	473.820697175486	4130.99248521472	500	2	f	2022-07-21 09:34:38.080469	\N
298	808481735	2022	2	179.604985208936	3376.86752448917	500	2	f	2022-07-21 09:34:38.080469	\N
299	860499175	2022	2	937.920862016746	132.157715962116	500	2	f	2022-07-21 09:34:38.080469	\N
300	892697142	2022	2	123.213860429893	4217.2673134159	500	2	f	2022-07-21 09:34:38.080469	\N
301	826727890	2022	2	54.4582890786843	6125.04091793883	500	2	f	2022-07-21 09:34:38.080469	\N
302	895582762	2022	2	646.293294543575	7746.09710416491	500	2	f	2022-07-21 09:34:38.161659	\N
303	814663914	2022	2	560.795044270628	1636.23836393585	500	2	f	2022-07-21 09:34:38.161659	\N
304	887191975	2022	2	895.338076384798	9043.4080264656	500	2	f	2022-07-21 09:34:38.161659	\N
305	856729012	2022	2	203.980559311655	8001.24386422923	500	2	f	2022-07-21 09:34:38.161659	\N
306	816248533	2022	2	470.234973634566	2603.76300162421	500	2	f	2022-07-21 09:34:38.161659	\N
307	847253663	2022	2	999.809177427642	5685.62148281799	500	2	f	2022-07-21 09:34:38.161659	\N
308	851556995	2022	2	852.864404087087	6020.82733123631	500	2	f	2022-07-21 09:34:38.161659	\N
309	897000352	2022	2	74.1048832834302	9735.60596417226	500	2	f	2022-07-21 09:34:38.213963	\N
310	891267708	2022	2	682.90107233668	1115.39684457577	500	2	f	2022-07-21 09:34:38.213963	\N
311	868369009	2022	2	793.994833842884	4973.90174669063	500	2	f	2022-07-21 09:34:38.213963	\N
312	836786224	2022	2	951.015678704714	780.041865842986	500	2	f	2022-07-21 09:34:38.213963	\N
313	800910790	2022	2	714.646048074522	3063.95551038996	500	2	f	2022-07-21 09:34:38.213963	\N
314	847922087	2022	2	145.595729503245	6436.32246470667	500	2	f	2022-07-21 09:34:38.258718	\N
315	882737279	2022	2	57.5754321128051	2962.24977828468	500	2	f	2022-07-21 09:34:38.258718	\N
316	817612413	2022	2	632.341196879925	3156.68281003515	500	2	f	2022-07-21 09:34:38.258718	\N
317	857680168	2022	2	789.14332900598	4720.39675732747	500	2	f	2022-07-21 09:34:38.258718	\N
318	878624841	2022	2	270.653823597843	7279.06289812757	500	2	f	2022-07-21 09:34:38.258718	\N
319	867183919	2022	2	198.994576567111	8340.76992466879	500	2	f	2022-07-21 09:34:38.258718	\N
320	824306551	2022	2	414.038610869805	2576.49555265808	500	2	f	2022-07-21 09:34:38.307579	\N
321	812929350	2022	2	448.316489311176	9906.93338177002	500	2	f	2022-07-21 09:34:38.307579	\N
322	890735735	2022	2	983.930675393565	4329.85318089925	500	2	f	2022-07-21 09:34:38.307579	\N
323	894341616	2022	2	855.000293241167	5658.34012351601	500	2	f	2022-07-21 09:34:38.307579	\N
324	845690609	2022	2	752.360645159608	5649.62726387328	500	2	f	2022-07-21 09:34:38.307579	\N
325	884945724	2022	2	247.263875059242	6511.22091965235	500	2	f	2022-07-21 09:34:38.307579	\N
326	820865124	2022	2	285.607872200689	6450.5438431699	500	2	f	2022-07-21 09:34:38.358452	\N
327	870514368	2022	2	837.156427176566	8151.25246700203	500	2	f	2022-07-21 09:34:38.358452	\N
328	833643869	2022	2	147.617533482812	9074.22856413679	500	2	f	2022-07-21 09:34:38.358452	\N
329	807702188	2022	2	20.1283681605654	1814.95377263574	500	2	f	2022-07-21 09:34:38.358452	\N
330	820638689	2022	2	484.68395726084	1888.71078825405	500	2	f	2022-07-21 09:34:38.358452	\N
331	843380901	2022	2	110.264628056184	448.61285286121	500	2	f	2022-07-21 09:34:38.358452	\N
332	832951634	2022	2	597.753554194827	538.614789778747	500	2	f	2022-07-21 09:34:38.42665	\N
333	833677243	2022	2	258.740288830025	5798.64626117565	500	2	f	2022-07-21 09:34:38.42665	\N
334	873656323	2022	2	405.307386258167	8653.98479751281	500	2	f	2022-07-21 09:34:38.42665	\N
335	859159231	2022	2	222.659915256296	5884.75990988777	500	2	f	2022-07-21 09:34:38.42665	\N
336	868067017	2022	2	840.340445988303	563.70311570864	500	2	f	2022-07-21 09:34:38.42665	\N
337	856435712	2022	2	852.357699994994	4587.39033813701	500	2	f	2022-07-21 09:34:38.42665	\N
338	888937591	2022	2	100.406302029052	8864.73138005257	500	2	f	2022-07-21 09:34:38.484695	\N
339	873906284	2022	2	188.878479001461	480.743222536627	500	2	f	2022-07-21 09:34:38.484695	\N
340	855150484	2022	2	243.935362472693	3645.9750321525	500	2	f	2022-07-21 09:34:38.484695	\N
341	836365546	2022	2	356.038172898282	9923.10313475313	500	2	f	2022-07-21 09:34:38.484695	\N
342	822564929	2022	2	790.196068004422	3445.87988968247	500	2	f	2022-07-21 09:34:38.484695	\N
343	833204596	2022	2	739.473413294432	9549.40820747973	500	2	f	2022-07-21 09:34:38.484695	\N
344	863592645	2022	2	112.980443053603	206.605783303243	500	2	f	2022-07-21 09:34:38.484695	\N
345	865956727	2022	2	134.773299665285	7236.97045404923	500	2	f	2022-07-21 09:34:38.530207	\N
346	807629933	2022	2	162.033200608958	7935.27041759325	500	2	f	2022-07-21 09:34:38.530207	\N
347	832454631	2022	2	545.28401060643	4351.03559373878	500	2	f	2022-07-21 09:34:38.530207	\N
348	823356725	2022	2	23.2465729814093	7914.33001817117	500	2	f	2022-07-21 09:34:38.530207	\N
349	800824855	2022	2	818.707844574012	2130.69619669361	500	2	f	2022-07-21 09:34:38.530207	\N
350	894510083	2022	2	779.789259107147	6584.47767972265	500	2	f	2022-07-21 09:34:38.530207	\N
351	815854671	2022	2	361.447523842329	6733.33936284767	500	2	f	2022-07-21 09:34:38.530207	\N
352	876401827	2022	2	779.207872933325	9804.27681237495	500	2	f	2022-07-21 09:34:38.530207	\N
353	845066027	2022	2	193.445524540123	3404.60073526042	500	2	f	2022-07-21 09:34:38.598757	\N
354	815406101	2022	2	884.928260670344	14.0356551129684	500	2	f	2022-07-21 09:34:38.598757	\N
355	866878310	2022	2	30.5437234034441	7798.11757972559	500	2	f	2022-07-21 09:34:38.598757	\N
356	830803739	2022	2	554.012317931953	6841.31948653347	500	2	f	2022-07-21 09:34:38.598757	\N
357	805933483	2022	2	770.311380145337	2826.35771958321	500	2	f	2022-07-21 09:34:38.598757	\N
358	868252144	2022	2	774.765142168312	3821.07435212676	500	2	f	2022-07-21 09:34:38.598757	\N
359	828744326	2022	2	760.648842927668	6058.62564954056	500	2	f	2022-07-21 09:34:38.598757	\N
360	830122600	2022	2	382.350890151093	6106.56824434076	500	2	f	2022-07-21 09:34:38.598757	\N
361	813147327	2022	2	126.518746781765	111.962841975821	500	2	f	2022-07-21 09:34:38.598757	\N
362	846250295	2022	2	640.282213951674	2013.97847568583	500	2	f	2022-07-21 09:34:38.636268	\N
363	898250721	2022	2	188.252185856981	8012.06156205488	500	2	f	2022-07-21 09:34:38.636268	\N
364	813697349	2022	2	586.262913369509	460.756148120602	500	2	f	2022-07-21 09:34:38.636268	\N
365	863104800	2022	2	543.757608822875	1645.63404776897	500	2	f	2022-07-21 09:34:38.636268	\N
366	897979593	2022	2	295.236515037468	3126.20780154051	500	2	f	2022-07-21 09:34:38.636268	\N
367	860772161	2022	2	768.625379306427	6318.69984857422	500	2	f	2022-07-21 09:34:38.636268	\N
368	808002552	2022	2	698.674717056874	8206.01900640081	500	2	f	2022-07-21 09:34:38.683693	\N
369	876394411	2022	2	663.472126645556	574.272769646703	500	2	f	2022-07-21 09:34:38.683693	\N
370	846214156	2022	2	179.910161424686	6064.83777326532	500	2	f	2022-07-21 09:34:38.683693	\N
371	850015354	2022	2	248.351041382701	7978.06440683666	500	2	f	2022-07-21 09:34:38.683693	\N
372	805145991	2022	2	404.095402265695	3855.61760955564	500	2	f	2022-07-21 09:34:38.683693	\N
373	853879838	2022	2	791.187222095462	7615.05660146032	500	2	f	2022-07-21 09:34:38.729338	\N
374	882939801	2022	2	684.285804728429	8092.62492733356	500	2	f	2022-07-21 09:34:38.729338	\N
375	859605190	2022	2	151.08015150104	6044.88563049941	500	2	f	2022-07-21 09:34:38.729338	\N
376	891814367	2022	2	193.460917564051	3142.51732980907	500	2	f	2022-07-21 09:34:38.729338	\N
377	875021136	2022	2	267.914456727349	697.570102918108	500	2	f	2022-07-21 09:34:38.786197	\N
378	825379831	2022	2	977.402630880062	5924.71158316206	500	2	f	2022-07-21 09:34:38.786197	\N
379	800469195	2022	2	654.471532515168	8186.42471206261	500	2	f	2022-07-21 09:34:38.786197	\N
380	871244244	2022	2	181.36919031248	4313.43611612456	500	2	f	2022-07-21 09:34:38.786197	\N
381	837133219	2022	2	595.396731031029	20.6532737864441	500	2	f	2022-07-21 09:34:38.829568	\N
382	855964219	2022	2	233.884522549454	1564.63994121286	500	2	f	2022-07-21 09:34:38.829568	\N
383	838273484	2022	2	985.64461762786	7103.04178373713	500	2	f	2022-07-21 09:34:38.829568	\N
384	893483616	2022	2	375.993095266305	139.839245312905	500	2	f	2022-07-21 09:34:38.829568	\N
385	891497759	2022	2	877.980912451918	8307.14430177338	500	2	f	2022-07-21 09:34:38.854198	\N
386	888247901	2022	2	353.753062926183	7008.90627731382	500	2	f	2022-07-21 09:34:38.854198	\N
387	883590490	2022	2	562.745381806684	9656.56509348057	500	2	f	2022-07-21 09:34:38.854198	\N
388	804908767	2022	2	697.775116222129	4337.18610789872	500	2	f	2022-07-21 09:34:38.854198	\N
389	851919134	2022	2	887.65043401944	5428.88197112942	500	2	f	2022-07-21 09:34:38.854198	\N
390	813682750	2022	2	770.986752149945	1129.6693831941	500	2	f	2022-07-21 09:34:38.893436	\N
391	875544956	2022	2	498.488828846323	1917.17244720088	500	2	f	2022-07-21 09:34:38.919263	\N
392	889472231	2022	2	589.154978593855	9611.60871237288	500	2	f	2022-07-21 09:34:38.919263	\N
393	875631634	2022	2	199.667840821226	2656.988062255	500	2	f	2022-07-21 09:34:38.919263	\N
394	856007783	2022	2	674.201597199698	8941.72984089432	500	2	f	2022-07-21 09:34:38.919263	\N
395	844760467	2022	2	606.222835920933	2010.25592242079	500	2	f	2022-07-21 09:34:38.919263	\N
396	863256691	2022	2	178.710675318434	2315.74938573859	500	2	f	2022-07-21 09:34:38.944189	\N
397	851705582	2022	2	409.674909317041	8528.13089165651	500	2	f	2022-07-21 09:34:38.944189	\N
398	854298834	2022	2	70.4056676738586	5707.02201475009	500	2	f	2022-07-21 09:34:38.944189	\N
399	836216435	2022	2	931.625243044454	4149.00810136424	500	2	f	2022-07-21 09:34:38.944189	\N
400	893017297	2022	2	227.886733843698	8272.86031592205	500	2	f	2022-07-21 09:34:38.983517	\N
401	841372032	2022	2	959.83420560691	446.358001784867	500	2	f	2022-07-21 09:34:38.983517	\N
402	862589424	2022	2	162.189966108142	3555.71195188055	500	2	f	2022-07-21 09:34:38.983517	\N
403	871501781	2022	2	458.87540281064	9927.13247222681	500	2	f	2022-07-21 09:34:38.983517	\N
404	880977356	2022	2	696.124008642213	2900.34053303646	500	2	f	2022-07-21 09:34:38.983517	\N
405	859708655	2022	2	471.199474053921	687.36892342499	500	2	f	2022-07-21 09:34:38.983517	\N
406	837130075	2022	2	712.202217165456	2672.63848822402	500	2	f	2022-07-21 09:34:39.049613	\N
407	803170681	2022	2	675.746473626183	1907.64024382805	500	2	f	2022-07-21 09:34:39.049613	\N
408	875018446	2022	2	360.972561891158	635.680893504756	500	2	f	2022-07-21 09:34:39.049613	\N
409	872251225	2022	2	484.579359196284	3705.21949055652	500	2	f	2022-07-21 09:34:39.086058	\N
410	889927472	2022	2	943.041804991835	2053.68976518124	500	2	f	2022-07-21 09:34:39.086058	\N
411	850310272	2022	2	74.8868713355999	568.288474843313	500	2	f	2022-07-21 09:34:39.086058	\N
412	878277970	2022	2	477.382411711649	204.831418617537	500	2	f	2022-07-21 09:34:39.086058	\N
413	811324382	2022	2	819.849263379338	7757.74397865122	500	2	f	2022-07-21 09:34:39.086058	\N
414	878265174	2022	2	915.399401345823	7355.78803790265	500	2	f	2022-07-21 09:34:39.1136	\N
415	803799726	2022	2	600.133849601295	4059.79997600537	500	2	f	2022-07-21 09:34:39.1136	\N
416	827344157	2022	2	476.74825307655	2406.75766907616	500	2	f	2022-07-21 09:34:39.1136	\N
417	868610918	2022	2	588.998967053735	3550.08802079144	500	2	f	2022-07-21 09:34:39.1136	\N
418	891144647	2022	2	713.807061193395	1132.05703302836	500	2	f	2022-07-21 09:34:39.1136	\N
419	874750888	2022	2	898.503429390557	7089.60790130013	500	2	f	2022-07-21 09:34:39.1136	\N
420	879572863	2022	2	815.651993985466	7381.99972116877	500	2	f	2022-07-21 09:34:39.146082	\N
421	816719384	2022	2	420.531245927511	9645.3302755369	500	2	f	2022-07-21 09:34:39.146082	\N
422	823372812	2022	2	860.810891777918	4208.31047343719	500	2	f	2022-07-21 09:34:39.146082	\N
423	872671153	2022	2	835.559467131706	5014.24634214967	500	2	f	2022-07-21 09:34:39.218268	\N
424	837782686	2022	2	966.769142211966	6584.59650861689	500	2	f	2022-07-21 09:34:39.218268	\N
425	856373244	2022	2	335.372349745942	1203.40985479499	500	2	f	2022-07-21 09:34:39.253336	\N
426	802319687	2022	2	486.040005344666	6250.91042291606	500	2	f	2022-07-21 09:34:39.253336	\N
427	882221112	2022	2	206.736438033709	6892.84199373711	500	2	f	2022-07-21 09:34:39.253336	\N
428	825823538	2022	2	634.814525936363	7116.02594454065	500	2	f	2022-07-21 09:34:39.253336	\N
429	840744367	2022	2	268.877611991265	8812.1949597582	500	2	f	2022-07-21 09:34:39.253336	\N
430	807485242	2022	2	378.846157278181	3274.70774114603	500	2	f	2022-07-21 09:34:39.253336	\N
431	878321914	2022	2	671.711807565186	8412.71197518943	500	2	f	2022-07-21 09:34:39.253336	\N
432	886892017	2022	2	432.380007499415	5623.77236078493	500	2	f	2022-07-21 09:34:39.305373	\N
433	871623349	2022	2	138.575848804645	8367.99105173543	500	2	f	2022-07-21 09:34:39.305373	\N
434	864986459	2022	2	430.118615555341	1299.19865335456	500	2	f	2022-07-21 09:34:39.305373	\N
435	849227492	2022	2	991.679963553208	4017.6374819641	500	2	f	2022-07-21 09:34:39.305373	\N
436	850910144	2022	2	167.377708005376	1627.705305508	500	2	f	2022-07-21 09:34:39.36315	\N
437	869658223	2022	2	440.096866526461	7245.94993746258	500	2	f	2022-07-21 09:34:39.36315	\N
438	866431270	2022	2	999.360572582787	4002.27172998671	500	2	f	2022-07-21 09:34:39.36315	\N
439	858356342	2022	2	157.094781761389	7639.41445583693	500	2	f	2022-07-21 09:34:39.36315	\N
440	852467356	2022	2	568.45867612886	7574.11992912782	500	2	f	2022-07-21 09:34:39.36315	\N
441	898657961	2022	2	387.471271665023	3026.5519255724	500	2	f	2022-07-21 09:34:39.36315	\N
442	846849579	2022	2	625.70972422594	615.160347592117	500	2	f	2022-07-21 09:34:39.36315	\N
443	873579899	2022	2	182.336725844973	1838.09953457374	500	2	f	2022-07-21 09:34:39.412494	\N
444	843035298	2022	2	909.187181770467	4486.59262753994	500	2	f	2022-07-21 09:34:39.412494	\N
445	858836952	2022	2	396.45782725299	7007.0446651978	500	2	f	2022-07-21 09:34:39.412494	\N
446	805709917	2022	2	590.450994134087	4181.75944941703	500	2	f	2022-07-21 09:34:39.412494	\N
447	808479485	2022	2	441.709851386654	5380.55982380056	500	2	f	2022-07-21 09:34:39.412494	\N
448	838878962	2022	2	135.466676668086	5339.16881150428	500	2	f	2022-07-21 09:34:39.412494	\N
449	885625328	2022	2	116.389837774219	6076.5649326969	500	2	f	2022-07-21 09:34:39.460739	\N
450	837527996	2022	2	677.14284425326	9458.98024004243	500	2	f	2022-07-21 09:34:39.460739	\N
451	844848494	2022	2	262.709474581459	2501.21346309259	500	2	f	2022-07-21 09:34:39.460739	\N
452	825573136	2022	2	22.0684309605956	9181.88965322443	500	2	f	2022-07-21 09:34:39.460739	\N
453	809036318	2022	2	142.473785904784	4274.52720288169	500	2	f	2022-07-21 09:34:39.460739	\N
454	800223332	2022	2	751.084955732623	2317.68255228934	500	2	f	2022-07-21 09:34:39.460739	\N
455	878112453	2022	2	151.105790395843	8757.1598457805	500	2	f	2022-07-21 09:34:39.460739	\N
456	893781546	2022	2	68.3115978521799	2595.98946159254	500	2	f	2022-07-21 09:34:39.460739	\N
457	818658010	2022	2	731.738100205763	1716.75852013658	500	2	f	2022-07-21 09:34:39.506304	\N
458	862270603	2022	2	63.966192032619	3033.74009420034	500	2	f	2022-07-21 09:34:39.506304	\N
459	812325897	2022	2	465.432135585048	9593.82838247891	500	2	f	2022-07-21 09:34:39.506304	\N
460	817554736	2022	2	373.845116273377	9619.49864871136	500	2	f	2022-07-21 09:34:39.506304	\N
461	884291457	2022	2	269.437872753662	4334.43899306585	500	2	f	2022-07-21 09:34:39.506304	\N
462	890910485	2022	2	257.353109368662	9278.26354785502	500	2	f	2022-07-21 09:34:39.506304	\N
463	810677960	2022	2	124.837714401759	1725.65170812345	500	2	f	2022-07-21 09:34:39.506304	\N
464	830621787	2022	2	659.152886751814	6215.96235523227	500	2	f	2022-07-21 09:34:39.506304	\N
465	874792210	2022	2	334.365505636503	6030.45410727499	500	2	f	2022-07-21 09:34:39.506304	\N
466	828718942	2022	2	892.990526152969	930.946796517991	500	2	f	2022-07-21 09:34:39.506304	\N
467	846277869	2022	2	972.351070060952	7878.54426613104	500	2	f	2022-07-21 09:34:39.506304	\N
468	809316543	2022	2	961.176933695715	7086.76944294247	500	2	f	2022-07-21 09:34:39.54967	\N
469	846821438	2022	2	488.102345189522	107.934915862026	500	2	f	2022-07-21 09:34:39.54967	\N
470	836005340	2022	2	663.184304809104	8216.78499451472	500	2	f	2022-07-21 09:34:39.54967	\N
471	869069081	2022	2	121.141383642625	9111.94536473535	500	2	f	2022-07-21 09:34:39.54967	\N
472	824870495	2022	2	983.648318030573	8770.1185843813	500	2	f	2022-07-21 09:34:39.54967	\N
473	821850314	2022	2	25.1943032259594	751.194861404585	500	2	f	2022-07-21 09:34:39.54967	\N
474	895629317	2022	2	929.857040803214	5505.6487539513	500	2	f	2022-07-21 09:34:39.54967	\N
475	854843256	2022	2	6.06517271910203	9245.65691775619	500	2	f	2022-07-21 09:34:39.54967	\N
476	825397589	2022	2	800.910310619243	7952.4059410283	500	2	f	2022-07-21 09:34:39.54967	\N
477	856901774	2022	2	49.7282546744315	1533.40863162776	500	2	f	2022-07-21 09:34:39.603375	\N
478	886566656	2022	2	202.736083207007	9475.47337150632	500	2	f	2022-07-21 09:34:39.603375	\N
479	868634250	2022	2	579.96265929295	2890.3837418646	500	2	f	2022-07-21 09:34:39.603375	\N
480	827178297	2022	2	882.184711475704	3238.5970014219	500	2	f	2022-07-21 09:34:39.603375	\N
481	889901026	2022	2	929.259591965927	5842.10743223963	500	2	f	2022-07-21 09:34:39.603375	\N
482	860932226	2022	2	488.95518824085	2216.36996142883	500	2	f	2022-07-21 09:34:39.603375	\N
483	883640440	2022	2	824.586800192872	2404.96377284166	500	2	f	2022-07-21 09:34:39.652276	\N
484	899511765	2022	2	236.645959838742	3662.26732355652	500	2	f	2022-07-21 09:34:39.652276	\N
485	826671551	2022	2	453.955494946171	7133.85576564194	500	2	f	2022-07-21 09:34:39.652276	\N
486	838991015	2022	2	922.076005972753	8435.77363842461	500	2	f	2022-07-21 09:34:39.652276	\N
487	831768843	2022	2	204.439221925894	485.909190854719	500	2	f	2022-07-21 09:34:39.652276	\N
488	803324193	2022	2	349.034104049861	8025.63762917762	500	2	f	2022-07-21 09:34:39.652276	\N
489	827269180	2022	2	383.264604684294	7771.25676968989	500	2	f	2022-07-21 09:34:39.694816	\N
490	806938796	2022	2	206.912990169257	8391.19878713787	500	2	f	2022-07-21 09:34:39.694816	\N
491	817130185	2022	2	184.731183322123	9679.64410967543	500	2	f	2022-07-21 09:34:39.694816	\N
492	810402680	2022	2	964.476464424011	631.545349311352	500	2	f	2022-07-21 09:34:39.726786	\N
493	887841956	2022	2	690.894874406126	6356.64650718496	500	2	f	2022-07-21 09:34:39.726786	\N
494	897336611	2022	2	956.779498207184	74.2848078275667	500	2	f	2022-07-21 09:34:39.726786	\N
495	858728795	2022	2	381.519353405987	2467.77093335373	500	2	f	2022-07-21 09:34:39.726786	\N
496	880050743	2022	2	817.567553631133	6979.51101428012	500	2	f	2022-07-21 09:34:39.761857	\N
497	871161662	2022	2	782.511215955249	7854.78974162866	500	2	f	2022-07-21 09:34:39.761857	\N
498	862924848	2022	2	655.902476895334	7304.59157653804	500	2	f	2022-07-21 09:34:39.761857	\N
499	895031114	2022	2	184.934397600792	5873.63983178148	500	2	f	2022-07-21 09:34:39.761857	\N
500	815517829	2022	2	567.192205551307	5545.47399444983	500	2	f	2022-07-21 09:34:39.761857	\N
501	836666246	2022	2	597.350171004997	5782.01956544398	500	2	f	2022-07-21 09:34:39.761857	\N
502	845715533	2022	2	301.430353494043	4748.39557083973	500	2	f	2022-07-21 09:34:39.801171	\N
503	897156462	2022	2	771.143054374327	2109.39963920192	500	2	f	2022-07-21 09:34:39.801171	\N
504	890815244	2022	2	255.427708615682	5274.96137295068	500	2	f	2022-07-21 09:34:39.801171	\N
505	866562589	2022	2	616.799370848047	9199.71882043437	500	2	f	2022-07-21 09:34:39.801171	\N
506	875322390	2022	2	964.316995312287	120.557071872631	500	2	f	2022-07-21 09:34:39.801171	\N
507	870376312	2022	2	68.5683585076212	2532.70062193333	500	2	f	2022-07-21 09:34:39.827761	\N
508	863074238	2022	2	541.600508345956	114.259896551943	500	2	f	2022-07-21 09:34:39.827761	\N
509	873535604	2022	2	653.36881091318	7946.35889662964	500	2	f	2022-07-21 09:34:39.827761	\N
510	820029647	2022	2	126.308814592365	6866.56142753324	500	2	f	2022-07-21 09:34:39.827761	\N
511	825514130	2022	2	708.39396839808	4195.82219555867	500	2	f	2022-07-21 09:34:39.827761	\N
512	815801592	2022	2	951.139289032723	5509.0232628543	500	2	f	2022-07-21 09:34:39.827761	\N
\.


--
-- Data for Name: virksomhet; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.virksomhet (id, orgnr, land, landkode, postnummer, poststed, kommune, kommunenummer, navn, adresse, status, oppstartsdato, oppdatertavbrregoppdateringsid, opprettettidspunkt, sistendrettidspunkt) FROM stdin;
1	987654321	Norge	NO	1234	POSTSTED	OSLO	0301	Virksomhet Oslo	{"Osloveien 1"}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.346744	\N
2	123456789	Norge	NO	1234	POSTSTED	BERGEN	4601	Virksomhet Bærgen	{"Bergenveien 1"}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.3584	\N
3	984247664	Norge	NO	0663	Oslo	OSLO	0301	NAV Arbeidslivssenter Oslo	{"C. J. Hambros plass 2","0164 OSLO"}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.367934	\N
4	555555555	Norge	NO	1234	POSTSTED	OSLO	0301	Virksomhet Oslo Flere Adresser	{"c/o Oslo Tigersen","Osloveien 1","0977 Oslo"}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.376191	\N
5	666666666	Norge	NO	1234	POSTSTED	OSLO	0301	Virksomhet Oslo Mangler Adresser	{}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.383363	\N
6	800061965	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 800061965	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.391554	\N
7	881532376	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 881532376	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.399692	\N
8	883874352	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 883874352	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.408972	\N
9	848147638	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 848147638	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.416633	\N
10	876763949	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 876763949	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.424411	\N
11	871871807	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 871871807	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.431667	\N
12	864079801	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 864079801	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.43941	\N
13	836041617	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 836041617	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.447986	\N
14	857842260	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 857842260	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.454686	\N
15	885073621	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 885073621	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.460569	\N
16	864754605	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 864754605	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.466983	\N
17	846347581	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 846347581	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.473851	\N
18	824680794	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 824680794	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.479094	\N
19	839415001	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 839415001	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.484508	\N
20	861744528	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 861744528	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.494084	\N
21	860138909	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 860138909	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.499189	\N
22	843242104	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 843242104	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.506465	\N
23	890093850	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 890093850	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.511783	\N
24	892511017	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 892511017	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.517075	\N
25	842605109	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 842605109	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.522175	\N
26	870491047	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 870491047	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.527131	\N
27	863507760	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 863507760	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.533627	\N
28	817257908	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 817257908	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.539923	\N
29	809042383	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 809042383	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.545909	\N
30	810734693	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 810734693	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.551351	\N
31	804629062	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 804629062	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.556431	\N
32	873621335	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 873621335	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.56111	\N
33	835058832	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 835058832	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.566056	\N
34	803826652	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 803826652	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.571139	\N
35	874394467	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 874394467	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.575468	\N
36	838903289	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 838903289	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.581363	\N
37	882051647	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 882051647	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.588495	\N
38	879681201	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 879681201	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.594698	\N
39	852409131	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 852409131	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.600192	\N
40	808215075	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 808215075	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.607489	\N
41	865074415	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 865074415	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.614924	\N
42	836669149	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 836669149	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.622232	\N
43	884369776	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 884369776	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.629448	\N
44	873418367	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 873418367	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.635449	\N
45	802905016	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 802905016	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.643041	\N
46	885609899	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 885609899	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.6482	\N
47	860836918	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 860836918	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.653791	\N
48	829745509	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 829745509	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.658512	\N
49	844246611	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 844246611	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.663099	\N
50	867216743	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 867216743	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.667666	\N
51	890941228	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 890941228	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.672593	\N
52	838540049	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 838540049	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.676781	\N
53	809501750	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 809501750	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.681293	\N
54	844496478	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 844496478	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.687702	\N
55	863501025	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 863501025	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.69493	\N
56	839166324	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 839166324	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.700428	\N
57	879962157	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 879962157	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.706563	\N
58	848543645	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 848543645	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.711586	\N
59	880279851	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 880279851	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.71708	\N
60	808671188	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 808671188	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.723417	\N
61	851333885	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 851333885	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.729174	\N
62	815366017	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 815366017	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.734892	\N
63	891113900	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 891113900	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.741156	\N
64	894926128	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 894926128	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.749111	\N
65	802290404	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 802290404	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.757789	\N
66	896239097	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 896239097	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.76383	\N
67	816868949	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 816868949	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.769797	\N
68	895298219	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 895298219	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.775502	\N
69	842893897	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 842893897	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.780489	\N
70	814670938	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 814670938	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.78594	\N
71	820433803	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 820433803	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.793523	\N
72	874104569	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 874104569	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.798936	\N
73	856520283	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 856520283	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.806265	\N
74	879090305	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 879090305	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.814296	\N
75	809468321	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 809468321	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.821376	\N
76	826378947	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 826378947	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.828595	\N
77	866390365	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 866390365	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.835462	\N
78	862771013	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 862771013	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.842695	\N
79	864363318	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 864363318	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.848748	\N
80	896438075	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 896438075	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.855724	\N
81	829368106	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 829368106	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.862534	\N
82	867407313	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 867407313	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.868936	\N
83	896587504	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 896587504	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.876454	\N
84	847845944	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 847845944	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.882679	\N
85	826389298	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 826389298	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.888623	\N
86	848399886	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 848399886	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.894858	\N
87	854846835	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 854846835	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.900376	\N
88	800634899	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 800634899	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.906461	\N
89	857110616	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 857110616	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.912775	\N
90	808271586	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 808271586	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.918504	\N
91	819801010	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 819801010	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.925208	\N
92	848578637	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 848578637	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.930618	\N
93	827490752	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 827490752	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.936048	\N
94	835736810	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 835736810	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.941218	\N
95	857544475	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 857544475	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.946181	\N
96	847721823	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 847721823	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.950792	\N
97	862581603	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 862581603	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.957056	\N
98	810313500	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 810313500	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.962905	\N
99	885129733	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 885129733	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.968958	\N
100	898243796	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 898243796	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.975843	\N
101	887079787	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 887079787	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.981939	\N
102	861058672	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 861058672	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.987499	\N
103	876537913	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 876537913	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:32.993268	\N
104	890597928	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 890597928	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.003239	\N
105	842982051	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 842982051	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.008932	\N
106	842389667	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 842389667	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.017325	\N
107	820004072	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 820004072	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.025438	\N
108	897688257	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 897688257	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.030724	\N
109	837534390	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 837534390	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.035933	\N
110	808543637	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 808543637	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.041276	\N
111	870201888	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 870201888	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.046205	\N
112	817311070	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 817311070	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.050826	\N
113	868012776	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 868012776	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.055285	\N
114	896429753	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 896429753	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.059795	\N
115	851603425	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 851603425	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.063614	\N
116	827443317	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 827443317	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.06915	\N
117	833362642	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 833362642	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.075873	\N
118	882069408	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 882069408	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.08052	\N
119	863878944	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 863878944	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.085098	\N
120	866558221	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 866558221	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.091724	\N
121	868767855	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 868767855	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.096321	\N
122	875885300	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 875885300	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.101417	\N
123	842216735	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 842216735	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.10619	\N
124	856920437	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 856920437	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.110435	\N
125	830858963	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 830858963	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.11576	\N
126	812434114	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 812434114	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.123917	\N
127	847041353	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 847041353	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.130696	\N
128	803269327	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 803269327	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.136551	\N
129	843457384	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 843457384	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.142181	\N
130	818306281	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 818306281	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.14844	\N
131	844449510	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 844449510	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.155128	\N
132	867177223	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 867177223	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.160293	\N
133	883963814	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 883963814	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.165925	\N
134	886253015	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 886253015	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.17183	\N
135	895281822	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 895281822	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.177514	\N
136	840533481	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 840533481	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.181753	\N
137	839216776	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 839216776	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.185973	\N
138	803533948	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 803533948	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.193192	\N
139	827095124	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 827095124	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.19932	\N
140	808251981	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 808251981	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.206261	\N
141	817358823	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 817358823	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.212155	\N
142	871910327	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 871910327	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.218205	\N
143	866587133	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 866587133	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.224392	\N
144	842840788	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 842840788	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.232267	\N
145	812781923	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 812781923	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.243616	\N
146	804058381	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 804058381	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.247914	\N
147	811423248	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 811423248	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.254178	\N
148	840837641	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 840837641	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.259795	\N
149	818816392	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 818816392	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.26495	\N
150	806494928	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 806494928	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.269274	\N
151	893055618	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 893055618	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.274148	\N
152	875340822	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 875340822	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.277978	\N
153	818463756	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 818463756	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.281718	\N
154	884152302	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 884152302	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.285414	\N
155	849742742	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 849742742	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.289515	\N
156	804979817	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 804979817	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.293317	\N
157	814190896	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 814190896	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.297107	\N
158	822331640	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 822331640	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.300578	\N
159	862678317	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 862678317	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.304518	\N
160	831093023	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 831093023	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.309009	\N
161	874226454	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 874226454	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.31246	\N
162	832436811	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 832436811	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.316075	\N
163	838432048	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 838432048	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.319753	\N
164	870022919	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 870022919	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.324196	\N
165	879268334	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 879268334	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.327839	\N
166	806599852	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 806599852	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.333031	\N
167	863181199	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 863181199	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.336412	\N
168	863767568	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 863767568	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.340558	\N
169	844014636	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 844014636	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.34417	\N
170	866404710	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 866404710	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.347466	\N
171	833129946	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 833129946	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.35093	\N
172	846977998	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 846977998	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.355212	\N
173	811030348	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 811030348	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.359163	\N
174	890815907	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 890815907	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.363469	\N
175	822694021	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 822694021	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.367803	\N
176	852558904	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 852558904	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.371844	\N
177	822874914	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 822874914	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.375789	\N
178	866646453	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 866646453	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.37958	\N
179	881021956	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 881021956	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.383045	\N
180	899291735	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 899291735	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.386516	\N
181	867918928	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 867918928	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.39083	\N
182	823439458	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 823439458	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.394592	\N
183	837805347	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 837805347	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.397998	\N
184	805499088	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 805499088	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.401602	\N
185	845822610	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 845822610	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.406229	\N
186	841405633	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 841405633	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.410429	\N
187	889675608	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 889675608	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.414601	\N
188	899025387	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 899025387	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.418639	\N
189	863280835	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 863280835	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.423403	\N
190	860629673	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 860629673	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.427342	\N
191	833667497	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 833667497	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.431248	\N
192	842471044	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 842471044	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.43489	\N
193	861459803	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 861459803	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.43914	\N
194	812926032	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 812926032	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.443412	\N
195	871631319	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 871631319	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.447129	\N
196	865439281	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 865439281	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.45061	\N
197	824210548	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 824210548	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.454552	\N
198	805486005	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 805486005	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.45889	\N
199	832448472	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 832448472	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.462655	\N
200	805820685	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 805820685	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.466516	\N
201	883768894	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 883768894	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.47028	\N
202	856903021	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 856903021	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.474471	\N
203	850012745	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 850012745	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.477916	\N
204	820149848	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 820149848	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.48141	\N
205	822705108	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 822705108	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.484647	\N
206	857573851	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 857573851	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.488992	\N
207	856078198	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 856078198	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.493681	\N
208	859225721	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 859225721	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.497904	\N
209	873879874	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 873879874	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.505857	\N
210	890065285	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 890065285	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.510123	\N
211	893423280	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 893423280	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.514131	\N
212	816273126	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 816273126	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.517565	\N
213	874977909	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 874977909	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.521719	\N
214	888632161	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 888632161	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.526408	\N
215	852452427	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 852452427	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.529878	\N
216	807389236	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 807389236	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.533303	\N
217	833163111	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 833163111	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.536834	\N
218	813080832	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 813080832	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.544932	\N
219	896489260	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 896489260	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.548558	\N
220	845881839	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 845881839	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.552193	\N
221	898157169	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 898157169	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.55622	\N
222	882940656	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 882940656	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.559848	\N
223	887589106	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 887589106	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.563278	\N
224	856439808	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 856439808	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.566752	\N
225	869911712	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 869911712	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.570224	\N
226	836420677	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 836420677	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.574312	\N
227	810521018	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 810521018	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.580121	\N
228	863021621	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 863021621	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.583471	\N
229	846289494	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 846289494	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.587197	\N
230	834191416	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 834191416	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.591211	\N
231	837420340	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 837420340	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.594522	\N
232	871949311	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 871949311	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.597551	\N
233	821633142	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 821633142	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.6005	\N
234	893463166	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 893463166	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.604071	\N
235	833218825	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 833218825	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.608157	\N
236	807456455	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 807456455	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.612705	\N
237	821381486	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 821381486	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.615352	\N
238	814324199	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 814324199	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.622835	\N
239	805904949	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 805904949	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.627492	\N
240	813242515	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 813242515	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.631416	\N
241	839415843	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 839415843	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.63582	\N
242	804234371	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 804234371	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.640219	\N
243	816585946	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 816585946	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.64595	\N
244	824097835	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 824097835	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.650093	\N
245	880538674	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 880538674	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.654862	\N
246	875775705	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 875775705	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.65933	\N
247	877421692	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 877421692	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.663987	\N
248	871547736	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 871547736	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.672676	\N
249	857653378	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 857653378	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.678094	\N
250	829980700	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 829980700	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.682609	\N
251	852627790	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 852627790	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.689718	\N
252	865978526	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 865978526	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.694208	\N
253	840145629	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 840145629	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.698862	\N
254	875016141	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 875016141	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.70436	\N
255	869419134	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 869419134	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.709126	\N
256	813944600	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 813944600	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.714055	\N
257	885600454	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 885600454	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.718896	\N
258	877550656	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 877550656	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.724874	\N
259	804227830	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 804227830	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.729774	\N
260	858956619	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 858956619	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.734	\N
261	865153645	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 865153645	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.741104	\N
262	817941723	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 817941723	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.746462	\N
263	811667993	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 811667993	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.752311	\N
264	859462534	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 859462534	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.759748	\N
265	822317092	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 822317092	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.764892	\N
266	877772835	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 877772835	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.770436	\N
267	846495295	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 846495295	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.77546	\N
268	804775869	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 804775869	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.779613	\N
269	831030012	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 831030012	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.783496	\N
270	802809462	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 802809462	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.78765	\N
271	896200151	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 896200151	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.792317	\N
272	873610100	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 873610100	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.796055	\N
273	847931581	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 847931581	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.799599	\N
274	870810427	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 870810427	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.803211	\N
275	816457914	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 816457914	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.807846	\N
276	816760477	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 816760477	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.811967	\N
277	821449527	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 821449527	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.816016	\N
278	897412997	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 897412997	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.819927	\N
279	801856356	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 801856356	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.825277	\N
280	898170941	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 898170941	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.828846	\N
281	884390144	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 884390144	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.832225	\N
282	894424841	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 894424841	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.835585	\N
283	828972512	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 828972512	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.840044	\N
284	815082581	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 815082581	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.843648	\N
285	887159012	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 887159012	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.846967	\N
286	829493874	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 829493874	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.850044	\N
287	814929193	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 814929193	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.853195	\N
288	859907302	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 859907302	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.857149	\N
289	895124699	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 895124699	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.860337	\N
290	813239227	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 813239227	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.863463	\N
291	840430296	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 840430296	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.866709	\N
292	858726639	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 858726639	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.869929	\N
293	823234800	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 823234800	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.873707	\N
294	874361830	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 874361830	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.876617	\N
295	808481735	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 808481735	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.879497	\N
296	860499175	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 860499175	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.88238	\N
297	892697142	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 892697142	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.885904	\N
298	826727890	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 826727890	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.890117	\N
299	895582762	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 895582762	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.893895	\N
300	814663914	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 814663914	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.897305	\N
301	887191975	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 887191975	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.900483	\N
302	856729012	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 856729012	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.903834	\N
303	816248533	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 816248533	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.907584	\N
304	847253663	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 847253663	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.911237	\N
305	851556995	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 851556995	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.914281	\N
306	897000352	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 897000352	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.917506	\N
307	891267708	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 891267708	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.921064	\N
308	868369009	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 868369009	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.924444	\N
309	836786224	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 836786224	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.92794	\N
310	800910790	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 800910790	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.931311	\N
311	847922087	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 847922087	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.934415	\N
312	882737279	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 882737279	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.9377	\N
313	817612413	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 817612413	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.941368	\N
314	857680168	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 857680168	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.9448	\N
315	878624841	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 878624841	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.948081	\N
316	867183919	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 867183919	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.951285	\N
317	824306551	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 824306551	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.954945	\N
318	812929350	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 812929350	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.958502	\N
319	890735735	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 890735735	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.961778	\N
320	894341616	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 894341616	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.96487	\N
321	845690609	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 845690609	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.968641	\N
322	884945724	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 884945724	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.972813	\N
323	820865124	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 820865124	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.976449	\N
324	870514368	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 870514368	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.979711	\N
325	833643869	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 833643869	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.982841	\N
326	807702188	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 807702188	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.986225	\N
327	820638689	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 820638689	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.990964	\N
328	843380901	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 843380901	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.994169	\N
329	832951634	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 832951634	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:33.99754	\N
330	833677243	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 833677243	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.000616	\N
331	873656323	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 873656323	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.004149	\N
332	859159231	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 859159231	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.010245	\N
333	868067017	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 868067017	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.013485	\N
334	856435712	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 856435712	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.017319	\N
335	888937591	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 888937591	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.022137	\N
336	873906284	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 873906284	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.027085	\N
337	855150484	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 855150484	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.03139	\N
338	836365546	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 836365546	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.035281	\N
339	822564929	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 822564929	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.040622	\N
340	833204596	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 833204596	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.051767	\N
341	863592645	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 863592645	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.057152	\N
342	865956727	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 865956727	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.061143	\N
343	807629933	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 807629933	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.064909	\N
344	832454631	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 832454631	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.068609	\N
345	823356725	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 823356725	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.073144	\N
346	800824855	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 800824855	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.076706	\N
347	894510083	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 894510083	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.080395	\N
348	815854671	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 815854671	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.083796	\N
349	876401827	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 876401827	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.087105	\N
350	845066027	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 845066027	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.09083	\N
351	815406101	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 815406101	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.094189	\N
352	866878310	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 866878310	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.097332	\N
353	830803739	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 830803739	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.100256	\N
354	805933483	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 805933483	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.103589	\N
355	868252144	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 868252144	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.107225	\N
356	828744326	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 828744326	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.110391	\N
357	830122600	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 830122600	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.113581	\N
358	813147327	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 813147327	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.116474	\N
359	846250295	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 846250295	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.119741	\N
360	898250721	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 898250721	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.123487	\N
361	813697349	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 813697349	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.126657	\N
362	863104800	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 863104800	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.129485	\N
363	897979593	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 897979593	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.132501	\N
364	860772161	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 860772161	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.135277	\N
365	808002552	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 808002552	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.138489	\N
366	876394411	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 876394411	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.141804	\N
367	846214156	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 846214156	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.145227	\N
368	850015354	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 850015354	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.148127	\N
369	805145991	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 805145991	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.150925	\N
370	853879838	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 853879838	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.15835	\N
371	882939801	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 882939801	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.166732	\N
372	859605190	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 859605190	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.175415	\N
373	891814367	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 891814367	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.179611	\N
374	875021136	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 875021136	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.183153	\N
375	825379831	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 825379831	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.186249	\N
376	800469195	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 800469195	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.189379	\N
377	871244244	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 871244244	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.192525	\N
378	837133219	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 837133219	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.195449	\N
379	855964219	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 855964219	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.19862	\N
380	838273484	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 838273484	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.201784	\N
381	893483616	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 893483616	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.204891	\N
382	891497759	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 891497759	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.208406	\N
383	888247901	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 888247901	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.212176	\N
384	883590490	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 883590490	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.215831	\N
385	804908767	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 804908767	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.219312	\N
386	851919134	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 851919134	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.224201	\N
387	813682750	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 813682750	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.227452	\N
388	875544956	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 875544956	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.230748	\N
389	889472231	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 889472231	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.234395	\N
390	875631634	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 875631634	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.237451	\N
391	856007783	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 856007783	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.24058	\N
392	844760467	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 844760467	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.243608	\N
393	863256691	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 863256691	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.246669	\N
394	851705582	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 851705582	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.249909	\N
395	854298834	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 854298834	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.253054	\N
396	836216435	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 836216435	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.256115	\N
397	893017297	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 893017297	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.258802	\N
398	841372032	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 841372032	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.261957	\N
399	862589424	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 862589424	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.264687	\N
400	871501781	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 871501781	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.267277	\N
401	880977356	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 880977356	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.269938	\N
402	859708655	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 859708655	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.272601	\N
403	837130075	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 837130075	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.281054	\N
404	803170681	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 803170681	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.283861	\N
405	875018446	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 875018446	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.28601	\N
406	872251225	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 872251225	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.288448	\N
407	889927472	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 889927472	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.290981	\N
408	850310272	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 850310272	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.294008	\N
409	878277970	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 878277970	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.297567	\N
410	811324382	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 811324382	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.300607	\N
411	878265174	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 878265174	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.303715	\N
412	803799726	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 803799726	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.307091	\N
413	827344157	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 827344157	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.310597	\N
414	868610918	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 868610918	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.313902	\N
415	891144647	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 891144647	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.317187	\N
416	874750888	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 874750888	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.320245	\N
417	879572863	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 879572863	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.323247	\N
418	816719384	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 816719384	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.326234	\N
419	823372812	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 823372812	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.329375	\N
420	872671153	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 872671153	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.33456	\N
421	837782686	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 837782686	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.337623	\N
422	856373244	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 856373244	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.340255	\N
423	802319687	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 802319687	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.343029	\N
424	882221112	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 882221112	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.345684	\N
425	825823538	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 825823538	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.34823	\N
426	840744367	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 840744367	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.35087	\N
427	807485242	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 807485242	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.353442	\N
428	878321914	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 878321914	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.355961	\N
429	886892017	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 886892017	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.358564	\N
430	871623349	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 871623349	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.361314	\N
431	864986459	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 864986459	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.364143	\N
432	849227492	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 849227492	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.366656	\N
433	850910144	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 850910144	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.369293	\N
434	869658223	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 869658223	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.37187	\N
435	866431270	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 866431270	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.374475	\N
436	858356342	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 858356342	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.377011	\N
437	852467356	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 852467356	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.379707	\N
438	898657961	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 898657961	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.382439	\N
439	846849579	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 846849579	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.385057	\N
440	873579899	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 873579899	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.387808	\N
441	843035298	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 843035298	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.390745	\N
442	858836952	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 858836952	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.393424	\N
443	805709917	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 805709917	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.396043	\N
444	808479485	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 808479485	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.399912	\N
445	838878962	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 838878962	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.402602	\N
446	885625328	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 885625328	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.405099	\N
447	837527996	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 837527996	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.407587	\N
448	844848494	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 844848494	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.410133	\N
449	825573136	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 825573136	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.413113	\N
450	809036318	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 809036318	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.415739	\N
451	800223332	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 800223332	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.418385	\N
452	878112453	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 878112453	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.420886	\N
453	893781546	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 893781546	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.423612	\N
454	818658010	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 818658010	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.426208	\N
455	862270603	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 862270603	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.429072	\N
456	812325897	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 812325897	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.431911	\N
457	817554736	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 817554736	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.434602	\N
458	884291457	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 884291457	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.437175	\N
459	890910485	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 890910485	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.439749	\N
460	810677960	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 810677960	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.442425	\N
461	830621787	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 830621787	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.445275	\N
462	874792210	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 874792210	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.447885	\N
463	828718942	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 828718942	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.450375	\N
464	846277869	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 846277869	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.452812	\N
465	809316543	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 809316543	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.455487	\N
466	846821438	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 846821438	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.458227	\N
467	836005340	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 836005340	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.460874	\N
468	869069081	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 869069081	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.463441	\N
469	824870495	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 824870495	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.465957	\N
470	821850314	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 821850314	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.468484	\N
471	895629317	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 895629317	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.471051	\N
472	854843256	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 854843256	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.473817	\N
473	825397589	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 825397589	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.476375	\N
474	856901774	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 856901774	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.478938	\N
475	886566656	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 886566656	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.48151	\N
476	868634250	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 868634250	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.483987	\N
477	827178297	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 827178297	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.486612	\N
478	889901026	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 889901026	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.4894	\N
479	860932226	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 860932226	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.492239	\N
480	883640440	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 883640440	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.494804	\N
481	899511765	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 899511765	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.49716	\N
482	826671551	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 826671551	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.499702	\N
483	838991015	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 838991015	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.502315	\N
484	831768843	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 831768843	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.50485	\N
485	803324193	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 803324193	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.507368	\N
486	827269180	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 827269180	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.509877	\N
487	806938796	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 806938796	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.51271	\N
488	817130185	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 817130185	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.520228	\N
489	810402680	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 810402680	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.522914	\N
490	887841956	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 887841956	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.52602	\N
491	897336611	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 897336611	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.52902	\N
492	858728795	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 858728795	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.532267	\N
493	880050743	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 880050743	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.5353	\N
494	871161662	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 871161662	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.538312	\N
495	862924848	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 862924848	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.541647	\N
496	895031114	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 895031114	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.54504	\N
497	815517829	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 815517829	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.548649	\N
498	836666246	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 836666246	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.552185	\N
499	845715533	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 845715533	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.56304	\N
500	897156462	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 897156462	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.566913	\N
501	890815244	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 890815244	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.57031	\N
502	866562589	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 866562589	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.574048	\N
503	875322390	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 875322390	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.57758	\N
504	870376312	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 870376312	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.581105	\N
505	863074238	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 863074238	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.585004	\N
506	873535604	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 873535604	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.588644	\N
507	820029647	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 820029647	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.592716	\N
508	825514130	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 825514130	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.596871	\N
509	815801592	Norge	NO	1234	POSTSTED	OSLO	0301	Navn 815801592	{adresse}	AKTIV	2010-07-01	\N	2022-07-21 09:34:34.600977	\N
\.


--
-- Data for Name: virksomhet_naring; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.virksomhet_naring (virksomhet, narings_kode) FROM stdin;
1	90.012
2	70.220
2	90.012
3	90.012
4	90.012
4	70.220
5	90.012
6	90.012
7	01.120
8	70.220
8	01.120
9	70.220
10	70.220
10	90.012
11	01.120
12	70.220
13	90.012
14	70.220
15	90.012
16	01.120
16	90.012
16	70.220
17	90.012
18	01.120
19	90.012
19	70.220
20	70.220
21	90.012
21	70.220
22	70.220
23	01.120
24	01.120
24	90.012
25	70.220
26	01.120
27	01.120
27	70.220
28	90.012
28	70.220
29	70.220
30	70.220
31	01.120
31	70.220
32	90.012
32	01.120
33	01.120
33	70.220
34	01.120
35	01.120
35	90.012
35	70.220
36	70.220
36	90.012
37	90.012
37	01.120
38	70.220
39	90.012
40	01.120
40	70.220
41	01.120
41	90.012
41	70.220
42	01.120
42	90.012
42	70.220
43	01.120
43	70.220
44	90.012
44	01.120
45	90.012
45	70.220
46	01.120
46	90.012
47	70.220
48	90.012
48	70.220
49	70.220
49	01.120
50	70.220
50	01.120
51	01.120
52	90.012
52	01.120
53	01.120
53	90.012
53	70.220
54	70.220
55	01.120
55	90.012
55	70.220
56	90.012
57	70.220
57	90.012
58	01.120
59	70.220
59	90.012
60	01.120
61	90.012
62	01.120
63	01.120
63	90.012
63	70.220
64	90.012
65	90.012
65	70.220
66	90.012
67	70.220
68	90.012
69	01.120
70	70.220
70	01.120
71	90.012
72	90.012
73	01.120
73	90.012
73	70.220
74	70.220
74	90.012
75	70.220
76	01.120
76	90.012
77	01.120
78	01.120
78	90.012
78	70.220
79	01.120
79	90.012
80	90.012
81	70.220
82	70.220
83	01.120
84	01.120
85	01.120
85	90.012
85	70.220
86	01.120
86	90.012
87	01.120
87	70.220
88	01.120
89	70.220
90	01.120
91	01.120
92	01.120
92	90.012
92	70.220
93	70.220
94	70.220
95	01.120
95	90.012
95	70.220
96	70.220
96	01.120
97	90.012
98	70.220
98	01.120
99	01.120
99	70.220
100	90.012
101	01.120
101	90.012
101	70.220
102	01.120
102	90.012
102	70.220
103	90.012
103	70.220
104	90.012
105	01.120
105	90.012
105	70.220
106	90.012
106	01.120
107	90.012
108	01.120
109	90.012
110	90.012
110	70.220
111	90.012
112	01.120
112	90.012
112	70.220
113	70.220
114	90.012
115	01.120
115	90.012
115	70.220
116	01.120
116	70.220
117	70.220
118	90.012
118	01.120
119	90.012
120	90.012
121	90.012
121	01.120
122	01.120
122	90.012
122	70.220
123	01.120
124	70.220
125	01.120
125	90.012
125	70.220
126	70.220
127	90.012
128	90.012
129	70.220
130	70.220
131	70.220
132	70.220
133	90.012
134	01.120
134	70.220
135	01.120
136	90.012
137	70.220
138	01.120
139	90.012
140	90.012
141	01.120
141	70.220
142	90.012
143	01.120
143	70.220
144	01.120
145	70.220
146	01.120
146	90.012
146	70.220
147	01.120
147	70.220
148	01.120
149	01.120
149	90.012
149	70.220
150	90.012
150	01.120
151	90.012
152	01.120
152	90.012
152	70.220
153	90.012
153	70.220
154	70.220
155	01.120
156	01.120
157	70.220
158	01.120
159	01.120
160	70.220
161	70.220
162	70.220
163	90.012
163	70.220
164	90.012
164	01.120
165	70.220
166	90.012
167	01.120
168	70.220
169	01.120
170	01.120
170	90.012
170	70.220
171	90.012
172	70.220
173	90.012
173	01.120
174	90.012
174	70.220
175	01.120
176	90.012
177	01.120
178	01.120
178	90.012
178	70.220
179	70.220
179	90.012
180	01.120
180	90.012
180	70.220
181	01.120
182	70.220
183	90.012
184	70.220
185	90.012
186	01.120
186	70.220
187	90.012
187	70.220
188	01.120
188	90.012
188	70.220
189	90.012
190	70.220
191	70.220
191	01.120
192	01.120
192	90.012
193	70.220
194	90.012
195	01.120
196	90.012
196	70.220
197	90.012
198	90.012
199	90.012
200	01.120
201	90.012
202	01.120
202	90.012
203	70.220
203	90.012
204	01.120
204	70.220
205	70.220
206	01.120
207	90.012
207	01.120
208	01.120
209	90.012
210	70.220
211	01.120
212	90.012
213	90.012
214	01.120
214	90.012
215	90.012
216	90.012
217	70.220
218	70.220
219	01.120
219	90.012
219	70.220
220	01.120
221	90.012
222	90.012
223	01.120
223	70.220
224	01.120
224	90.012
224	70.220
225	01.120
226	90.012
226	70.220
227	01.120
227	90.012
227	70.220
228	01.120
229	90.012
230	01.120
230	90.012
230	70.220
231	70.220
232	90.012
233	01.120
233	70.220
234	01.120
234	70.220
235	01.120
236	90.012
237	01.120
237	90.012
237	70.220
238	70.220
239	90.012
240	01.120
240	90.012
240	70.220
241	90.012
242	90.012
243	01.120
244	70.220
245	01.120
245	90.012
245	70.220
246	70.220
247	70.220
248	01.120
249	01.120
249	90.012
249	70.220
250	01.120
250	90.012
250	70.220
251	01.120
251	70.220
252	90.012
253	90.012
254	90.012
254	70.220
255	01.120
255	90.012
255	70.220
256	01.120
256	70.220
257	70.220
258	01.120
258	90.012
258	70.220
259	01.120
259	90.012
259	70.220
260	01.120
261	01.120
261	70.220
262	70.220
263	90.012
263	70.220
264	90.012
265	90.012
265	01.120
266	90.012
267	01.120
268	01.120
268	70.220
269	90.012
270	01.120
270	70.220
271	01.120
271	90.012
272	01.120
272	70.220
273	01.120
274	01.120
274	90.012
275	90.012
276	70.220
277	01.120
277	90.012
277	70.220
278	90.012
279	01.120
279	90.012
279	70.220
280	01.120
280	70.220
281	01.120
281	90.012
281	70.220
282	70.220
283	90.012
284	01.120
284	90.012
284	70.220
285	01.120
285	90.012
286	70.220
287	70.220
288	70.220
289	70.220
289	01.120
290	90.012
291	90.012
291	70.220
292	90.012
293	90.012
294	90.012
295	90.012
296	01.120
296	90.012
296	70.220
297	90.012
298	70.220
299	01.120
299	90.012
299	70.220
300	70.220
300	90.012
301	70.220
302	70.220
303	01.120
303	90.012
303	70.220
304	90.012
305	01.120
306	70.220
307	90.012
308	90.012
309	01.120
310	01.120
310	90.012
310	70.220
311	90.012
312	01.120
313	70.220
313	90.012
314	01.120
315	70.220
316	70.220
317	70.220
318	90.012
319	70.220
320	01.120
321	70.220
321	01.120
322	70.220
322	90.012
323	90.012
324	01.120
324	70.220
325	01.120
326	90.012
327	70.220
327	01.120
328	70.220
329	90.012
329	01.120
330	90.012
330	70.220
331	01.120
331	90.012
331	70.220
332	01.120
332	90.012
332	70.220
333	70.220
334	70.220
335	01.120
335	90.012
335	70.220
336	70.220
337	90.012
337	70.220
338	90.012
339	90.012
340	90.012
341	01.120
341	90.012
341	70.220
342	70.220
343	01.120
344	01.120
345	70.220
345	90.012
346	01.120
347	01.120
348	90.012
348	70.220
349	01.120
349	90.012
349	70.220
350	01.120
350	90.012
350	70.220
351	01.120
351	90.012
351	70.220
352	70.220
353	01.120
354	70.220
354	90.012
355	01.120
355	90.012
356	01.120
356	70.220
357	01.120
357	90.012
358	01.120
359	70.220
360	90.012
361	70.220
362	90.012
363	01.120
364	01.120
364	90.012
364	70.220
365	90.012
366	01.120
367	90.012
368	90.012
369	70.220
370	01.120
370	90.012
370	70.220
371	70.220
371	90.012
372	01.120
372	90.012
372	70.220
373	90.012
374	70.220
375	01.120
376	90.012
376	70.220
377	01.120
378	01.120
379	70.220
380	90.012
381	90.012
381	01.120
382	01.120
382	70.220
383	01.120
383	70.220
384	01.120
385	70.220
386	01.120
387	70.220
388	01.120
389	01.120
389	90.012
389	70.220
390	70.220
390	01.120
391	70.220
392	70.220
393	90.012
393	01.120
394	01.120
394	90.012
394	70.220
395	01.120
396	70.220
397	01.120
397	90.012
397	70.220
398	70.220
399	90.012
400	01.120
400	90.012
400	70.220
401	90.012
402	01.120
403	01.120
403	90.012
404	01.120
405	01.120
405	70.220
406	70.220
406	01.120
407	90.012
408	01.120
409	90.012
409	70.220
410	70.220
410	90.012
411	01.120
412	01.120
412	90.012
412	70.220
413	01.120
413	70.220
414	90.012
414	01.120
415	70.220
416	90.012
417	01.120
418	90.012
418	70.220
419	01.120
420	70.220
420	90.012
421	70.220
422	01.120
423	90.012
424	70.220
425	01.120
425	90.012
425	70.220
426	70.220
427	01.120
428	01.120
429	90.012
429	01.120
430	70.220
431	01.120
432	70.220
433	01.120
433	90.012
433	70.220
434	01.120
435	70.220
435	90.012
436	90.012
436	01.120
437	90.012
438	01.120
438	90.012
438	70.220
439	01.120
439	90.012
440	01.120
441	70.220
442	90.012
442	70.220
443	90.012
444	90.012
445	01.120
445	90.012
445	70.220
446	90.012
447	01.120
447	90.012
447	70.220
448	01.120
448	90.012
449	70.220
450	01.120
450	90.012
450	70.220
451	01.120
452	90.012
453	90.012
454	01.120
455	70.220
455	01.120
456	01.120
457	01.120
457	90.012
457	70.220
458	01.120
459	01.120
460	90.012
461	01.120
461	90.012
462	70.220
463	01.120
464	01.120
464	90.012
464	70.220
465	01.120
466	70.220
467	01.120
467	90.012
467	70.220
468	90.012
469	01.120
470	01.120
471	01.120
472	90.012
473	90.012
473	70.220
474	01.120
474	70.220
475	90.012
476	90.012
477	01.120
477	70.220
478	01.120
479	90.012
480	01.120
481	70.220
482	01.120
482	90.012
482	70.220
483	01.120
483	90.012
483	70.220
484	01.120
484	90.012
484	70.220
485	70.220
486	01.120
487	01.120
487	90.012
487	70.220
488	01.120
489	01.120
490	90.012
491	70.220
492	01.120
492	90.012
492	70.220
493	01.120
493	90.012
493	70.220
494	90.012
494	01.120
495	01.120
496	01.120
496	90.012
496	70.220
497	01.120
498	01.120
499	90.012
499	01.120
500	70.220
501	01.120
501	90.012
501	70.220
502	90.012
502	70.220
503	70.220
504	01.120
504	70.220
505	90.012
505	70.220
506	70.220
507	90.012
507	70.220
508	01.120
508	90.012
508	70.220
509	01.120
\.


--
-- Data for Name: virksomhet_statistikk_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.virksomhet_statistikk_metadata (id, orgnr, kategori, sektor, opprettet) FROM stdin;
1	987654321	VIRKSOMHET	1	2022-07-21 09:34:34.936128
3	123456789	VIRKSOMHET	1	2022-07-21 09:34:35.03926
5	984247664	VIRKSOMHET	1	2022-07-21 09:34:35.166389
7	555555555	VIRKSOMHET	1	2022-07-21 09:34:35.166389
8	881532376	VIRKSOMHET	1	2022-07-21 09:34:35.166389
10	883874352	VIRKSOMHET	1	2022-07-21 09:34:35.166389
12	848147638	VIRKSOMHET	1	2022-07-21 09:34:35.166389
13	876763949	VIRKSOMHET	3	2022-07-21 09:34:35.166389
14	871871807	VIRKSOMHET	0	2022-07-21 09:34:35.166389
15	864079801	VIRKSOMHET	1	2022-07-21 09:34:35.166389
16	836041617	VIRKSOMHET	2	2022-07-21 09:34:35.166389
17	857842260	VIRKSOMHET	3	2022-07-21 09:34:35.166389
18	885073621	VIRKSOMHET	0	2022-07-21 09:34:35.166389
19	864754605	VIRKSOMHET	0	2022-07-21 09:34:35.166389
20	846347581	VIRKSOMHET	1	2022-07-21 09:34:35.166389
21	824680794	VIRKSOMHET	1	2022-07-21 09:34:35.166389
22	839415001	VIRKSOMHET	0	2022-07-21 09:34:35.166389
23	861744528	VIRKSOMHET	0	2022-07-21 09:34:35.166389
24	860138909	VIRKSOMHET	0	2022-07-21 09:34:35.166389
25	843242104	VIRKSOMHET	1	2022-07-21 09:34:35.166389
26	890093850	VIRKSOMHET	1	2022-07-21 09:34:35.166389
27	892511017	VIRKSOMHET	2	2022-07-21 09:34:35.166389
28	842605109	VIRKSOMHET	0	2022-07-21 09:34:35.166389
29	870491047	VIRKSOMHET	3	2022-07-21 09:34:35.166389
30	863507760	VIRKSOMHET	1	2022-07-21 09:34:35.166389
31	817257908	VIRKSOMHET	0	2022-07-21 09:34:35.166389
32	809042383	VIRKSOMHET	1	2022-07-21 09:34:35.166389
33	810734693	VIRKSOMHET	3	2022-07-21 09:34:35.303572
34	804629062	VIRKSOMHET	3	2022-07-21 09:34:35.303572
35	873621335	VIRKSOMHET	2	2022-07-21 09:34:35.303572
36	835058832	VIRKSOMHET	2	2022-07-21 09:34:35.303572
37	803826652	VIRKSOMHET	0	2022-07-21 09:34:35.303572
38	874394467	VIRKSOMHET	0	2022-07-21 09:34:35.303572
39	838903289	VIRKSOMHET	3	2022-07-21 09:34:35.303572
40	882051647	VIRKSOMHET	1	2022-07-21 09:34:35.303572
41	879681201	VIRKSOMHET	0	2022-07-21 09:34:35.303572
42	852409131	VIRKSOMHET	0	2022-07-21 09:34:35.303572
43	808215075	VIRKSOMHET	2	2022-07-21 09:34:35.303572
44	865074415	VIRKSOMHET	1	2022-07-21 09:34:35.43037
45	836669149	VIRKSOMHET	2	2022-07-21 09:34:35.43037
46	884369776	VIRKSOMHET	0	2022-07-21 09:34:35.43037
47	873418367	VIRKSOMHET	0	2022-07-21 09:34:35.43037
48	802905016	VIRKSOMHET	1	2022-07-21 09:34:35.43037
49	885609899	VIRKSOMHET	3	2022-07-21 09:34:35.43037
50	860836918	VIRKSOMHET	2	2022-07-21 09:34:35.43037
51	829745509	VIRKSOMHET	0	2022-07-21 09:34:35.43037
52	844246611	VIRKSOMHET	2	2022-07-21 09:34:35.43037
53	867216743	VIRKSOMHET	1	2022-07-21 09:34:35.43037
54	890941228	VIRKSOMHET	2	2022-07-21 09:34:35.43037
55	838540049	VIRKSOMHET	3	2022-07-21 09:34:35.43037
56	809501750	VIRKSOMHET	0	2022-07-21 09:34:35.43037
57	844496478	VIRKSOMHET	1	2022-07-21 09:34:35.43037
58	863501025	VIRKSOMHET	3	2022-07-21 09:34:35.43037
59	839166324	VIRKSOMHET	1	2022-07-21 09:34:35.43037
60	879962157	VIRKSOMHET	2	2022-07-21 09:34:35.43037
61	848543645	VIRKSOMHET	3	2022-07-21 09:34:35.43037
62	880279851	VIRKSOMHET	2	2022-07-21 09:34:35.532195
63	808671188	VIRKSOMHET	2	2022-07-21 09:34:35.532195
64	851333885	VIRKSOMHET	1	2022-07-21 09:34:35.532195
65	815366017	VIRKSOMHET	0	2022-07-21 09:34:35.532195
66	891113900	VIRKSOMHET	2	2022-07-21 09:34:35.532195
67	894926128	VIRKSOMHET	0	2022-07-21 09:34:35.532195
68	802290404	VIRKSOMHET	2	2022-07-21 09:34:35.532195
69	896239097	VIRKSOMHET	3	2022-07-21 09:34:35.532195
70	816868949	VIRKSOMHET	3	2022-07-21 09:34:35.532195
71	895298219	VIRKSOMHET	3	2022-07-21 09:34:35.532195
72	842893897	VIRKSOMHET	3	2022-07-21 09:34:35.532195
73	814670938	VIRKSOMHET	2	2022-07-21 09:34:35.532195
74	820433803	VIRKSOMHET	2	2022-07-21 09:34:35.611706
75	874104569	VIRKSOMHET	2	2022-07-21 09:34:35.611706
76	856520283	VIRKSOMHET	1	2022-07-21 09:34:35.611706
77	879090305	VIRKSOMHET	3	2022-07-21 09:34:35.611706
78	809468321	VIRKSOMHET	2	2022-07-21 09:34:35.611706
79	826378947	VIRKSOMHET	2	2022-07-21 09:34:35.611706
80	866390365	VIRKSOMHET	1	2022-07-21 09:34:35.611706
81	862771013	VIRKSOMHET	1	2022-07-21 09:34:35.611706
82	864363318	VIRKSOMHET	3	2022-07-21 09:34:35.611706
83	896438075	VIRKSOMHET	0	2022-07-21 09:34:35.611706
84	829368106	VIRKSOMHET	3	2022-07-21 09:34:35.611706
85	867407313	VIRKSOMHET	0	2022-07-21 09:34:35.611706
86	896587504	VIRKSOMHET	0	2022-07-21 09:34:35.611706
87	847845944	VIRKSOMHET	0	2022-07-21 09:34:35.611706
88	826389298	VIRKSOMHET	3	2022-07-21 09:34:35.611706
89	848399886	VIRKSOMHET	0	2022-07-21 09:34:35.709179
90	854846835	VIRKSOMHET	2	2022-07-21 09:34:35.709179
91	800634899	VIRKSOMHET	2	2022-07-21 09:34:35.709179
92	857110616	VIRKSOMHET	2	2022-07-21 09:34:35.709179
93	808271586	VIRKSOMHET	2	2022-07-21 09:34:35.709179
94	819801010	VIRKSOMHET	0	2022-07-21 09:34:35.709179
95	848578637	VIRKSOMHET	3	2022-07-21 09:34:35.709179
96	827490752	VIRKSOMHET	0	2022-07-21 09:34:35.752865
97	835736810	VIRKSOMHET	1	2022-07-21 09:34:35.752865
98	857544475	VIRKSOMHET	1	2022-07-21 09:34:35.752865
99	847721823	VIRKSOMHET	0	2022-07-21 09:34:35.752865
100	862581603	VIRKSOMHET	0	2022-07-21 09:34:35.752865
101	810313500	VIRKSOMHET	0	2022-07-21 09:34:35.752865
102	885129733	VIRKSOMHET	1	2022-07-21 09:34:35.752865
103	898243796	VIRKSOMHET	1	2022-07-21 09:34:35.752865
104	887079787	VIRKSOMHET	2	2022-07-21 09:34:35.752865
105	861058672	VIRKSOMHET	2	2022-07-21 09:34:35.752865
106	876537913	VIRKSOMHET	1	2022-07-21 09:34:35.752865
107	890597928	VIRKSOMHET	2	2022-07-21 09:34:35.752865
108	842982051	VIRKSOMHET	2	2022-07-21 09:34:35.752865
109	842389667	VIRKSOMHET	2	2022-07-21 09:34:35.752865
110	820004072	VIRKSOMHET	2	2022-07-21 09:34:35.831632
111	897688257	VIRKSOMHET	0	2022-07-21 09:34:35.831632
112	837534390	VIRKSOMHET	1	2022-07-21 09:34:35.831632
113	808543637	VIRKSOMHET	2	2022-07-21 09:34:35.831632
114	870201888	VIRKSOMHET	0	2022-07-21 09:34:35.887995
115	817311070	VIRKSOMHET	1	2022-07-21 09:34:35.887995
116	868012776	VIRKSOMHET	2	2022-07-21 09:34:35.887995
117	896429753	VIRKSOMHET	0	2022-07-21 09:34:35.887995
118	851603425	VIRKSOMHET	1	2022-07-21 09:34:35.887995
119	827443317	VIRKSOMHET	2	2022-07-21 09:34:35.887995
120	833362642	VIRKSOMHET	0	2022-07-21 09:34:35.937595
121	882069408	VIRKSOMHET	1	2022-07-21 09:34:35.937595
122	863878944	VIRKSOMHET	3	2022-07-21 09:34:35.937595
123	866558221	VIRKSOMHET	1	2022-07-21 09:34:35.937595
124	868767855	VIRKSOMHET	2	2022-07-21 09:34:35.980044
125	875885300	VIRKSOMHET	1	2022-07-21 09:34:35.980044
126	842216735	VIRKSOMHET	0	2022-07-21 09:34:35.980044
127	856920437	VIRKSOMHET	3	2022-07-21 09:34:35.980044
128	830858963	VIRKSOMHET	0	2022-07-21 09:34:35.980044
129	812434114	VIRKSOMHET	0	2022-07-21 09:34:36.026482
130	847041353	VIRKSOMHET	0	2022-07-21 09:34:36.026482
131	803269327	VIRKSOMHET	1	2022-07-21 09:34:36.026482
132	843457384	VIRKSOMHET	3	2022-07-21 09:34:36.026482
133	818306281	VIRKSOMHET	1	2022-07-21 09:34:36.085339
134	844449510	VIRKSOMHET	3	2022-07-21 09:34:36.085339
135	867177223	VIRKSOMHET	2	2022-07-21 09:34:36.085339
136	883963814	VIRKSOMHET	1	2022-07-21 09:34:36.085339
137	886253015	VIRKSOMHET	1	2022-07-21 09:34:36.13995
138	895281822	VIRKSOMHET	3	2022-07-21 09:34:36.13995
139	840533481	VIRKSOMHET	0	2022-07-21 09:34:36.13995
140	839216776	VIRKSOMHET	3	2022-07-21 09:34:36.13995
141	803533948	VIRKSOMHET	2	2022-07-21 09:34:36.175052
142	827095124	VIRKSOMHET	2	2022-07-21 09:34:36.175052
143	808251981	VIRKSOMHET	1	2022-07-21 09:34:36.198414
144	817358823	VIRKSOMHET	3	2022-07-21 09:34:36.224836
145	871910327	VIRKSOMHET	0	2022-07-21 09:34:36.224836
146	866587133	VIRKSOMHET	3	2022-07-21 09:34:36.266879
147	842840788	VIRKSOMHET	3	2022-07-21 09:34:36.266879
148	812781923	VIRKSOMHET	1	2022-07-21 09:34:36.349754
149	804058381	VIRKSOMHET	0	2022-07-21 09:34:36.349754
150	811423248	VIRKSOMHET	1	2022-07-21 09:34:36.349754
151	840837641	VIRKSOMHET	2	2022-07-21 09:34:36.349754
152	818816392	VIRKSOMHET	1	2022-07-21 09:34:36.349754
153	806494928	VIRKSOMHET	3	2022-07-21 09:34:36.415375
154	893055618	VIRKSOMHET	1	2022-07-21 09:34:36.415375
155	875340822	VIRKSOMHET	0	2022-07-21 09:34:36.415375
156	818463756	VIRKSOMHET	0	2022-07-21 09:34:36.415375
157	884152302	VIRKSOMHET	0	2022-07-21 09:34:36.415375
158	849742742	VIRKSOMHET	2	2022-07-21 09:34:36.47184
159	804979817	VIRKSOMHET	2	2022-07-21 09:34:36.47184
160	814190896	VIRKSOMHET	2	2022-07-21 09:34:36.47184
161	822331640	VIRKSOMHET	2	2022-07-21 09:34:36.47184
162	862678317	VIRKSOMHET	2	2022-07-21 09:34:36.47184
163	831093023	VIRKSOMHET	0	2022-07-21 09:34:36.553889
164	874226454	VIRKSOMHET	0	2022-07-21 09:34:36.553889
165	832436811	VIRKSOMHET	1	2022-07-21 09:34:36.553889
166	838432048	VIRKSOMHET	3	2022-07-21 09:34:36.553889
167	870022919	VIRKSOMHET	0	2022-07-21 09:34:36.553889
168	879268334	VIRKSOMHET	1	2022-07-21 09:34:36.620902
169	806599852	VIRKSOMHET	2	2022-07-21 09:34:36.620902
170	863181199	VIRKSOMHET	2	2022-07-21 09:34:36.620902
171	863767568	VIRKSOMHET	1	2022-07-21 09:34:36.620902
172	844014636	VIRKSOMHET	1	2022-07-21 09:34:36.674854
173	866404710	VIRKSOMHET	0	2022-07-21 09:34:36.674854
174	833129946	VIRKSOMHET	3	2022-07-21 09:34:36.674854
175	846977998	VIRKSOMHET	2	2022-07-21 09:34:36.674854
176	811030348	VIRKSOMHET	2	2022-07-21 09:34:36.674854
177	890815907	VIRKSOMHET	1	2022-07-21 09:34:36.674854
178	822694021	VIRKSOMHET	3	2022-07-21 09:34:36.719608
179	852558904	VIRKSOMHET	2	2022-07-21 09:34:36.719608
180	822874914	VIRKSOMHET	1	2022-07-21 09:34:36.719608
181	866646453	VIRKSOMHET	1	2022-07-21 09:34:36.719608
182	881021956	VIRKSOMHET	0	2022-07-21 09:34:36.766241
183	899291735	VIRKSOMHET	2	2022-07-21 09:34:36.766241
184	867918928	VIRKSOMHET	2	2022-07-21 09:34:36.766241
185	823439458	VIRKSOMHET	3	2022-07-21 09:34:36.766241
186	837805347	VIRKSOMHET	2	2022-07-21 09:34:36.766241
187	805499088	VIRKSOMHET	1	2022-07-21 09:34:36.766241
188	845822610	VIRKSOMHET	1	2022-07-21 09:34:36.820576
189	841405633	VIRKSOMHET	2	2022-07-21 09:34:36.820576
190	889675608	VIRKSOMHET	3	2022-07-21 09:34:36.820576
191	899025387	VIRKSOMHET	0	2022-07-21 09:34:36.820576
192	863280835	VIRKSOMHET	2	2022-07-21 09:34:36.862179
193	860629673	VIRKSOMHET	0	2022-07-21 09:34:36.862179
194	833667497	VIRKSOMHET	3	2022-07-21 09:34:36.862179
195	842471044	VIRKSOMHET	0	2022-07-21 09:34:36.862179
196	861459803	VIRKSOMHET	0	2022-07-21 09:34:36.900809
197	812926032	VIRKSOMHET	0	2022-07-21 09:34:36.900809
198	871631319	VIRKSOMHET	2	2022-07-21 09:34:36.900809
199	865439281	VIRKSOMHET	3	2022-07-21 09:34:36.951097
200	824210548	VIRKSOMHET	0	2022-07-21 09:34:36.951097
201	805486005	VIRKSOMHET	0	2022-07-21 09:34:36.951097
202	832448472	VIRKSOMHET	1	2022-07-21 09:34:36.951097
203	805820685	VIRKSOMHET	2	2022-07-21 09:34:36.990931
204	883768894	VIRKSOMHET	2	2022-07-21 09:34:36.990931
205	856903021	VIRKSOMHET	3	2022-07-21 09:34:36.990931
206	850012745	VIRKSOMHET	2	2022-07-21 09:34:36.990931
207	820149848	VIRKSOMHET	1	2022-07-21 09:34:37.033151
208	822705108	VIRKSOMHET	0	2022-07-21 09:34:37.033151
209	857573851	VIRKSOMHET	3	2022-07-21 09:34:37.074545
210	856078198	VIRKSOMHET	2	2022-07-21 09:34:37.074545
211	859225721	VIRKSOMHET	3	2022-07-21 09:34:37.074545
212	873879874	VIRKSOMHET	2	2022-07-21 09:34:37.119498
213	890065285	VIRKSOMHET	1	2022-07-21 09:34:37.119498
214	893423280	VIRKSOMHET	2	2022-07-21 09:34:37.119498
215	816273126	VIRKSOMHET	0	2022-07-21 09:34:37.190544
216	874977909	VIRKSOMHET	1	2022-07-21 09:34:37.190544
217	888632161	VIRKSOMHET	1	2022-07-21 09:34:37.190544
218	852452427	VIRKSOMHET	3	2022-07-21 09:34:37.224691
219	807389236	VIRKSOMHET	3	2022-07-21 09:34:37.224691
220	833163111	VIRKSOMHET	3	2022-07-21 09:34:37.224691
221	813080832	VIRKSOMHET	1	2022-07-21 09:34:37.224691
222	896489260	VIRKSOMHET	1	2022-07-21 09:34:37.286057
223	845881839	VIRKSOMHET	0	2022-07-21 09:34:37.286057
224	898157169	VIRKSOMHET	2	2022-07-21 09:34:37.286057
225	882940656	VIRKSOMHET	3	2022-07-21 09:34:37.286057
226	887589106	VIRKSOMHET	3	2022-07-21 09:34:37.286057
227	856439808	VIRKSOMHET	2	2022-07-21 09:34:37.346377
228	869911712	VIRKSOMHET	0	2022-07-21 09:34:37.346377
229	836420677	VIRKSOMHET	1	2022-07-21 09:34:37.346377
230	810521018	VIRKSOMHET	0	2022-07-21 09:34:37.346377
231	863021621	VIRKSOMHET	0	2022-07-21 09:34:37.346377
232	846289494	VIRKSOMHET	1	2022-07-21 09:34:37.423306
233	834191416	VIRKSOMHET	2	2022-07-21 09:34:37.423306
234	837420340	VIRKSOMHET	1	2022-07-21 09:34:37.423306
235	871949311	VIRKSOMHET	3	2022-07-21 09:34:37.423306
236	821633142	VIRKSOMHET	1	2022-07-21 09:34:37.423306
237	893463166	VIRKSOMHET	0	2022-07-21 09:34:37.474542
238	833218825	VIRKSOMHET	0	2022-07-21 09:34:37.474542
239	807456455	VIRKSOMHET	0	2022-07-21 09:34:37.474542
240	821381486	VIRKSOMHET	3	2022-07-21 09:34:37.474542
241	814324199	VIRKSOMHET	0	2022-07-21 09:34:37.474542
242	805904949	VIRKSOMHET	0	2022-07-21 09:34:37.474542
243	813242515	VIRKSOMHET	2	2022-07-21 09:34:37.474542
244	839415843	VIRKSOMHET	2	2022-07-21 09:34:37.517838
245	804234371	VIRKSOMHET	3	2022-07-21 09:34:37.517838
246	816585946	VIRKSOMHET	0	2022-07-21 09:34:37.517838
247	824097835	VIRKSOMHET	0	2022-07-21 09:34:37.517838
248	880538674	VIRKSOMHET	0	2022-07-21 09:34:37.517838
249	875775705	VIRKSOMHET	3	2022-07-21 09:34:37.517838
250	877421692	VIRKSOMHET	0	2022-07-21 09:34:37.517838
251	871547736	VIRKSOMHET	2	2022-07-21 09:34:37.561492
252	857653378	VIRKSOMHET	3	2022-07-21 09:34:37.561492
253	829980700	VIRKSOMHET	0	2022-07-21 09:34:37.561492
254	852627790	VIRKSOMHET	3	2022-07-21 09:34:37.561492
255	865978526	VIRKSOMHET	2	2022-07-21 09:34:37.561492
256	840145629	VIRKSOMHET	2	2022-07-21 09:34:37.596777
257	875016141	VIRKSOMHET	1	2022-07-21 09:34:37.596777
258	869419134	VIRKSOMHET	2	2022-07-21 09:34:37.596777
259	813944600	VIRKSOMHET	3	2022-07-21 09:34:37.596777
260	885600454	VIRKSOMHET	2	2022-07-21 09:34:37.647623
261	877550656	VIRKSOMHET	0	2022-07-21 09:34:37.647623
262	804227830	VIRKSOMHET	0	2022-07-21 09:34:37.695993
263	858956619	VIRKSOMHET	0	2022-07-21 09:34:37.695993
264	865153645	VIRKSOMHET	3	2022-07-21 09:34:37.695993
265	817941723	VIRKSOMHET	3	2022-07-21 09:34:37.717062
266	811667993	VIRKSOMHET	2	2022-07-21 09:34:37.717062
267	859462534	VIRKSOMHET	2	2022-07-21 09:34:37.717062
268	822317092	VIRKSOMHET	3	2022-07-21 09:34:37.717062
269	877772835	VIRKSOMHET	2	2022-07-21 09:34:37.760161
270	846495295	VIRKSOMHET	0	2022-07-21 09:34:37.760161
271	804775869	VIRKSOMHET	1	2022-07-21 09:34:37.796164
272	831030012	VIRKSOMHET	1	2022-07-21 09:34:37.796164
273	802809462	VIRKSOMHET	0	2022-07-21 09:34:37.796164
274	896200151	VIRKSOMHET	2	2022-07-21 09:34:37.796164
275	873610100	VIRKSOMHET	2	2022-07-21 09:34:37.796164
276	847931581	VIRKSOMHET	3	2022-07-21 09:34:37.837755
277	870810427	VIRKSOMHET	2	2022-07-21 09:34:37.837755
278	816457914	VIRKSOMHET	2	2022-07-21 09:34:37.897061
279	816760477	VIRKSOMHET	1	2022-07-21 09:34:37.897061
280	821449527	VIRKSOMHET	2	2022-07-21 09:34:37.897061
281	897412997	VIRKSOMHET	1	2022-07-21 09:34:37.897061
282	801856356	VIRKSOMHET	1	2022-07-21 09:34:37.950872
283	898170941	VIRKSOMHET	0	2022-07-21 09:34:37.950872
284	884390144	VIRKSOMHET	0	2022-07-21 09:34:37.950872
285	894424841	VIRKSOMHET	1	2022-07-21 09:34:37.950872
286	828972512	VIRKSOMHET	3	2022-07-21 09:34:37.950872
287	815082581	VIRKSOMHET	0	2022-07-21 09:34:37.987347
288	887159012	VIRKSOMHET	3	2022-07-21 09:34:37.987347
289	829493874	VIRKSOMHET	2	2022-07-21 09:34:37.987347
290	814929193	VIRKSOMHET	3	2022-07-21 09:34:37.987347
291	859907302	VIRKSOMHET	3	2022-07-21 09:34:37.987347
292	895124699	VIRKSOMHET	2	2022-07-21 09:34:37.987347
293	813239227	VIRKSOMHET	1	2022-07-21 09:34:38.051668
294	840430296	VIRKSOMHET	3	2022-07-21 09:34:38.051668
295	858726639	VIRKSOMHET	0	2022-07-21 09:34:38.051668
296	823234800	VIRKSOMHET	3	2022-07-21 09:34:38.080469
297	874361830	VIRKSOMHET	1	2022-07-21 09:34:38.080469
298	808481735	VIRKSOMHET	1	2022-07-21 09:34:38.080469
299	860499175	VIRKSOMHET	0	2022-07-21 09:34:38.080469
300	892697142	VIRKSOMHET	0	2022-07-21 09:34:38.080469
301	826727890	VIRKSOMHET	2	2022-07-21 09:34:38.080469
302	895582762	VIRKSOMHET	0	2022-07-21 09:34:38.161659
303	814663914	VIRKSOMHET	2	2022-07-21 09:34:38.161659
304	887191975	VIRKSOMHET	3	2022-07-21 09:34:38.161659
305	856729012	VIRKSOMHET	2	2022-07-21 09:34:38.161659
306	816248533	VIRKSOMHET	1	2022-07-21 09:34:38.161659
307	847253663	VIRKSOMHET	3	2022-07-21 09:34:38.161659
308	851556995	VIRKSOMHET	2	2022-07-21 09:34:38.161659
309	897000352	VIRKSOMHET	1	2022-07-21 09:34:38.213963
310	891267708	VIRKSOMHET	0	2022-07-21 09:34:38.213963
311	868369009	VIRKSOMHET	3	2022-07-21 09:34:38.213963
312	836786224	VIRKSOMHET	1	2022-07-21 09:34:38.213963
313	800910790	VIRKSOMHET	3	2022-07-21 09:34:38.213963
314	847922087	VIRKSOMHET	1	2022-07-21 09:34:38.258718
315	882737279	VIRKSOMHET	2	2022-07-21 09:34:38.258718
316	817612413	VIRKSOMHET	1	2022-07-21 09:34:38.258718
317	857680168	VIRKSOMHET	2	2022-07-21 09:34:38.258718
318	878624841	VIRKSOMHET	1	2022-07-21 09:34:38.258718
319	867183919	VIRKSOMHET	3	2022-07-21 09:34:38.258718
320	824306551	VIRKSOMHET	1	2022-07-21 09:34:38.307579
321	812929350	VIRKSOMHET	3	2022-07-21 09:34:38.307579
322	890735735	VIRKSOMHET	0	2022-07-21 09:34:38.307579
323	894341616	VIRKSOMHET	2	2022-07-21 09:34:38.307579
324	845690609	VIRKSOMHET	0	2022-07-21 09:34:38.307579
325	884945724	VIRKSOMHET	3	2022-07-21 09:34:38.307579
326	820865124	VIRKSOMHET	3	2022-07-21 09:34:38.358452
327	870514368	VIRKSOMHET	1	2022-07-21 09:34:38.358452
328	833643869	VIRKSOMHET	1	2022-07-21 09:34:38.358452
329	807702188	VIRKSOMHET	2	2022-07-21 09:34:38.358452
330	820638689	VIRKSOMHET	1	2022-07-21 09:34:38.358452
331	843380901	VIRKSOMHET	1	2022-07-21 09:34:38.358452
332	832951634	VIRKSOMHET	2	2022-07-21 09:34:38.42665
333	833677243	VIRKSOMHET	3	2022-07-21 09:34:38.42665
334	873656323	VIRKSOMHET	3	2022-07-21 09:34:38.42665
335	859159231	VIRKSOMHET	0	2022-07-21 09:34:38.42665
336	868067017	VIRKSOMHET	0	2022-07-21 09:34:38.42665
337	856435712	VIRKSOMHET	2	2022-07-21 09:34:38.42665
338	888937591	VIRKSOMHET	0	2022-07-21 09:34:38.484695
339	873906284	VIRKSOMHET	2	2022-07-21 09:34:38.484695
340	855150484	VIRKSOMHET	0	2022-07-21 09:34:38.484695
341	836365546	VIRKSOMHET	0	2022-07-21 09:34:38.484695
342	822564929	VIRKSOMHET	3	2022-07-21 09:34:38.484695
343	833204596	VIRKSOMHET	0	2022-07-21 09:34:38.484695
344	863592645	VIRKSOMHET	2	2022-07-21 09:34:38.484695
345	865956727	VIRKSOMHET	2	2022-07-21 09:34:38.530207
346	807629933	VIRKSOMHET	3	2022-07-21 09:34:38.530207
347	832454631	VIRKSOMHET	0	2022-07-21 09:34:38.530207
348	823356725	VIRKSOMHET	0	2022-07-21 09:34:38.530207
349	800824855	VIRKSOMHET	0	2022-07-21 09:34:38.530207
350	894510083	VIRKSOMHET	1	2022-07-21 09:34:38.530207
351	815854671	VIRKSOMHET	0	2022-07-21 09:34:38.530207
352	876401827	VIRKSOMHET	2	2022-07-21 09:34:38.530207
353	845066027	VIRKSOMHET	1	2022-07-21 09:34:38.598757
354	815406101	VIRKSOMHET	2	2022-07-21 09:34:38.598757
355	866878310	VIRKSOMHET	3	2022-07-21 09:34:38.598757
356	830803739	VIRKSOMHET	2	2022-07-21 09:34:38.598757
357	805933483	VIRKSOMHET	0	2022-07-21 09:34:38.598757
358	868252144	VIRKSOMHET	3	2022-07-21 09:34:38.598757
359	828744326	VIRKSOMHET	0	2022-07-21 09:34:38.598757
360	830122600	VIRKSOMHET	1	2022-07-21 09:34:38.598757
361	813147327	VIRKSOMHET	2	2022-07-21 09:34:38.598757
362	846250295	VIRKSOMHET	3	2022-07-21 09:34:38.636268
363	898250721	VIRKSOMHET	1	2022-07-21 09:34:38.636268
364	813697349	VIRKSOMHET	0	2022-07-21 09:34:38.636268
365	863104800	VIRKSOMHET	1	2022-07-21 09:34:38.636268
366	897979593	VIRKSOMHET	0	2022-07-21 09:34:38.636268
367	860772161	VIRKSOMHET	3	2022-07-21 09:34:38.636268
368	808002552	VIRKSOMHET	1	2022-07-21 09:34:38.683693
369	876394411	VIRKSOMHET	1	2022-07-21 09:34:38.683693
370	846214156	VIRKSOMHET	1	2022-07-21 09:34:38.683693
371	850015354	VIRKSOMHET	3	2022-07-21 09:34:38.683693
372	805145991	VIRKSOMHET	0	2022-07-21 09:34:38.683693
373	853879838	VIRKSOMHET	2	2022-07-21 09:34:38.729338
374	882939801	VIRKSOMHET	3	2022-07-21 09:34:38.729338
375	859605190	VIRKSOMHET	2	2022-07-21 09:34:38.729338
376	891814367	VIRKSOMHET	2	2022-07-21 09:34:38.729338
377	875021136	VIRKSOMHET	2	2022-07-21 09:34:38.786197
378	825379831	VIRKSOMHET	1	2022-07-21 09:34:38.786197
379	800469195	VIRKSOMHET	0	2022-07-21 09:34:38.786197
380	871244244	VIRKSOMHET	1	2022-07-21 09:34:38.786197
381	837133219	VIRKSOMHET	2	2022-07-21 09:34:38.829568
382	855964219	VIRKSOMHET	0	2022-07-21 09:34:38.829568
383	838273484	VIRKSOMHET	3	2022-07-21 09:34:38.829568
384	893483616	VIRKSOMHET	2	2022-07-21 09:34:38.829568
385	891497759	VIRKSOMHET	1	2022-07-21 09:34:38.854198
386	888247901	VIRKSOMHET	1	2022-07-21 09:34:38.854198
387	883590490	VIRKSOMHET	3	2022-07-21 09:34:38.854198
388	804908767	VIRKSOMHET	2	2022-07-21 09:34:38.854198
389	851919134	VIRKSOMHET	3	2022-07-21 09:34:38.854198
390	813682750	VIRKSOMHET	2	2022-07-21 09:34:38.893436
391	875544956	VIRKSOMHET	2	2022-07-21 09:34:38.919263
392	889472231	VIRKSOMHET	1	2022-07-21 09:34:38.919263
393	875631634	VIRKSOMHET	2	2022-07-21 09:34:38.919263
394	856007783	VIRKSOMHET	1	2022-07-21 09:34:38.919263
395	844760467	VIRKSOMHET	1	2022-07-21 09:34:38.919263
396	863256691	VIRKSOMHET	2	2022-07-21 09:34:38.944189
397	851705582	VIRKSOMHET	2	2022-07-21 09:34:38.944189
398	854298834	VIRKSOMHET	2	2022-07-21 09:34:38.944189
399	836216435	VIRKSOMHET	3	2022-07-21 09:34:38.944189
400	893017297	VIRKSOMHET	0	2022-07-21 09:34:38.983517
401	841372032	VIRKSOMHET	1	2022-07-21 09:34:38.983517
402	862589424	VIRKSOMHET	0	2022-07-21 09:34:38.983517
403	871501781	VIRKSOMHET	0	2022-07-21 09:34:38.983517
404	880977356	VIRKSOMHET	1	2022-07-21 09:34:38.983517
405	859708655	VIRKSOMHET	0	2022-07-21 09:34:38.983517
406	837130075	VIRKSOMHET	0	2022-07-21 09:34:39.049613
407	803170681	VIRKSOMHET	1	2022-07-21 09:34:39.049613
408	875018446	VIRKSOMHET	3	2022-07-21 09:34:39.049613
409	872251225	VIRKSOMHET	2	2022-07-21 09:34:39.086058
410	889927472	VIRKSOMHET	0	2022-07-21 09:34:39.086058
411	850310272	VIRKSOMHET	2	2022-07-21 09:34:39.086058
412	878277970	VIRKSOMHET	0	2022-07-21 09:34:39.086058
413	811324382	VIRKSOMHET	2	2022-07-21 09:34:39.086058
414	878265174	VIRKSOMHET	0	2022-07-21 09:34:39.1136
415	803799726	VIRKSOMHET	0	2022-07-21 09:34:39.1136
416	827344157	VIRKSOMHET	3	2022-07-21 09:34:39.1136
417	868610918	VIRKSOMHET	2	2022-07-21 09:34:39.1136
418	891144647	VIRKSOMHET	3	2022-07-21 09:34:39.1136
419	874750888	VIRKSOMHET	1	2022-07-21 09:34:39.1136
420	879572863	VIRKSOMHET	0	2022-07-21 09:34:39.146082
421	816719384	VIRKSOMHET	3	2022-07-21 09:34:39.146082
422	823372812	VIRKSOMHET	0	2022-07-21 09:34:39.146082
423	872671153	VIRKSOMHET	1	2022-07-21 09:34:39.218268
424	837782686	VIRKSOMHET	0	2022-07-21 09:34:39.218268
425	856373244	VIRKSOMHET	2	2022-07-21 09:34:39.253336
426	802319687	VIRKSOMHET	2	2022-07-21 09:34:39.253336
427	882221112	VIRKSOMHET	1	2022-07-21 09:34:39.253336
428	825823538	VIRKSOMHET	0	2022-07-21 09:34:39.253336
429	840744367	VIRKSOMHET	0	2022-07-21 09:34:39.253336
430	807485242	VIRKSOMHET	2	2022-07-21 09:34:39.253336
431	878321914	VIRKSOMHET	3	2022-07-21 09:34:39.253336
432	886892017	VIRKSOMHET	1	2022-07-21 09:34:39.305373
433	871623349	VIRKSOMHET	0	2022-07-21 09:34:39.305373
434	864986459	VIRKSOMHET	3	2022-07-21 09:34:39.305373
435	849227492	VIRKSOMHET	3	2022-07-21 09:34:39.305373
436	850910144	VIRKSOMHET	3	2022-07-21 09:34:39.36315
437	869658223	VIRKSOMHET	2	2022-07-21 09:34:39.36315
438	866431270	VIRKSOMHET	3	2022-07-21 09:34:39.36315
439	858356342	VIRKSOMHET	1	2022-07-21 09:34:39.36315
440	852467356	VIRKSOMHET	1	2022-07-21 09:34:39.36315
441	898657961	VIRKSOMHET	2	2022-07-21 09:34:39.36315
442	846849579	VIRKSOMHET	1	2022-07-21 09:34:39.36315
443	873579899	VIRKSOMHET	0	2022-07-21 09:34:39.412494
444	843035298	VIRKSOMHET	3	2022-07-21 09:34:39.412494
445	858836952	VIRKSOMHET	1	2022-07-21 09:34:39.412494
446	805709917	VIRKSOMHET	3	2022-07-21 09:34:39.412494
447	808479485	VIRKSOMHET	1	2022-07-21 09:34:39.412494
448	838878962	VIRKSOMHET	2	2022-07-21 09:34:39.412494
449	885625328	VIRKSOMHET	3	2022-07-21 09:34:39.460739
450	837527996	VIRKSOMHET	2	2022-07-21 09:34:39.460739
451	844848494	VIRKSOMHET	3	2022-07-21 09:34:39.460739
452	825573136	VIRKSOMHET	1	2022-07-21 09:34:39.460739
453	809036318	VIRKSOMHET	1	2022-07-21 09:34:39.460739
454	800223332	VIRKSOMHET	1	2022-07-21 09:34:39.460739
455	878112453	VIRKSOMHET	0	2022-07-21 09:34:39.460739
456	893781546	VIRKSOMHET	0	2022-07-21 09:34:39.460739
457	818658010	VIRKSOMHET	2	2022-07-21 09:34:39.506304
458	862270603	VIRKSOMHET	2	2022-07-21 09:34:39.506304
459	812325897	VIRKSOMHET	1	2022-07-21 09:34:39.506304
460	817554736	VIRKSOMHET	3	2022-07-21 09:34:39.506304
461	884291457	VIRKSOMHET	0	2022-07-21 09:34:39.506304
462	890910485	VIRKSOMHET	2	2022-07-21 09:34:39.506304
463	810677960	VIRKSOMHET	3	2022-07-21 09:34:39.506304
464	830621787	VIRKSOMHET	2	2022-07-21 09:34:39.506304
465	874792210	VIRKSOMHET	0	2022-07-21 09:34:39.506304
466	828718942	VIRKSOMHET	2	2022-07-21 09:34:39.506304
467	846277869	VIRKSOMHET	0	2022-07-21 09:34:39.506304
468	809316543	VIRKSOMHET	3	2022-07-21 09:34:39.54967
469	846821438	VIRKSOMHET	0	2022-07-21 09:34:39.54967
470	836005340	VIRKSOMHET	2	2022-07-21 09:34:39.54967
471	869069081	VIRKSOMHET	1	2022-07-21 09:34:39.54967
472	824870495	VIRKSOMHET	0	2022-07-21 09:34:39.54967
473	821850314	VIRKSOMHET	2	2022-07-21 09:34:39.54967
474	895629317	VIRKSOMHET	0	2022-07-21 09:34:39.54967
475	854843256	VIRKSOMHET	1	2022-07-21 09:34:39.54967
476	825397589	VIRKSOMHET	0	2022-07-21 09:34:39.54967
477	856901774	VIRKSOMHET	3	2022-07-21 09:34:39.603375
478	886566656	VIRKSOMHET	1	2022-07-21 09:34:39.603375
479	868634250	VIRKSOMHET	2	2022-07-21 09:34:39.603375
480	827178297	VIRKSOMHET	3	2022-07-21 09:34:39.603375
481	889901026	VIRKSOMHET	2	2022-07-21 09:34:39.603375
482	860932226	VIRKSOMHET	3	2022-07-21 09:34:39.603375
483	883640440	VIRKSOMHET	0	2022-07-21 09:34:39.652276
484	899511765	VIRKSOMHET	1	2022-07-21 09:34:39.652276
485	826671551	VIRKSOMHET	3	2022-07-21 09:34:39.652276
486	838991015	VIRKSOMHET	3	2022-07-21 09:34:39.652276
487	831768843	VIRKSOMHET	3	2022-07-21 09:34:39.652276
488	803324193	VIRKSOMHET	1	2022-07-21 09:34:39.652276
489	827269180	VIRKSOMHET	1	2022-07-21 09:34:39.694816
490	806938796	VIRKSOMHET	0	2022-07-21 09:34:39.694816
491	817130185	VIRKSOMHET	2	2022-07-21 09:34:39.694816
492	810402680	VIRKSOMHET	0	2022-07-21 09:34:39.726786
493	887841956	VIRKSOMHET	0	2022-07-21 09:34:39.726786
494	897336611	VIRKSOMHET	1	2022-07-21 09:34:39.726786
495	858728795	VIRKSOMHET	1	2022-07-21 09:34:39.726786
496	880050743	VIRKSOMHET	2	2022-07-21 09:34:39.761857
497	871161662	VIRKSOMHET	2	2022-07-21 09:34:39.761857
498	862924848	VIRKSOMHET	0	2022-07-21 09:34:39.761857
499	895031114	VIRKSOMHET	3	2022-07-21 09:34:39.761857
500	815517829	VIRKSOMHET	2	2022-07-21 09:34:39.761857
501	836666246	VIRKSOMHET	0	2022-07-21 09:34:39.761857
502	845715533	VIRKSOMHET	0	2022-07-21 09:34:39.801171
503	897156462	VIRKSOMHET	1	2022-07-21 09:34:39.801171
504	890815244	VIRKSOMHET	0	2022-07-21 09:34:39.801171
505	866562589	VIRKSOMHET	0	2022-07-21 09:34:39.801171
506	875322390	VIRKSOMHET	3	2022-07-21 09:34:39.801171
507	870376312	VIRKSOMHET	2	2022-07-21 09:34:39.827761
508	863074238	VIRKSOMHET	3	2022-07-21 09:34:39.827761
509	873535604	VIRKSOMHET	2	2022-07-21 09:34:39.827761
510	820029647	VIRKSOMHET	2	2022-07-21 09:34:39.827761
511	825514130	VIRKSOMHET	3	2022-07-21 09:34:39.827761
512	815801592	VIRKSOMHET	0	2022-07-21 09:34:39.827761
\.


--
-- Name: sykefravar_statistikk_grunnlag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_grunnlag_id_seq', 1, false);


--
-- Name: sykefravar_statistikk_land_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_land_id_seq', 96, true);


--
-- Name: sykefravar_statistikk_naring_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_naring_id_seq', 96, true);


--
-- Name: sykefravar_statistikk_naringsundergruppe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_naringsundergruppe_id_seq', 96, true);


--
-- Name: sykefravar_statistikk_sektor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_sektor_id_seq', 268, true);


--
-- Name: sykefravar_statistikk_virksomhet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sykefravar_statistikk_virksomhet_id_seq', 512, true);


--
-- Name: virksomhet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.virksomhet_id_seq', 509, true);


--
-- Name: virksomhet_metadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.virksomhet_metadata_id_seq', 512, true);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: ia_sak_hendelse ia_sak_hendelse_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ia_sak_hendelse
    ADD CONSTRAINT ia_sak_hendelse_pkey PRIMARY KEY (id);


--
-- Name: ia_sak ia_sak_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ia_sak
    ADD CONSTRAINT ia_sak_pkey PRIMARY KEY (saksnummer);


--
-- Name: sykefravar_statistikk_land land_periode; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sykefravar_statistikk_land
    ADD CONSTRAINT land_periode UNIQUE (land, arstall, kvartal);


--
-- Name: sykefravar_statistikk_naring naring_periode; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sykefravar_statistikk_naring
    ADD CONSTRAINT naring_periode UNIQUE (naring, arstall, kvartal);


--
-- Name: naring naring_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.naring
    ADD CONSTRAINT naring_pkey PRIMARY KEY (kode);


--
-- Name: sykefravar_statistikk_naringsundergruppe naringsundergruppe_periode; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sykefravar_statistikk_naringsundergruppe
    ADD CONSTRAINT naringsundergruppe_periode UNIQUE (naringsundergruppe, arstall, kvartal);


--
-- Name: sykefravar_statistikk_sektor sektor_periode; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sykefravar_statistikk_sektor
    ADD CONSTRAINT sektor_periode UNIQUE (sektor_kode, arstall, kvartal);


--
-- Name: sektor sektor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sektor
    ADD CONSTRAINT sektor_pkey PRIMARY KEY (kode);


--
-- Name: sykefravar_statistikk_virksomhet sykefravar_periode; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sykefravar_statistikk_virksomhet
    ADD CONSTRAINT sykefravar_periode UNIQUE (orgnr, arstall, kvartal);


--
-- Name: sykefravar_statistikk_grunnlag sykefravar_statistikk_grunnlag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sykefravar_statistikk_grunnlag
    ADD CONSTRAINT sykefravar_statistikk_grunnlag_pkey PRIMARY KEY (id);


--
-- Name: sykefravar_statistikk_land sykefravar_statistikk_land_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sykefravar_statistikk_land
    ADD CONSTRAINT sykefravar_statistikk_land_pkey PRIMARY KEY (id);


--
-- Name: sykefravar_statistikk_naring sykefravar_statistikk_naring_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sykefravar_statistikk_naring
    ADD CONSTRAINT sykefravar_statistikk_naring_pkey PRIMARY KEY (id);


--
-- Name: sykefravar_statistikk_naringsundergruppe sykefravar_statistikk_naringsundergruppe_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sykefravar_statistikk_naringsundergruppe
    ADD CONSTRAINT sykefravar_statistikk_naringsundergruppe_pkey PRIMARY KEY (id);


--
-- Name: sykefravar_statistikk_sektor sykefravar_statistikk_sektor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sykefravar_statistikk_sektor
    ADD CONSTRAINT sykefravar_statistikk_sektor_pkey PRIMARY KEY (id);


--
-- Name: sykefravar_statistikk_virksomhet sykefravar_statistikk_virksomhet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sykefravar_statistikk_virksomhet
    ADD CONSTRAINT sykefravar_statistikk_virksomhet_pkey PRIMARY KEY (id);


--
-- Name: virksomhet_statistikk_metadata virksomhet_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.virksomhet_statistikk_metadata
    ADD CONSTRAINT virksomhet_metadata_pkey PRIMARY KEY (id);


--
-- Name: virksomhet_naring virksomhet_naring_unik; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.virksomhet_naring
    ADD CONSTRAINT virksomhet_naring_unik UNIQUE (virksomhet, narings_kode);


--
-- Name: virksomhet virksomhet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.virksomhet
    ADD CONSTRAINT virksomhet_pkey PRIMARY KEY (id);


--
-- Name: virksomhet_statistikk_metadata virksomhet_statistikk_metadata_unik_orgnr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.virksomhet_statistikk_metadata
    ADD CONSTRAINT virksomhet_statistikk_metadata_unik_orgnr UNIQUE (orgnr);


--
-- Name: virksomhet virksomhet_unik_orgnr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.virksomhet
    ADD CONSTRAINT virksomhet_unik_orgnr UNIQUE (orgnr);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: idx_ia_sak_hendelse_orgnr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ia_sak_hendelse_orgnr ON public.ia_sak_hendelse USING btree (orgnr);


--
-- Name: idx_ia_sak_hendelse_saksnummer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ia_sak_hendelse_saksnummer ON public.ia_sak_hendelse USING btree (saksnummer);


--
-- Name: idx_ia_sak_orgnr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ia_sak_orgnr ON public.ia_sak USING btree (orgnr);


--
-- Name: idx_ia_sak_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ia_sak_status ON public.ia_sak USING btree (status);


--
-- Name: idx_land_sykefravar_statistikk_land; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_land_sykefravar_statistikk_land ON public.sykefravar_statistikk_land USING btree (land);


--
-- Name: idx_naring_sykefravar_statistikk_naring; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_naring_sykefravar_statistikk_naring ON public.sykefravar_statistikk_naring USING btree (naring);


--
-- Name: idx_naringsundergruppe_sykefravar_statistikk_naringsundergruppe; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_naringsundergruppe_sykefravar_statistikk_naringsundergruppe ON public.sykefravar_statistikk_naringsundergruppe USING btree (naringsundergruppe);


--
-- Name: idx_orgnr_sykefravar_statistikk_virksomhet; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orgnr_sykefravar_statistikk_virksomhet ON public.sykefravar_statistikk_virksomhet USING btree (orgnr);


--
-- Name: idx_orgnr_virksomhet_statistikk_metadata; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orgnr_virksomhet_statistikk_metadata ON public.virksomhet_statistikk_metadata USING btree (orgnr);


--
-- Name: idx_sektor_kode_sykefravar_statistikk_sektor; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sektor_kode_sykefravar_statistikk_sektor ON public.sykefravar_statistikk_sektor USING btree (sektor_kode);


--
-- Name: idx_sykefravar_statistikk_grunnlag_orgnr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sykefravar_statistikk_grunnlag_orgnr ON public.sykefravar_statistikk_grunnlag USING btree (orgnr);


--
-- Name: idx_sykefravar_statistikk_virksomhet_arstall; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sykefravar_statistikk_virksomhet_arstall ON public.sykefravar_statistikk_virksomhet USING btree (arstall);


--
-- Name: idx_sykefravar_statistikk_virksomhet_kvartal; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sykefravar_statistikk_virksomhet_kvartal ON public.sykefravar_statistikk_virksomhet USING btree (kvartal);


--
-- Name: idx_sykefraver_periode_tapte_dagsverk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sykefraver_periode_tapte_dagsverk ON public.sykefravar_statistikk_virksomhet USING btree (arstall, kvartal, tapte_dagsverk DESC NULLS LAST);


--
-- Name: idx_virksomhet_kommunenr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_virksomhet_kommunenr ON public.virksomhet USING btree (kommunenummer);


--
-- Name: hendelse_begrunnelse fk_hendelse_begrunnelse; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hendelse_begrunnelse
    ADD CONSTRAINT fk_hendelse_begrunnelse FOREIGN KEY (hendelse_id) REFERENCES public.ia_sak_hendelse(id);


--
-- Name: ia_sak fk_ia_sak_endret_av_hendelse; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ia_sak
    ADD CONSTRAINT fk_ia_sak_endret_av_hendelse FOREIGN KEY (endret_av_hendelse) REFERENCES public.ia_sak_hendelse(id);


--
-- Name: ia_sak_hendelse fk_ia_sak_hendelse_virksomhet; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ia_sak_hendelse
    ADD CONSTRAINT fk_ia_sak_hendelse_virksomhet FOREIGN KEY (orgnr) REFERENCES public.virksomhet(orgnr);


--
-- Name: sykefravar_statistikk_grunnlag fk_sykefravar_statistikk_grunnlag_hendelse; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sykefravar_statistikk_grunnlag
    ADD CONSTRAINT fk_sykefravar_statistikk_grunnlag_hendelse FOREIGN KEY (hendelse_id) REFERENCES public.ia_sak_hendelse(id);


--
-- Name: sykefravar_statistikk_grunnlag fk_sykefravar_statistikk_grunnlag_sak; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sykefravar_statistikk_grunnlag
    ADD CONSTRAINT fk_sykefravar_statistikk_grunnlag_sak FOREIGN KEY (saksnummer) REFERENCES public.ia_sak(saksnummer);


--
-- Name: virksomhet_naring fk_virksomhet_naring_naring; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.virksomhet_naring
    ADD CONSTRAINT fk_virksomhet_naring_naring FOREIGN KEY (narings_kode) REFERENCES public.naring(kode);


--
-- Name: virksomhet_naring fk_virksomhet_naring_virksomhet; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.virksomhet_naring
    ADD CONSTRAINT fk_virksomhet_naring_virksomhet FOREIGN KEY (virksomhet) REFERENCES public.virksomhet(id) ON DELETE CASCADE;


--
-- Name: TABLE flyway_schema_history; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.flyway_schema_history TO cloudsqliamuser;


--
-- Name: TABLE hendelse_begrunnelse; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.hendelse_begrunnelse TO cloudsqliamuser;


--
-- Name: TABLE ia_sak; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ia_sak TO cloudsqliamuser;


--
-- Name: TABLE ia_sak_hendelse; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ia_sak_hendelse TO cloudsqliamuser;


--
-- Name: TABLE naring; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.naring TO cloudsqliamuser;


--
-- Name: TABLE sektor; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.sektor TO cloudsqliamuser;


--
-- Name: TABLE sykefravar_statistikk_grunnlag; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.sykefravar_statistikk_grunnlag TO cloudsqliamuser;


--
-- Name: TABLE sykefravar_statistikk_land; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.sykefravar_statistikk_land TO cloudsqliamuser;


--
-- Name: TABLE sykefravar_statistikk_naring; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.sykefravar_statistikk_naring TO cloudsqliamuser;


--
-- Name: TABLE sykefravar_statistikk_naringsundergruppe; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.sykefravar_statistikk_naringsundergruppe TO cloudsqliamuser;


--
-- Name: TABLE sykefravar_statistikk_sektor; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.sykefravar_statistikk_sektor TO cloudsqliamuser;


--
-- Name: TABLE sykefravar_statistikk_virksomhet; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.sykefravar_statistikk_virksomhet TO cloudsqliamuser;


--
-- Name: TABLE virksomhet; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.virksomhet TO cloudsqliamuser;


--
-- Name: TABLE virksomhet_statistikk_metadata; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.virksomhet_statistikk_metadata TO cloudsqliamuser;


--
-- Name: TABLE virksomhet_naring; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.virksomhet_naring TO cloudsqliamuser;


--
-- PostgreSQL database dump complete
--

