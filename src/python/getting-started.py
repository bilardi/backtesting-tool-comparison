# initialization of a variable
my_numeric_variable = 1
my_string_variable = "hello"
# print a variable
my_numeric_variable # and type enter
print(my_string_variable)

# initialization of a vector
my_numeric_vector = [1,2,3,4,5,6]
my_sequence = list(range(1,7))
my_string_vector = ["hello", "world", "!"]
my_logic_vector = [True, False]
import random
my_random_vector = random.sample(list(range(1,5000)), 25) # Vector with 25 elements with random number from 1 to 5000

# operations with vectors
sum(my_numeric_vector)
import statistics
statistics.mean(my_numeric_vector)
statistics.median(my_numeric_vector)
import numpy
numpy.median(my_numeric_vector)

# multiplication 2 with each element of a vector
[e * 2 for e in my_numeric_vector]
list(map(lambda x: x * 2, my_numeric_vector))
import pandas
serie = pandas.Series(my_numeric_vector)
(serie * 2).tolist()
import numpy
list(numpy.array(my_numeric_vector) * 2)

# division 2 with each element of a vector
[e / 2 for e in my_numeric_vector]

# sum each element of a vector with another vector by position
my_new_vector = [sum(e) for e in zip(my_numeric_vector, my_sequence)]
my_new_vector = [x + y for x, y in zip(my_numeric_vector, my_sequence)]
import operator
my_new_vector = list(map(operator.add, my_numeric_vector, my_sequence))
import pandas
pandas.Series(my_numeric_vector).add(pandas.Series(my_sequence))
import numpy
numpy.array(my_numeric_vector) + numpy.array(my_sequence)

# get element from a vector
my_string_vector[0] # print hello
my_string_vector[::len(my_string_vector)-1] # print hello!
my_string_vector[0:2] # print hello world

# add labels to a vector
import pandas
names = ["one","two","three","four","five","six"]
my_vector = pandas.DataFrame(my_numeric_vector, index=names).T
print(my_vector)

# get data type of a vector
import numpy
numpy.array(my_vector).dtype.type # print numpy.int64
numpy.array(my_string_vector).dtype.type # print numpy.str_

# convertion of each element of a vector
[str(e) for e in my_numeric_vector]
list(map(str, my_numeric_vector))

# matrix
my_matrix = [[0] * 5 for e in range(2)] # creates a matrix bidimensional with 2 rows and 5 columns
my_matrix = [list(range(1,6)) for e in range(2)] # creates a matrix bidimensional with 2 rows and 5 columns
import numpy
my_matrix = numpy.arange(1,11).reshape(2, 5) # creates a matrix bidimensional with 2 rows and 5 columns
my_matrix = numpy.arange(1,11).reshape(5, 2).T # creates a matrix bidimensional with 2 rows and 5 columns like R language
my_matrix[1,1] # prints 4
my_matrix[0,] # prints row 1
my_matrix[:,1] # prints column 2
# merge of vectors
vector_one = ["one", 0.1]
vector_two = ["two", 1]
vector_three = ["three", 10]
my_vectors = [vector_one, vector_two, vector_three]
import pandas
colnames = ["vector number", "quantity"]
rownames = ["yesterday", "today", "tomorrow"]
pandas.DataFrame(my_vectors, index=rownames, columns=colnames)

# performance
apple_performance = 3
netflix_performance = 7
amazon_performance = 11
# weight
apple_weight = .3
netflix_weight = .4
amazon_weight = .3
# portfolio performance
weighted_average = apple_performance * apple_weight + netflix_performance * netflix_weight + amazon_performance * amazon_weight
# the same sample but with vectors
performance = [3,7,11]
weight = [.3,.4,.3]
company = ['apple','netflix','amazon']
import pandas
performance = pandas.DataFrame(performance, index=company).T
weight = pandas.DataFrame(weight, index=company).T
print(performance)
print(weight)
# with headers
performance_weight = performance.multiply(weight)
print(performance_weight)
weighted_average = performance_weight.sum(axis=1)
weighted_average
# without headers
import numpy
performance_weight = numpy.array(performance) * numpy.array(weight)
print(performance_weight)
weighted_average = numpy.sum(performance_weight)
print(weighted_average)

import numpy
# the weighted average but with a function
def weighted_average_function(performance, weight):
    return numpy.sum(numpy.array(performance) * numpy.array(weight))
performance = [3,7,11]
weight = [.3,.4,.3]
weighted_average = weighted_average_function(performance, weight)