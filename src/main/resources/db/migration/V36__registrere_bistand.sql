create table ia_tjeneste (
    id   serial primary key,
    navn varchar not null
);

create table modul (
    id          serial primary key,
    ia_tjeneste integer not null,
    navn        varchar not null,
    constraint fk_modul_ia_tjeneste foreign key (ia_tjeneste) references ia_tjeneste (id)
);

create table iasak_leveranse (
    id             serial primary key,
    saksnummer     varchar(26) not null,
    modul          integer     not null,
    frist          date        not null,
    status         varchar     not null default 'UNDER_ARBEID',
    opprettet_av   varchar     not null,
    sist_endret    timestamp   not null default current_timestamp,
    sist_endret_av varchar     not null,
    constraint fk_iasak_leveranse_modul foreign key (modul) references modul (id),
    constraint fk_iasak_leveranse_saksnummer foreign key (saksnummer) references ia_sak (saksnummer),
    constraint iasak_leveranse_unik unique (saksnummer, modul)
);

insert into ia_tjeneste (id, navn) values
 (1, 'Redusere sykefravær'),
 (2, 'Forebyggende arbeidsmiljøarbeid'),
 (3, 'HelseIArbeid');

insert into modul (id, ia_tjeneste, navn) VALUES
    (1, 1, 'Videreutvikle sykefraværsrutiner'),
    (2, 1, 'Oppfølgingssamtalen'),
    (3, 1, 'Tilretteleggingsplikt og medvirkningsplikt'),
    (4, 1, 'Langvarige og/eller hyppig gjentakende sykefravær'),
    (5, 2, 'Utvikle partssamarbeid'),
    (6, 2, 'Enkel arbeidsmiljøkartlegging'),
    (7, 2, 'Kontinuerlig (arbeidsmiljø)forbedring'),
    (8, 2, 'Endring og omstilling'),
    (9, 2, 'Oppfølging av arbeidsmiljøundersøkelse'),
    (10, 2,'Livsfaseorientert personalpolitikk'),
    (11, 3,'Bedriftstiltaket');