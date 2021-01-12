install.packages("quantmod")
install.packages("httr")
install.packages("Quandl")
install.packages("plotly")
install.packages("devtools")
devtools::install_github("amrrs/coinmarketcapr")
install.packages("coindeskr")
require(devtools)
# install.packages("quantstrat", repos = "http://R-Forge.R-project.org") # package ‘quantstrat’ is not available (for R version 4.0.1)
devtools::install_github("braverock/blotter")
devtools::install_github("braverock/quantstrat")

# getting started

# initialization of a variable
my_numeric_variable <- 1
my_string_variable <- "hello"
# print a variable
my_numeric_variable # and type enter
print(my_string_variable)

# vectors
myNumericVector = c(1,2,3,4,5,6)
mySequence = 1:24
myStringVector = c("hello", "world", "!")
myStringVector[1] # print hello
myStringVector[-2] # print hello!
myStringVector[1:2] # print hello world
myStringVector[c(1,3)] # print hello!

myLogicVector = c(TRUE, FALSE, T, F)
assign("myVector", c(1:6))
# operations with vectors
sum(myNumericVector)
mean(myNumericVector)
median(myNumericVector)
myVector*2
myVector/2
myNewVector <- myNumericVector + myVector # allow
myNewVector <- myNumericVector + mySequence # allow
myNewVector <- myNumericVector + c(1:5) # deny

# matrix
myMatrix <- matrix(1:10, nrow = 2, ncol = 5)
myMatrix[2,2] # prints 4
myMatrix[1,] # prints row 1
myMatrix[,2] # prints column 2
# merge of vectors
vectorOne <- c("one", 0.1)
vectorTwo <- c("two", 1)
vectorThree <- c("three", 10)
myVectors <- matrix(c(vectorOne, vectorTwo, vectorThree), nrow = 3, ncol = 2, byrow = 1)
colnames(myVectors) <- c("vector number", "quantity")
rownames(myVectors) <- c("yesterday", "today", "tomorrow")

# functions
RSIaverage <- function(price, n1, n2) {
  RSI_1 <- RSI(price = price, n = n1)
  RSI_2 <- RSI(price = price, n = n2)
  calculatedAverage <- (RSI_1 + RSI_2) / 2
  colnames(calculatedAverage) <- "RSI_average"
  return(calculatedAverage)
}
