insert into siste_publiseringsinfo(gjeldende_arstall, gjeldende_kvartal, siste_publiseringsdato, neste_publiseringsdato)
values (2024, 4, '2025-02-27', '2025-05-28');

REFRESH MATERIALIZED VIEW virksomhetsstatistikk_for_prioritering;
