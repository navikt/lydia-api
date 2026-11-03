CREATE TYPE sykefravaersmaal_type AS ENUM (
    'LANGTIDSFRAVÆR',
    'KORTTIDSFRAVÆR',
    'EGENMELDT_FRAVÆR',
    'LEGEMELDT_FRAVÆR',
    'GRADERT_FRAVÆR',
    'TAPTE_DAGSVERK'
);

CREATE TABLE samarbeid_sykefravaersmaal
(
    id          serial primary key,
    ia_prosess  int                   not null references ia_prosess (id) on delete cascade,
    type        sykefravaersmaal_type not null,
    naavaerende decimal               not null check (naavaerende >= 0),
    maal        decimal               not null check (maal >= 0),
    frist       date                  not null,
    opprettet   timestamp             not null default current_timestamp,
    sist_endret timestamp             not null default current_timestamp,
    endret_av   varchar(36)           not null,
    CONSTRAINT samarbeid_sykefravaersmaal_unik_type UNIQUE (ia_prosess, type),
    CONSTRAINT samarbeid_sykefravaersmaal_prosent CHECK (type = 'TAPTE_DAGSVERK' or (naavaerende <= 100 and maal <= 100))
);

CREATE TABLE samarbeid_maal
(
    id                     serial primary key,
    ia_prosess             int          not null references ia_prosess (id) on delete cascade,
    maal                   varchar(250) not null,
    lagret_med_ki_advarsel boolean      not null default false,
    opprettet              timestamp    not null default current_timestamp,
    sist_endret            timestamp    not null default current_timestamp,
    endret_av              varchar(36)  not null
);

CREATE INDEX idx_samarbeid_maal_ia_prosess ON samarbeid_maal (ia_prosess);
