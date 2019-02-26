CREATE TABLE bitcoin_diff AS
SELECT
    date
  , ntran - LAG(ntran, 1) OVER (ORDER BY date ASC) AS dntran
  , ntrep - LAG(ntrep, 1) OVER (ORDER BY date ASC) AS dntrep
  , etrav - LAG(etrav, 1) OVER (ORDER BY date ASC) AS detrav
  , toutv - LAG(toutv, 1) OVER (ORDER BY date ASC) AS dtoutv
  , ntrbl - LAG(ntrbl, 1) OVER (ORDER BY date ASC) AS dntrbl
  , totbc - LAG(totbc, 1) OVER (ORDER BY date ASC) AS dtotbc
  , COALESCE(newbc - LAG(newbc, 1) OVER (ORDER BY date ASC), 0) AS dnewbc
  , mktcp - LAG(mktcp, 1) OVER (ORDER BY date ASC) AS dmktcp
  , mkpru - LAG(mkpru, 1) OVER (ORDER BY date ASC) AS dmkpru
  , trfee - LAG(trfee, 1) OVER (ORDER BY date ASC) AS dtrfee
  , trfus - LAG(trfus, 1) OVER (ORDER BY date ASC) AS dtrfus
  , mirev - LAG(mirev, 1) OVER (ORDER BY date ASC) AS dmirev
  , cptra - LAG(cptra, 1) OVER (ORDER BY date ASC) AS dcptra
  , cptrv - LAG(cptrv, 1) OVER (ORDER BY date ASC) AS dcptrv
  , naddu - LAG(naddu, 1) OVER (ORDER BY date ASC) AS dnaddu
  , bcdde - LAG(bcdde, 1) OVER (ORDER BY date ASC) AS dbcdde
  , atrct - LAG(atrct, 1) OVER (ORDER BY date ASC) AS datrct
  , avbls - LAG(avbls, 1) OVER (ORDER BY date ASC) AS davbls
  , diff - LAG(diff, 1) OVER (ORDER BY date ASC) AS ddiff
  , hrate - LAG(hrate, 1) OVER (ORDER BY date ASC) AS dhrate
  , exch  - LAG(exch, 1) OVER (ORDER BY date ASC) AS dexch
  , phase
FROM bitcoin_raw;
