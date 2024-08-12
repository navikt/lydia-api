create table ia_sak_plan
(
    plan_id        varchar(36) primary key,
    ia_prosess     INT         not null,
    sist_endret    timestamp default current_timestamp,
    sist_publisert timestamp default null,
    opprettet_av   varchar(36) not null,
    constraint fk_ia_sak_plan_prosess foreign key (ia_prosess) references ia_prosess (id)
);

create table ia_sak_plan_tema
(
    tema_id  serial primary key,
    navn     varchar     not null,
    planlagt boolean     not null,
    plan_id  varchar(36) not null,
    constraint fk_ia_sak_plan_tema_plan_id foreign key (plan_id) references ia_sak_plan (plan_id)
);

create table ia_sak_plan_undertema
(
    undertema_id serial primary key,
    navn         varchar     not null,
    planlagt     boolean     not null,
    status       varchar,
    start_dato   date,
    slutt_dato   date,
    tema_id      INT         not null,
    plan_id      varchar(36) not null,
    constraint fk_ia_sak_plan_undertema_plan_id foreign key (plan_id) references ia_sak_plan (plan_id),
    constraint fk_ia_sak_plan_undertema_tema_id foreign key (tema_id) references ia_sak_plan_tema (tema_id)
);

create table ia_sak_plan_ressurs
(
    ressurs_id  serial primary key,
    beskrivelse varchar     not null,
    url         varchar default null,
    tema_id     INT         not null,
    plan_id     varchar(36) not null,
    constraint fk_ia_sak_plan_ressurs_plan_id foreign key (plan_id) references ia_sak_plan (plan_id),
    constraint fk_ia_sak_plan_ressurs_tema_id foreign key (tema_id) references ia_sak_plan_tema (tema_id)
);
