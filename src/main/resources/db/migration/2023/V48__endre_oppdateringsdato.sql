alter table virksomhet_naringsundergrupper
    alter column oppdateringsdato set default current_timestamp;

update virksomhet_naringsundergrupper
    set oppdateringsdato = opprettet where oppdateringsdato is null;