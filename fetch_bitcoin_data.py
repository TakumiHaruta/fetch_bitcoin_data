import quandl
import pandas as pd
import requests
import lxml.html
import gzip
import io
import os
import time
import subprocess
import psycopg2
import shlex

from collections import Counter
from sqlalchemy import create_engine
from datetime import date


QUANDL_AUTH_TOKEN = os.getenv('QUANDL_AUTH_TOKEN')
POSTGRES_DB_URL = os.getenv('POSTGRES_DB_URL')
ENGINE = create_engine(POSTGRES_DB_URL)

def get_bcc_urls():
    print('Get urls from Bitcoin Charts')
    res = requests.get('http://api.bitcoincharts.com/v1/csv/')
    res_inac = requests.get('http://api.bitcoincharts.com/v1/csv/inactive_exchanges/')
    html = lxml.html.fromstring(res.text)
    html_inac = lxml.html.fromstring(res_inac.text)
    urls = ['api.bitcoincharts.com/v1/csv/' + url.attrib['href'] for url in html.xpath('//a')]
    urls_inac = ['api.bitcoincharts.com/v1/csv/inactive_exchanges/' + url.attrib['href'] for url in html_inac.xpath('//a')]
    del urls[0]
    del urls[0]
    del urls_inac[0]
    urls_all = urls + urls_inac

    return urls_all


def dl_bcc():
    print('Download data from Bitcoin Charts')
    p = subprocess.Popen(shlex.split('wget -r -w 1 -A gz http://api.bitcoincharts.com/v1/csv/'), stdout = subprocess.PIPE, stderr = subprocess.STDOUT)
    for line in iter(p.stdout.readline,b''):
        print(line.rstrip().decode("utf8"))


def count_bcc(urls):
    print('Get data from Local')
    cntr_excn = Counter()
    #cntr_exbc = Counter()
    for url in urls:
        new_data = []
        print(url)
        with gzip.open(url, mode='rb') as f:
            decomp = f.read()
        print('Decomp')
        for rec in decomp.decode().split('\n'):
            rec = rec.split(',')
            if rec != ['']:
                del rec[1]
                new_data.append(rec)
        del decomp
        if new_data != []:
            if new_data[-1] == ['']:
                del new_data[-1]
        print('Counting')
        for rec in new_data:
            dt = date.fromtimestamp(int(float(rec[0])))
            if dt >= date(2019, 1, 1) or dt <= date(2016, 7, 9):
                continue
            bc = float(rec[1])
            cntr_excn += Counter({dt:1})
            #cntr_exbc += Counter({dt:bc})

    data_excn = pd.DataFrame(dict(cntr_excn), index=['exch']).T
    data_excn.index = pd.DatetimeIndex(data_excn.index, name='date')
    #data_exbc = pd.DataFrame(dict(cntr_exbc), index=['exbc']).T
    #data_exbc.index = pd.DatetimeIndex(data_exbc.index, name='date')

    #new_data = pd.merge(data_excn, data_exbc, on='date', how='inner')
    data_exbn.to_csv('bitcoin_cnt_sum.csv')
    #new_data.to_sql('bitcoin', ENGINE, if_exists='replace', dtype={'date': String(10)})
    #dl_quandl(data_exbn)


def dl_quandl(data):
    print('Get data from Quandl')

    data_type = [
            'NTRAN', # Number of Transactions
            'NTRAT', # Total Number of Transactions
            'NTREP', # Number of Transactions Excluding Popular Addresses
            'ETRAV', # Estimated Transaction Volume
            'TOUTV', # Total Output Volume
            'TOTBC', # Total Bitcoins
            'MKPRU', # Market Price USD
            'TRFEE', # Total Transaction Fees
            'MIREV', # Miners Revenue
            'DIFF' , # Difficulty
            'ATRCT', # Median Transaction Confirmation Time
            'NADDU', # Number of Unique Bitcoin Addresses Used
            'AVBLS', # Average Block Size
            'BCDDE', # Days Destroyed
            'BCDDC', # Days Destroyed Cumulative
            'HRATE'  # Hash Rate
            ]
    #data = pd.read_sql_table('bitcoin', ENGINE, index_col='date', parse_dates=['date'])

    for t in data_type:
        print('Data: %s' % t)
        time.sleep(1)
        q_data = quandl.get("BCHAIN/%s" % t, authtoken=QUANDL_AUTH_TOKEN).rename(columns={'Value':t.lower()})
        q_data.index = pd.DatetimeIndex(q_data.index, name='date')
        data = pd.merge(data, q_data, on='date', how='left')
    print('Update table')
    data.to_csv('bitcoin_sum.csv')
    #data.to_sql('bitcoin', ENGINE, if_exists='replace')


if __name__ == '__main__':

    #dl_bcc()
    urls = get_bcc_urls()
    for url in urls:
        if not os.path.exists(url):
            raise Exception('%sがありません' % url)

    count_bcc(urls)

    print('Done!!')
