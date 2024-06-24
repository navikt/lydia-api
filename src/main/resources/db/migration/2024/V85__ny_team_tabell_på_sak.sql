create table ia_sak_team
(
    ident                   varchar not null,
    saksnummer              varchar(26) not null,
    constraint fk_ia_sak_til_team foreign key (saksnummer) references ia_sak (saksnummer),
    constraint ia_sak_til_identer_sak_id_ident unique (saksnummer, ident)
);
