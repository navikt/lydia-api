insert into siste_publiseringsinfo(gjeldende_arstall, gjeldende_kvartal, siste_publiseringsdato, neste_publiseringsdato)
values (2024, 3, '2024-11-28', '2025-02-27');

REFRESH MATERIALIZED VIEW virksomhetsstatistikk_for_prioritering;
