insert into siste_publiseringsinfo(gjeldende_arstall, gjeldende_kvartal, siste_publiseringsdato, neste_publiseringsdato)
values (2025, 2, '2025-09-04', '2025-11-27');

REFRESH MATERIALIZED VIEW virksomhetsstatistikk_for_prioritering;
