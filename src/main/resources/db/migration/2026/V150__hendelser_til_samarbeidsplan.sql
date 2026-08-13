create table hendelser_til_samarbeidsplan
(
    id                serial primary key,
    samarbeidsplan_id varchar(36) not null references ia_sak_plan (plan_id),
    hendelse_id       varchar     not null references ia_sak_hendelse (id),
    unique (hendelse_id)
);

create index idx_hendelser_til_samarbeidsplan_samarbeidsplan_id on hendelser_til_samarbeidsplan (samarbeidsplan_id);
