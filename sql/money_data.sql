SELECT
    r.date
  , r.totbc
  , r.newbc
  , d.dnewbc
  , r.mktcp
  , d.dmktcp
  , r.mkpru
  , d.dmkpru
FROM bitcoin_raw r
LEFT JOIN bitcoin_diff d ON r.date = d.date;