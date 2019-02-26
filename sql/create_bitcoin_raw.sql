CREATE TABLE bitcoin_raw AS
SELECT
    CAST(b.date AS date) AS date
  , b.ntran
  , b.ntrep
  , b.etrav
  , b.toutv
  , b.ntrbl
  , b.totbc
  , COALESCE(b.totbc - LAG(b.totbc, 1) OVER (ORDER BY b.date ASC) ,0) AS newbc
  , b.mktcp
  , b.mkpru
  , b.trfee
  , b.trfus
  , b.mirev
  , b.cptra
  , b.cptrv
  , b.naddu
  , b.bcdde
  , COALESCE(b.atrct, mct.atrct) AS atrct
  , b.avbls
  , b.diff
  , b.hrate
  , e.exch
  , CASE
      WHEN b.date < '2012-11-28 00:00:00' THEN '1'
      WHEN '2012-11-28 00:00:00' <= b.date AND b.date < '2016-07-09 00:00:00' THEN '2'
      WHEN '2016-07-09 00:00:00' <= b.date THEN '3'
     END AS phase
 FROM quandl b
 LEFT JOIN exch e ON b.date = e.date
 LEFT JOIN mct ON b.date = mct.date
 WHERE b.date < '2019-01-01 00:00:00';