CREATE TABLE hendelse_aarsak
(
    aarsak_id   varchar not null primary key,
    hendelse_id varchar not null unique references ia_sak_hendelse (id),
    aarsak_enum varchar not null,
    aarsak      varchar not null
);

CREATE TABLE aarsak_begrunnelse
(
    aarsak_id        varchar not null references hendelse_aarsak (aarsak_id),
    begrunnelse_enum varchar not null,
    begrunnelse      varchar not null,
    CONSTRAINT begrunnelse_mengde UNIQUE (aarsak_id, begrunnelse_enum)
);
