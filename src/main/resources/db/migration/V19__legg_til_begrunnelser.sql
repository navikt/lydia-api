create table hendelse_begrunnelse (
    hendelse_id             varchar     not null,
    aarsak                  varchar     not null,
    begrunnelse             varchar     not null,
    aarsak_enum             varchar     not null,
    begrunnelse_enum        varchar     not null,

   constraint fk_hendelse_begrunnelse foreign key (hendelse_id) references ia_sak_hendelse(id)
);
