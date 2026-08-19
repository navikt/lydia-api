create table hendelser_til_kartlegging
(
    id             serial primary key,
    kartlegging_id varchar(36) not null references ia_sak_kartlegging (kartlegging_id),
    hendelse_id    varchar     not null references ia_sak_hendelse (id),
    unique (hendelse_id)
);

create index idx_hendelser_til_kartlegging_kartlegging_id on hendelser_til_kartlegging (kartlegging_id);
