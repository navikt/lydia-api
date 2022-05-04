create table ikke_aktuell_aarsak (
    id                              serial      primary key,
    navn                            varchar     not null
);

create table ikke_aktuell_begrunnelse (
    id                              serial      primary key,
    aarsak_id                       int         not null,
    navn                            varchar     not null,

    constraint fk_ikke_aktuell_begrunnelse_aarsak foreign key (aarsak_id) references ikke_aktuell_aarsak(id)
);

create table hendelse_begrunnelser (
    hendelse_id                     varchar     not null,
    ikke_aktuell_begrunnelse_id     int         not null,

    constraint fk_hendelse_begrunnelser_hendelse foreign key (hendelse_id) references ia_sak_hendelse(id),
    constraint fk_hendelse_begrunnelser_ikke_aktuell_begrunnelse foreign key (ikke_aktuell_begrunnelse_id) references ikke_aktuell_begrunnelse(id)
);


insert into ikke_aktuell_aarsak (id, navn) values (1, 'Arbeidslivssenteret igangsetter ikke tiltak med arbeidsgiver'), (2, 'Arbeidsgiver har takket nei');
insert into ikke_aktuell_begrunnelse (aarsak_id, navn) values
    (1, 'Arbeidsplassen har ikke etablert partsgruppe'),
    (1, 'Arbeidsplassen ønsker ikke å etablere partsgruppe eller benytte partssamarbeid i arbeidsmiljøutviklingsarbeidet'),
    (1, 'Arbeidsplassen har ikke et høyt sykefravær og er derfor ikke i prioritert gruppe iht IA-avtalen'),
    (1, 'Arbeidsplassen ønsker ikke å sette av tilstrekkelig tid til gjennomføring av prosessarbeid (over lenger tid)'),
    (1, 'Bestillingen og behovet fra arbeidsplassen utenfor vårt mandat iht IA-avtalen'),
    (1, 'Arbeidsplassen har et høyt sykefravær, men er en mindre virksomhet (færre ansatte) og er derfor ikke prioritert iht IA-avtalen.'),
    (2, 'Har ikke kapasitet nå til å gjennomføre prosjektet/tiltaket'),
    (2, 'Har ikke tid nå til å gjennomføre prosjektet/tiltaket'),
    (2, 'Ønsker å gjennomføre tiltak på egenhånd'),
    (2, 'Ønsker å gjennomføre tiltak med BHT');





