insert into siste_publiseringsinfo(gjeldende_arstall, gjeldende_kvartal, siste_publiseringsdato, neste_publiseringsdato)
values (2023, 4, '2024-02-29', '2024-05-30');

REFRESH MATERIALIZED VIEW virksomhetsstatistikk_for_prioritering;
