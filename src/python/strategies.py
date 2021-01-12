# initialization
import numpy as np
import pandas as pd
from pandas_datareader import data as pdr
start='2017-10-30'
end='2020-10-08'
amzn = pdr.DataReader('AMZN', 'yahoo', start, end)
# simple indicators
amzn['SMA20'] = amzn['Close'].rolling(20).mean()
amzn['SMA50'] = amzn['Close'].rolling(50).mean()
amzn['EMA20'] = amzn['Close'].ewm(span=20, adjust=False).mean()
amzn['EMA50'] = amzn['Close'].ewm(span=50, adjust=False).mean()
amzn['STD20'] = amzn['Close'].rolling(20).std()
amzn['Upper Band'] = amzn['SMA20'] + (amzn['STD20'] * 2)
amzn['Lower Band'] = amzn['SMA20'] - (amzn['STD20'] * 2)
#amzn['Upper Band'] = amzn['EMA20'] + (amzn['STD20'] * 2)
#amzn['Lower Band'] = amzn['EMA20'] - (amzn['STD20'] * 2)
def RSI(data, time_window):
    diff = data.diff(1).dropna()
    up_chg = 0 * diff
    down_chg = 0 * diff
    up_chg[diff > 0] = diff[ diff>0 ]
    down_chg[diff < 0] = diff[ diff < 0 ]
    up_chg_avg   = up_chg.ewm(com=time_window-1 , min_periods=time_window).mean()
    down_chg_avg = down_chg.ewm(com=time_window-1 , min_periods=time_window).mean()
    rs = abs(up_chg_avg/down_chg_avg)
    rsi = 100 - 100/(1+rs)
    return rsi
amzn['RSI'] = RSI(amzn['Close'], 14)
amzn['RSI70'] = 70.0
amzn['RSI50'] = 50.0
# custom indicator
def RSIaverage(data, n1, n2):
    RSI_1 = RSI(data, n1)
    RSI_2 = RSI(data, n2)
    return (RSI_1 + RSI_2) / 2
amzn['RSIaverage'] = RSIaverage(amzn['Close'], 2, 14)
# data ranges
piece_d = pd.date_range(start='2017-10-30', end='2020-10-01')
#piece_d = pd.date_range(start='2020-01-01', end='2020-10-01')
amzn_piece_d = amzn.reindex(piece_d)
data = pd.DataFrame(amzn_piece_d.dropna())
# sample of divergence signal
divergence = [[('2020-07-22',3250),('2020-09-01',3550)]]
data['divergence'] = np.where((data.index == '2020-07-10') | (data.index == '2020-09-01'), data['RSI'], None)
data['divergence'] = data['divergence'].dropna()

# plot with candle daily, sma 20, sma 50, bb, RSI and yahoo style
import mplfinance as mpf
kwargs = dict(type='candle',volume=True,figratio=(16,9),figscale=2)
aps = [
    mpf.make_addplot(data['SMA20'],color='C0'), # blue
    mpf.make_addplot(data['SMA50'],color='C1'), # orange
#    mpf.make_addplot(data['EMA20'],color='C0'), # blue
#    mpf.make_addplot(data['EMA50'],color='C1'), # orange
    mpf.make_addplot(data['Upper Band'],linestyle='-.',color='g'),
    mpf.make_addplot(data['Lower Band'],linestyle='-.',color='g'),
    mpf.make_addplot(data['RSI'],color='C4',panel=2,ylabel='RSI'),
    mpf.make_addplot(data['RSI70'],color='g',panel=2,type='line',linestyle='-.',alpha=0.5),
    mpf.make_addplot(data['RSI50'],color='r',panel=2,type='line',linestyle='-.',alpha=0.5),
    mpf.make_addplot(data['divergence'],color='C0',panel=2,type='scatter',markersize=78,marker='o'),
    mpf.make_addplot(data['RSIaverage'],color='C2',panel=3,ylabel='RSIaverage'),
] 
mpf.plot(data,**kwargs,style='yahoo',title='AMZN',addplot=aps,alines=divergence,fill_between=dict(y1=data['Lower Band'].values,y2=data['Upper Band'].values,alpha=0.1,color='g'),savefig=dict(fname='plot.with.candle.daily.sma.20.sma.50.bb.RSI.yahoo.style.png'))

# Moving Average Crossover Strategy - Sample 1
#ma = 'SMA20'
ma = 'EMA20'
# Taking the difference between the prices and the MA timeseries
data['price_ma_diff'] = data['Close'] - data[ma]
# Taking the sign of the difference to determine whether the price or the EMA is greater
data['signal1'] = data['price_ma_diff'].apply(np.sign)
data['position1'] = data['signal1'].diff()
data['buy'] = np.where(data['position1'] == 2, data[ma], np.nan)
data['sell'] = np.where(data['position1'] == -2, data[ma], np.nan)

# plot with candle daily, sma 20, signal and yahoo style
import mplfinance as mpf
kwargs = dict(type='candle',figratio=(16,9),figscale=2)
aps = [
    mpf.make_addplot(data[ma],color='C0'), # blue
    mpf.make_addplot(data['buy'],color='g',type='scatter',markersize=78,marker='^'),
    mpf.make_addplot(data['sell'],color='r',type='scatter',markersize=78,marker='v'),
    mpf.make_addplot(data['signal1'],color='C1',panel=1,ylabel='signal')
]
mpf.plot(data,**kwargs,style='yahoo',title='AMZN',addplot=aps,savefig=dict(fname='plot.with.candle.daily.sma.20.signal.yahoo.style.png'))

# Moving Average Crossover Strategy - Sample 2
ma20 = 'SMA20'
ma50 = 'SMA50'
#ma20 = 'EMA20'
#ma50 = 'EMA50'
data['signal2'] = 0.0
data['signal2'] = np.where(data[ma20] > data[ma50], 1.0, 0.0)
data['position2'] = data['signal2'].diff()
data['buy'] = np.where(data['position2'] == 1, data[ma20], np.nan)
data['sell'] = np.where(data['position2'] == -1, data[ma20], np.nan)

# plot with candle daily, sma 20, sma 50, signal and yahoo style
import mplfinance as mpf
kwargs = dict(type='candle',figratio=(16,9),figscale=2)
aps = [
    mpf.make_addplot(data[ma20],color='C0'), # blue
    mpf.make_addplot(data[ma50],color='C1'), # orange
    mpf.make_addplot(data['buy'],color='g',type='scatter',markersize=78,marker='^'),
    mpf.make_addplot(data['sell'],color='r',type='scatter',markersize=78,marker='v'),
    mpf.make_addplot(data['signal2'],color='C1',panel=1,ylabel='signal')
]
mpf.plot(data,**kwargs,style='yahoo',title='AMZN',addplot=aps,savefig=dict(fname='plot.with.candle.daily.sma.20.sma.50.signal.yahoo.style.png'))