create table virksomhet_naringsundergrupper
(
    id                      serial primary key,
    virksomhet              integer not null,
    naeringskode1           varchar not null,
    naeringskode2           varchar default null,
    naeringskode3           varchar default null,
    oppdateringsdato        timestamp default null,
    opprettet               timestamp default current_timestamp,
    constraint fk_virksomhet_naringsundergrupper_virksomhet foreign key (virksomhet) references virksomhet (id),
    constraint fk_virksomhet_naringsundergrupper_naring foreign key (naeringskode1) references naring(kode),
    constraint virksomhet_naringsundergrupper_unik unique (virksomhet)
);
