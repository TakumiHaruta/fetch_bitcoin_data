SELECT
    year_
  , PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY trfee) AS med_trfee
  , AVG(trfee) AS avg_trfee
  , PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY trfus) AS med_trfus
  , AVG(trfus) AS avg_trfus
FROM (
  SELECT
      EXTRACT(YEAR FROM date) AS year_
    , trfee / ntran AS trfee
    , trfus / ntran AS trfus
  FROM quandl
  WHERE date BETWEEN '2012-01-01' AND '2018-12-31'
) as foo
GROUP BY year_;