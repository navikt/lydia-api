alter table virksomhet
    add column status varchar not null default 'AKTIV',
    add column oppstartsdato date,
    add column oppdatertAvBrregOppdateringsId bigint,
    add column opprettetTidspunkt timestamp not null default now(),
    add column sistEndretTidspunkt timestamp
    ;