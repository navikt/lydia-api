-- Referanse tabeller til konsept 'undertema'

-- Undertema og dets forhold til tema (1 tema -> n undertemaer; 1 undertemaer -> 1 tema)
create table ia_sak_kartlegging_undertema
(
    undertema_id     serial primary key,
    navn             varchar not null,
    status           varchar not null default 'AKTIV',
    opprettet        date    not null default now(),
    sist_endret      date    not null default now(), -- undertema kan oppdateres
    rekkefolge       int not null default 0,
    tema_id          int not null,
    obligatorisk boolean not null,
    constraint fk__ia_sak_kartlegging_undertema__tema_id_fk
        foreign key (tema_id) references ia_sak_kartlegging_tema (tema_id)
);

-- Legg til undertemaer (init: ett undertema per tema med samme ID, alle med rekkefølge '1')
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (1,  'Utvikle partssamarbeid i virksomheten', 'INAKTIV', 1, 1, false),
       (2,  'Redusere sykefravær i virksomheten', 'INAKTIV', 1, 2, false),
       (3,  'Utvikle partssamarbeidet i virksomheten', 'INAKTIV', 1, 3, false),
       (4,  'Partssamarbeid', 'INAKTIV', 1, 4, false),
       (5,  'Sykefraværsarbeid', 'INAKTIV', 1, 5, false),
       (6,  'Arbeidsmiljø', 'INAKTIV', 1, 6, false),
       (7,  'Utvikle partsamarbeidet', 'AKTIV', 1, 7, false), -- aktiv Evaluering
       (8,  'Sykefraværsrutiner', 'AKTIV', 1, 8, false),      -- aktiv Evaluering
       (9,  'Utvikle arbeidsmiljøet', 'AKTIV', 1, 9, false),  -- aktiv Evaluering
       (10, 'Partssamarbeid', 'INAKTIV', 1, 10, false),
       (11, 'Sykefraværsarbeid', 'INAKTIV', 1, 11, false),
       (12, 'Arbeidsmiljø', 'INAKTIV', 1, 12, false),
       (13, 'Partssamarbeid', 'AKTIV', 1, 13, false),    -- aktiv Behovsvurdering
       (14, 'Sykefraværsarbeid', 'AKTIV', 1, 14, false), -- aktiv Behovsvurdering
       (15, 'Arbeidsmiljø', 'AKTIV', 1, 15, false);      -- aktiv Behovsvurdering
