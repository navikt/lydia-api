insert into siste_publiseringsinfo(gjeldende_arstall, gjeldende_kvartal, siste_publiseringsdato, neste_publiseringsdato)
values (2023, 3, '2023-11-30', '2024-02-29');

REFRESH MATERIALIZED VIEW virksomhetsstatistikk_for_prioritering;
