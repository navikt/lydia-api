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
    saksnummer     varchar(20) not null,
    modul          integer     not null,
    frist          date,
    status         varchar     not null default 'UNDER_ARBEID',
    opprettet_av   varchar     not null,
    sist_endret    timestamp   not null default current_timestamp,
    sist_endret_av varchar     not null,
    constraint fk_iasak_leveranse_modul foreign key (modul) references modul (id),
    constraint fk_iasak_leveranse_saksnummer foreign key (saksnummer) references ia_sak (saksnummer),
    constraint iasak_leveranse_unik unique (saksnummer, modul)
);
