# 概要

- bitcoincharts.com から取引高データを計算します
  - TODO: メモリ使用量が半端ないのでジェネレーターで書き直したい
- quandl.com からbitcoin のシステムデータを取得します
- CSV形式で保存します
- PostgreSQLのDBにも保存できます

```
python3 fetch_bitcoin_data.py
```
