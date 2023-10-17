create table siste_publiseringsinfo
(
    id                      serial primary key,
    gjeldende_arstall       smallint    not null,
    gjeldende_kvartal       smallint    not null,
    siste_publiseringsdato  timestamp default null,
    neste_publiseringsdato  timestamp default null,
    opprettet               timestamp default current_timestamp
);

insert into siste_publiseringsinfo(gjeldende_arstall, gjeldende_kvartal, siste_publiseringsdato, neste_publiseringsdato)
values (2022, 4, '2023-03-02', '2023-06-01');
