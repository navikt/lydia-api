CREATE TABLE salesforce_aktiviteter(
    id varchar primary key,
    type varchar not null default 'Møte',
    saksnummer varchar references ia_sak(saksnummer),
    samarbeid int references ia_prosess(id),
    tema varchar,
    undertema varchar,
    oppgave_planlagt timestamp default null,
    oppgave_fullfort timestamp default null,
    mote_start timestamp default null,
    mote_slutt timestamp default null,
    sist_endret timestamp default current_timestamp,
    status varchar
);
