insert into siste_publiseringsinfo(gjeldende_arstall, gjeldende_kvartal, siste_publiseringsdato, neste_publiseringsdato)
values (2024, 2, '2024-09-05', '2024-11-28');

REFRESH MATERIALIZED VIEW virksomhetsstatistikk_for_prioritering;
