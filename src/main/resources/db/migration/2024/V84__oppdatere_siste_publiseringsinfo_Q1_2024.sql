insert into siste_publiseringsinfo(gjeldende_arstall, gjeldende_kvartal, siste_publiseringsdato, neste_publiseringsdato)
values (2024, 1, '2024-05-30', '2024-09-05');

REFRESH MATERIALIZED VIEW virksomhetsstatistikk_for_prioritering;
