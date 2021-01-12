# graphics

library(quantmod)
# initialization
symbols = c("AMZN", "FB", "NFLX", "MSFT")
start <- as.Date("2017-01-01")
end <- as.Date("2020-01-01")
getSymbols(Symbols = symbols, src = "yahoo", from = start, to = end)
# get only Close values of AMZN and MSFT symbols
stocks <- as.xts(data.frame(AMZN = AMZN[,"AMZN.Close"], MSFT = MSFT[,"MSFT.Close"]))

# plotting
library(plotly)
plot(AMZN[,"AMZN.Close"], main = "AMZN") # prints linear graph

# create a custom theme
my_theme <- chart_theme()
my_theme$col$up.col <- "darkgreen"
my_theme$col$up.border <- "black"
my_theme$col$dn.col <- "darkred"
my_theme$col$dn.border <- "black"
my_theme$rylab <- FALSE
my_theme$col$grid <- "lightgrey"

# using the custom theme with a range
chart_Series(AMZN, subset = "2017-10::2018-09", theme = my_theme)

# using the custom theme with a range of one month
chart_Series(AMZN, subset = "2018-09", theme = my_theme)

# using the candle theme of quantmod
candleChart(AMZN, up.col = "green", dn.col = "red", theme = "white")

# zoom of graph on one month
zoomChart("2018-09")

# zoom of graph on one year
zoomChart("2018")

# add indicators
addSMA(n = c(20, 50, 200)) # adds simple moving averages
addBBands(n = 20, sd = 2, ma = "SMA", draw = "bands", on = -1) # sd = standard deviation, ma = average
AMZN_ema_21 <- EMA(Cl(AMZN), n=21) # exponencial moving average
addTA(AMZN_ema_21, on = 1, col = "red")
AMZN_ema_50 <- EMA(Cl(AMZN), n=50) # exponencial moving average
addTA(AMZN_ema_50, on = 1, col = "blue")
AMZN_ema_200 <- EMA(Cl(AMZN), n=200) # exponencial moving average
addTA(AMZN_ema_200, on = 1, col = "orange")
