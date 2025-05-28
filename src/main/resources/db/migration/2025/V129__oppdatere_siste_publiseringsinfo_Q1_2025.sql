insert into siste_publiseringsinfo(gjeldende_arstall, gjeldende_kvartal, siste_publiseringsdato, neste_publiseringsdato)
values (2025, 1, '2025-05-28', '2025-09-04');

REFRESH MATERIALIZED VIEW virksomhetsstatistikk_for_prioritering;
