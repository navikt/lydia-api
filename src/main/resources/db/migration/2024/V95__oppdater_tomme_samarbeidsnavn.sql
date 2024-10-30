update ia_prosess set navn = null
 where navn is not null
 and length(trim(navn)) = 0;