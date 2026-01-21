create table tilstand_virksomhet
(
    id                      serial primary key,
    orgnr                   varchar(20) not null,
    samarbeidsperiode_id    varchar(26) not null,
    tilstand                varchar not null,
    sist_endret             timestamp not null default current_timestamp,

    constraint fk_ia_sak_saksnummer__samarbeidsperiode_id foreign key (samarbeidsperiode_id) references ia_sak(saksnummer),
    constraint tilstand_virksomhet_orgnr_unique unique (orgnr)
);

create table tilstand_automatisk_oppdatering
(
    id                      serial primary key,
    orgnr                   varchar(20) not null,
    tilstand_virksomhet_id  integer not null,
    ny_tilstand             varchar not null,
    planlagt_dato           timestamp not null default current_timestamp,

    constraint fk_tilstand_virksomhet_id foreign key (tilstand_virksomhet_id) references tilstand_virksomhet(id)
);