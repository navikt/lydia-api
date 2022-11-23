create table sykefravar_statistikk_virksomhet_siste_4_kvartal
(
    id               serial primary key,
    orgnr            varchar(20) not null unique,
    tapte_dagsverk   decimal,
    mulige_dagsverk  decimal,
    prosent          decimal,
    maskert          boolean     not null,
    antall_kvartaler smallint    not null,
    kvartaler        jsonb,
    opprettet        timestamp default current_timestamp
);
