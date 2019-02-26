CREATE TABLE bitcoin_log_diff AS
SELECT
    date
  , lntran - LAG(lntran, 1) OVER (ORDER BY date ASC) AS dlntran
  , lntrep - LAG(lntrep, 1) OVER (ORDER BY date ASC) AS dlntrep
  , letrav - LAG(letrav, 1) OVER (ORDER BY date ASC) AS dletrav
  , ltoutv - LAG(ltoutv, 1) OVER (ORDER BY date ASC) AS dltoutv
  , lntrbl - LAG(lntrbl, 1) OVER (ORDER BY date ASC) AS dlntrbl
  , ltotbc - LAG(ltotbc, 1) OVER (ORDER BY date ASC) AS dltotbc
  , lnewbc - LAG(lnewbc, 1) OVER (ORDER BY date ASC) AS dlnewbc
  , lmktcp - LAG(lmktcp, 1) OVER (ORDER BY date ASC) AS dlmktcp
  , lmkpru - LAG(lmkpru, 1) OVER (ORDER BY date ASC) AS dlmkpru
  , ltrfee - LAG(ltrfee, 1) OVER (ORDER BY date ASC) AS dltrfee
  , ltrfus - LAG(ltrfus, 1) OVER (ORDER BY date ASC) AS dltrfus
  , lmirev - LAG(lmirev, 1) OVER (ORDER BY date ASC) AS dlmirev
  , lcptra - LAG(lcptra, 1) OVER (ORDER BY date ASC) AS dlcptra
  , lcptrv - LAG(lcptrv, 1) OVER (ORDER BY date ASC) AS dlcptrv
  , lnaddu - LAG(lnaddu, 1) OVER (ORDER BY date ASC) AS dlnaddu
  , lbcdde - LAG(lbcdde, 1) OVER (ORDER BY date ASC) AS dlbcdde
  , latrct - LAG(latrct, 1) OVER (ORDER BY date ASC) AS dlatrct
  , lavbls - LAG(lavbls, 1) OVER (ORDER BY date ASC) AS dlavbls
  , ldiff  - LAG(ldiff, 1)  OVER (ORDER BY date ASC) AS dldiff
  , lhrate - LAG(lhrate, 1) OVER (ORDER BY date ASC) AS dlhrate
  , lexch  - LAG(lexch, 1)  OVER (ORDER BY date ASC) AS dlexch
  , phase
FROM bitcoin_log;
