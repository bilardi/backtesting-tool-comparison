install.packages("quantmod")
require(devtools)
devtools::install_github("braverock/blotter")
devtools::install_github("braverock/quantstrat")

library(quantmod)
# initialization
Sys.setenv(TZ="UTC")
symbol = as.character("AMZN")
start <- as.Date("2017-01-01")
end <- as.Date("2020-01-01")
getSymbols(Symbols = symbol, src = "yahoo", from = start, to = end)

AMZN <- na.omit(lag(AMZN))
# calculate indicators
sma20 <- SMA(Cl(AMZN), n = 20)
ema20 <- EMA(Cl(AMZN), n = 20)

library(quantstrat)
# strategy initialization
currency("USD")
stock(symbol, currency = 'USD', multiplier = 1)
tradeSize <- 100000
initEquity <- 100000
account.st <- portfolio.st <- strategy.st <- "my strategy"
rm.strat("my strategy")
out <- initPortf(portfolio.st, symbols = symbol, initDate = start, currency = "USD")
out <- initAcct(account.st, portfolios = portfolio.st, initDate = start, currency = "USD", initEq = initEquity)
initOrders(portfolio.st, initDate = start)
strategy(strategy.st, store = TRUE)

# indicators with QuantStrat
out <- add.indicator(strategy.st, name = "SMA", arguments = list(x = quote(Cl(AMZN)), n = 20, maType = "SMA"), label = "SMA20periods")
out <- add.indicator(strategy.st, name = "SMA", arguments = list(x = quote(Cl(AMZN)), n = 50, maType = "SMA"), label = "SMA50periods")
out <- add.indicator(strategy.st, name = "EMA", arguments = list(x = quote(Cl(AMZN)), n = 20, maType = "EMA"), label = "EMA20periods")
out <- add.indicator(strategy.st, name = "EMA", arguments = list(x = quote(Cl(AMZN)), n = 50, maType = "EMA"), label = "EMA50periods")
out <- add.indicator(strategy.st, name = "RSI", arguments = list(price = quote(Cl(AMZN)), n = 7), label = "RSI720periods")
out <- add.indicator(strategy.st, name = "BBands", arguments = list(HLC = quote(Cl(AMZN)), n = 20, maType = "SMA", sd = 2), label = "Bollinger Bands")

# custom indicator
RSIaverage <- function(price, n1, n2) {
    RSI_1 <- RSI(price = price, n = n1)
    RSI_2 <- RSI(price = price, n = n2)
    calculatedAverage <- (RSI_1 + RSI_2) / 2
    colnames(calculatedAverage) <- "RSI_average"
    return(calculatedAverage)
}
out <- add.indicator(strategy.st, name = "RSIaverage", arguments = list(price = quote(Cl(AMZN)), n1 = 7, n2 = 14), label = "RSIaverage")

# first tests 
plot(RSIaverage(Cl(AMZN), n1=7, n2=14)) # for graphing your function results

# load all indicators on my data
test <- applyIndicators(strategy = strategy.st, mktdata = OHLC(AMZN))
subsetTest <- test["2018-01-01/2019-01-01"]
head(subsetTest)

# Moving Average Crossover Strategy - Sample 1
signalPosition <- function(price, ma) {
    # Taking the difference between the prices and the MA timeseries
    price_ma_diff <- price - ma
    price_ma_diff[is.na(price_ma_diff)] <- 0 # replace missing signals with no position
    # Taking the sign of the difference to determine whether the price or the MA is greater
    position <- diff(price_ma_diff)
    position[is.na(position)] <- 0 # replace missing signals with no position
    colnames(position) <- "Signal_position"
    return(position)
}

#out <- add.indicator(strategy.st, name = "signalPosition", arguments = list(price = Cl(AMZN), ma = sma20), label = "signalPosition")
out <- add.indicator(strategy.st, name = "signalPosition", arguments = list(price = Cl(AMZN), ma = ema20), label = "signalPosition1")
out <- add.signal(strategy.st, name = "sigThreshold", arguments = list(column = "Signal_position", threshold = 2, relationship = "gte", cross = TRUE), label = "buy1")
out <- add.signal(strategy.st, name = "sigThreshold", arguments = list(column = "Signal_position", threshold = -2, relationship = "lte", cross = TRUE), label = "sell1")
#add.signal(strategy.st, name = "sigThreshold", arguments = list(data = position, column = "AMZN.Close", threshold = 2, relationship = "gte", cross = TRUE), label = "buy1")
#add.signal(strategy.st, name = "sigThreshold", arguments = list(data = position, column = "AMZN.Close", threshold = -2, relationship = "lte", cross = TRUE), label = "sell1")
# Creating rules
out <- add.rule(strategy.st, name = 'ruleSignal', arguments = list(sigcol = "buy1", sigval = TRUE, orderqty = 100, ordertype = 'market', orderside = 'long'), type = 'enter')
out <- add.rule(strategy.st, name = 'ruleSignal', arguments = list(sigcol = "sell1", sigval = TRUE, orderqty = 'all', ordertype = 'market', orderside = 'long'), type = 'exit')
#out <- add.rule(strategy.st, name = 'ruleSignal', arguments = list(sigcol = "sell1", sigval = TRUE, orderqty = -100, ordertype = 'market', orderside = 'short'), type = 'enter')
#out <- add.rule(strategy.st, name = 'ruleSignal', arguments = list(sigcol = "buy1", sigval = TRUE, orderqty = 'all', ordertype = 'market', orderside = 'short'), type = 'exit')

# backtesting
applyStrategy(strategy.st, portfolios=portfolio.st)
out <- updatePortf(portfolio.st)
dateRange <- time(getPortfolio(portfolio.st)$summary)[-1]
out <- updateAcct(portfolio.st, dateRange)
out <- updateEndEq(account.st)
chart.Posn(portfolio.st, Symbol=symbol, TA=c("add_SMA(n=20,col='red')"))

tstats <- tradeStats(portfolio.st, use="trades", inclZeroDays=FALSE)
data.frame(t(tstats))

install.packages("magrittr") # package installations are only needed the first time you use it
install.packages("dplyr")    # alternative installation of the %>%
library(magrittr) # needs to be run every time you start R and want to use %>%
library(dplyr)    # alternatively, this also loads %>%
trades <- tstats %>%
    mutate(Trades = Num.Trades, 
        Win.Percent = Percent.Positive, 
        Loss.Percent = Percent.Negative, 
        WL.Ratio = Percent.Positive/Percent.Negative) %>%
    select(Trades, Win.Percent, Loss.Percent, WL.Ratio)
data.frame(t(trades))

a <- getAccount(account.st)
equity <- a$summary$End.Eq
plot(equity, main = "Equity Curve QQQ")

portfolio <- getPortfolio(portfolio.st)
portfolioSummary <- portfolio$summary
colnames(portfolio$summary)
tail(portfolio$summary)

ret <- Return.calculate(equity, method = "log")
tail(ret)
charts.PerformanceSummary(ret, colorset = bluefocus, main = "Strategy Performance")

rets <- PortfReturns(Account = account.st)
chart.Boxplot(rets, main = "QQQ Returns", colorset= rich10equal)

table.Drawdowns(rets, top=10)

table.CalendarReturns(rets)

table.DownsideRisk(rets)

table.Stats(rets)

chart.RiskReturnScatter(rets)

chart.ME(Portfolio = portfolio.st, Symbol = symbol, type = "MAE", scale = "percent")

chart.ME(Portfolio = portfolio.st, Symbol = symbol, type = "MFE", scale = "percent")

# Moving Average Crossover Strategy - Sample 2
# strategy resetting
rm.strat("my strategy")
out <- initPortf(portfolio.st, symbols = symbol, initDate = start, currency = "USD")
out <- initAcct(account.st, portfolios = portfolio.st, initDate = start, currency = "USD", initEq = initEquity)
initOrders(portfolio.st, initDate = start)
strategy(strategy.st, store = TRUE)
# Indicators
out <- add.indicator(strategy.st, name = "SMA", arguments = list(x = quote(Cl(AMZN)), n = 20, maType = "SMA"), label = "SMA20periods")
out <- add.indicator(strategy.st, name = "SMA", arguments = list(x = quote(Cl(AMZN)), n = 50, maType = "SMA"), label = "SMA50periods")
out <- add.indicator(strategy.st, name = "EMA", arguments = list(x = quote(Cl(AMZN)), n = 20, maType = "EMA"), label = "EMA20periods")
out <- add.indicator(strategy.st, name = "EMA", arguments = list(x = quote(Cl(AMZN)), n = 50, maType = "EMA"), label = "EMA50periods")
# Signals
#out <- add.signal(strategy.st, name = "sigCrossover", arguments = list(columns = c("SMA20periods", "SMA50periods"), relationship = "gte", cross = TRUE), label = "buy")
#out <- add.signal(strategy.st, name = "sigCrossover", arguments = list(columns = c("SMA20periods", "SMA50periods"), relationship = "lte", cross = TRUE), label = "sell")
out <- add.signal(strategy.st, name = "sigCrossover", arguments = list(columns = c("EMA20periods", "EMA50periods"), relationship = "gte", cross = TRUE), label = "buy2")
out <- add.signal(strategy.st, name = "sigCrossover", arguments = list(columns = c("EMA20periods", "EMA50periods"), relationship = "lte", cross = TRUE), label = "sell2")
# Rules
out <- add.rule(strategy.st, name = 'ruleSignal', arguments = list(sigcol = "buy2", sigval = TRUE, orderqty = 100, ordertype = 'market', orderside = 'long'), type = 'enter')
out <- add.rule(strategy.st, name = 'ruleSignal', arguments = list(sigcol = "sell2", sigval = TRUE, orderqty = 'all', ordertype = 'market', orderside = 'long'), type = 'exit')
#out <- add.rule(strategy.st, name = 'ruleSignal', arguments = list(sigcol = "sell2", sigval = TRUE, orderqty = -100, ordertype = 'market', orderside = 'short'), type = 'enter')
#out <- add.rule(strategy.st, name = 'ruleSignal', arguments = list(sigcol = "buy2", sigval = TRUE, orderqty = 'all', ordertype = 'market', orderside = 'short'), type = 'exit')

# backtesting
applyStrategy(strategy.st, portfolios=portfolio.st)
out <- updatePortf(portfolio.st)
dateRange <- time(getPortfolio(portfolio.st)$summary)[-1]
out <- updateAcct(portfolio.st, dateRange)
out <- updateEndEq(account.st)
chart.Posn(portfolio.st, Symbol=symbol) #, TA=c("add_SMA(n=20,col='red')"))

tstats <- tradeStats(portfolio.st, use="trades", inclZeroDays=FALSE)
data.frame(t(tstats))

#install.packages("magrittr") # package installations are only needed the first time you use it
#install.packages("dplyr")    # alternative installation of the %>%
#library(magrittr) # needs to be run every time you start R and want to use %>%
#library(dplyr)    # alternatively, this also loads %>%
trades <- tstats %>%
    mutate(Trades = Num.Trades, 
        Win.Percent = Percent.Positive, 
        Loss.Percent = Percent.Negative, 
        WL.Ratio = Percent.Positive/Percent.Negative) %>%
    select(Trades, Win.Percent, Loss.Percent, WL.Ratio)
data.frame(t(trades))

a <- getAccount(account.st)
equity <- a$summary$End.Eq
plot(equity, main = "Equity Curve QQQ")

ret <- Return.calculate(equity, method = "log")
charts.PerformanceSummary(ret, colorset = bluefocus, main = "Strategy Performance")

rets <- PortfReturns(Account = account.st)
chart.RiskReturnScatter(rets)
