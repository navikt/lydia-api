create table hendelser_til_samarbeid
(
    id           serial primary key,
    samarbeid_id int     not null references ia_prosess (id),
    hendelse_id  varchar not null references ia_sak_hendelse (id),
    unique (hendelse_id)
);

create index idx_hendelser_til_samarbeid_samarbeid_id on hendelser_til_samarbeid (samarbeid_id);
