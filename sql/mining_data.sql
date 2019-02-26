SELECT
    r.date
  , r.trfee
  , r.trfus
  , r.mirev
  , r.cptra
  , r.cptrv
  , r.diff
  , r.hrate
FROM bitcoin_raw r
LEFT JOIN bitcoin_log l ON r.date = l.date;