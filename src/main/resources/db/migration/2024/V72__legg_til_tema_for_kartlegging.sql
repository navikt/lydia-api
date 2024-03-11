-- Slett alle eksisterende kartlegginger og svar
DELETE FROM ia_sak_kartlegging_sporsmal_til_kartlegging;
DELETE FROM ia_sak_kartlegging_svar;
DELETE FROM ia_sak_kartlegging;

-- Fjern direkte kobling mellom kartlegging og spørsmål
DROP TABLE ia_sak_kartlegging_sporsmal_til_kartlegging;

-- Legg til ny tabell - tema
create table ia_sak_kartlegging_tema
(
    tema_id     serial primary key,
    navn        varchar not null,
    beskrivelse varchar not null,
    status      varchar not null default 'AKTIV',
    sist_endret date not null default now()
);

-- kobling mellom kartlegging og tema(er)
create table ia_sak_kartlegging_kartlegging_til_tema
(
    id             serial primary key,
    kartlegging_id varchar(36) not null,
    tema_id        int not null,
    constraint  fk_ia_sak_kartlegging_kartlegging_til_tema_kartlegging foreign key (kartlegging_id) references ia_sak_kartlegging (kartlegging_id),
    constraint  fk_ia_sak_kartlegging_kartlegging_til_tema_tema foreign key (tema_id) references ia_sak_kartlegging_tema (tema_id),
    constraint  uq_ia_sak_kartlegging_kartlegging_til_tema_kartlegging_tema unique (kartlegging_id, tema_id)
);

-- Legg til temaer
INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, beskrivelse) VALUES
  (1, 'PARTSSAMARBEID', 'Partssamarbeid i virksomheten'),
  (2, 'SYKEFRAVÆRSOPPFØLGING', 'Sykefraværsoppfølging i virksomheten');

create table ia_sak_kartlegging_tema_til_spørsmål(
    tema_id       int not null,
    sporsmal_id   varchar(36) not null,
    constraint fk_ia_sak_kartlegging_tema_til_spørsmål_tema foreign key (tema_id) references ia_sak_kartlegging_tema (tema_id),
    constraint fk_ia_sak_kartlegging_tema_til_spørsmål_spm_id foreign key (sporsmal_id) references ia_sak_kartlegging_sporsmal (sporsmal_id)
);

-- Tagg eksisterende spørsmål med tema
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål SELECT 1, sporsmal_id FROM ia_sak_kartlegging_sporsmal;

