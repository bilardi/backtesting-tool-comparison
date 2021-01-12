# historical data

library(quantmod)
symbol <- "AMZN"
getSymbols(symbol) # or getSymbols(symbol, src = "yahoo")
head(AMZN) # returns some data of AMZN vector
colnames(AMZN) # returns column names of AMZN vector
#Op(AMZN) # only column of open of all data
#Hi(AMZN) # only column of high of all data
#Lo(AMZN) # only column of low of all data
#Cl(AMZN) # only column of close of all data
#Vo(AMZN) # only column of volume of all data
#Ad(AMZN) # value adjusted of the close (of all data)
#OHLC(AMZN) # columns open, high, low and close of all data

# Exchange rates (forex) from Yahoo finance
library(quantmod)
cross_from <- c("EUR", "USD", "CAD")
cross_to <- c("USD", "JPY", "USD")
getQuote(paste0(cross_from, cross_to, "=X"))

# Exchange rates (forex) from Oanda
library(quantmod)
currency <- "EUR/GBP"
# the last 6 months
getSymbols(currency, src = "oanda")
head(EURGBP) # returns some data of EURGBP vector
# the last 60 days
getSymbols(currency, from = Sys.Date() - 60, to = Sys.Date(), src = "oanda")
head(EURGBP) # returns some data of EURGBP vector

#  CoinMarketCap API
library(httr)
library(jsonlite)
base_url <- 'https://sandbox-api.coinmarketcap.com/'
get_coinmarketcap_data <- function(base_url, path, query) {
    response <- GET(url = base_url, path = paste('v1/', path, sep = ''), query = query)
    content <- content(response, 'text', encoding = 'utf-8')
    return(fromJSON(content, flatten = TRUE))
}
# returns all active cryptocurrencies
path <- 'cryptocurrency/map'
marketcap_map <- get_coinmarketcap_data(base_url, path, list())
head(marketcap_map$data)
# returns last market data of all active cryptocurrencies 
path <- 'cryptocurrency/listings/latest'
query <- list(convert = 'EUR')
last_marketcap <- get_coinmarketcap_data(base_url, path, query)
head(last_marketcap$data)
# returns last market data of Bitcoin
path <- 'cryptocurrency/quotes/latest'
query <- list(id = 1, convert = 'EUR')
last_bitcoin <- get_coinmarketcap_data(base_url, path, query)
last_bitcoin$data$`1`
last_bitcoin$data$`1`$`quote`$EUR
# returns historical data from a time_start to a time_end 
path <- 'cryptocurrency/quotes/historical'
query <- list(id = 1, convert = 'EUR', time_start = '2020-05-21T12:14', time_end = '2020-05-21T12:44')
data <- get_coinmarketcap_data(base_url, path, query)
head(data$data)

# Quandl library
library(Quandl)
oil_data <- Quandl(code = "CHRIS/CME_QM1")
head(oil_data) # returns all free columns names
#getPrice(oil_data) # returns all free columns values
#getPrice(oil_data, symbol = "CHRIS/CME_QM1", prefer = "Open$") # returns open values of a specific symbol
getPrice(oil_data, prefer = "Open$") # returns open values
