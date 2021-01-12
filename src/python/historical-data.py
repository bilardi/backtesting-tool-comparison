from pandas_datareader import data as pdr
cross_from = ['EUR', 'USD', 'CAD']
cross_to = ['USD', 'JPY', 'USD']
symbols = [x + y + '=X' for x, y in zip(cross_from, cross_to)]
data = pdr.DataReader(symbols, 'yahoo')

symbol = 'AMZN'
start = '1997-05-15'
end = '2020-09-30'
period = 'daily'

from pandas_datareader import data as pdr
data = pdr.DataReader(symbol, 'yahoo', start, end)
len(data) # 5884
data.to_csv('pdr_data.csv')

import pandas
import yfinance
data = yfinance.Ticker(symbol)
data.info
df = pandas.DataFrame(data.history(period='max'))
len(df) # 5885
df.to_csv('yfinance_data.ticker.csv')
data = yfinance.download(symbol, start=start, end=end, group_by='ticker')
len(data) # 5883
data.to_csv('yfinance_data.download.csv')

yfinance.pdr_override()
data = pdr.get_data_yahoo(symbol, start=start, end=end)
len(data) # 5883
data.to_csv('yfpdr_data.csv')

from yahoofinancials import YahooFinancials
data = YahooFinancials(symbol)
json = data.get_historical_price_data(start_date=start, end_date=end, time_interval=period)
df = pandas.DataFrame(json[symbol]['prices'])
len(df) # 5883
df.to_csv('yahoofinancials_data.csv')

from yahoo_fin import stock_info as si
data = si.get_data(symbol)
len(data) # 5885
data.to_csv('yahoo_fin_data.csv')

import json
import pandas
import requests
from datetime import datetime, timedelta
base_url = 'https://www.oanda.com/fx-for-business/historical-rates/api/data/update/?&source=OANDA&adjustment=0&base_currency={to_currency}&start_date={start_date}&end_date={end_date}&period={period}&price=mid&view=table&quote_currency_0={from_currency}'
today = datetime.strftime(datetime.now(), '%Y-%m-%d')
def get_oanda_currency_historical_rates(base_url, start, end, quote_currency, base_currency, period):
    url = base_url.format(from_currency=quote_currency, to_currency=base_currency, start_date=start, end_date=end, period=period)
    response = json.loads(requests.get(url).content.decode('utf-8'))
    return pandas.DataFrame(response['widget'][0]['data'])
# the last 6 months
df = get_oanda_currency_historical_rates(base_url, datetime.strftime(datetime.now() - timedelta(180), '%Y-%m-%d'), today, 'EUR', 'USD', period)
# the last 60 days
df = get_oanda_currency_historical_rates(base_url, datetime.strftime(datetime.now() - timedelta(60), '%Y-%m-%d'), today, 'EUR', 'USD', period)

import json
import panda
import requests
base_url = 'https://sandbox-api.coinmarketcap.com/v1/'
def get_coinmarketcap_data(url):
    response = json.loads(requests.get(url).content.decode('utf-8'))
    return pandas.DataFrame(response['data'])

# returns all active cryptocurrencies
url = base_url + 'cryptocurrency/map'
marketcap_map = get_coinmarketcap_data(url)

# returns last market data of all active cryptocurrencies 
url = base_url + 'cryptocurrency/listings/latest?convert=EUR'
last_marketcap = get_coinmarketcap_data(url)

# returns last market data of Bitcoin
url = base_url + 'cryptocurrency/quotes/latest?id=1&convert=EUR'
last_bitcoin = get_coinmarketcap_data(url)

# returns historical data from a time_start to a time_end 
url = base_url + 'cryptocurrency/quotes/historical?id=1&convert=EUR&time_start=2020-05-21T12:14&time_end=2020-05-21T12:44'
data = get_coinmarketcap_data(url)

symbol = 'CHRIS/CME_QM1'

import pandas
from datetime import datetime
base_url = 'https://www.quandl.com/api/v3/datasets/{symbol}.csv?start_date={start_date}&end_date={end_date}&collapse={period}'
today = datetime.strftime(datetime.now(), '%Y-%m-%d')
def get_oanda_currency_historical_rates(base_url, symbol, start, end, period):
    url = base_url.format(symbol=symbol, start_date=start, end_date=end, period=period)
    return pandas.read_csv(url)
# returns all free columns values
df = get_quandl_financial_data(base_url, symbol, start, end, period)
# returns only open values
df['Open'] # or
df = get_quandl_financial_data(base_url + '&column_index=1', symbol, start, end, period)

import quandl
# returns all free columns values
data = quandl.get(symbol)
# returns only open values
data['Open']