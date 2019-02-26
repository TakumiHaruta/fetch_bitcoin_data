CREATE TABLE bitcoin_log AS
SELECT
    date
  , LOG(ntran+1) AS lntran
  , LOG(ntrep+1) AS lntrep
  , LOG(etrav+1) AS letrav
  , LOG(toutv+1) AS ltoutv
  , LOG(ntrbl+1) AS lntrbl
  , LOG(totbc+1) AS ltotbc
  , LOG(newbc+1) AS lnewbc
  , LOG(mktcp+1) AS lmktcp
  , LOG(mkpru+1) AS lmkpru
  , LOG(trfee+1) AS ltrfee
  , LOG(trfus+1) AS ltrfus
  , LOG(mirev+1) AS lmirev
  , LOG(cptra+1) AS lcptra
  , LOG(cptrv+1) AS lcptrv
  , LOG(naddu+1) AS lnaddu
  , LOG(bcdde+1) AS lbcdde
  , LOG(atrct+1) AS latrct
  , LOG(avbls+1) AS lavbls
  , LOG(diff+1)  AS ldiff
  , LOG(hrate+1) AS lhrate
  , LOG(exch+1)  AS lexch
  , phase
FROM bitcoin_raw;
