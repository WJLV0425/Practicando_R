# Author: Welifer Lebron  Vicente
# Student and Research Assistant at Universidad Autónoma de Santo Domingo (UASD).
# Date: January, 2021.

### Bibliography: Hands-On Spatial Data Analysis with R and QGIS 3.2.2. (Islam S., 2018).

### PRACTICE WITH R, ESSENTIAL KNOLEDGE FOR CODING.

## Data structures in R are as follows: vectors, matrices, arrays,data frames, lists, and factors. 

# To create a variable we use "<-" or "=".

X <- 2
x = 2

# Vectors are used to store single or multiple values of similar data types in a variable and are considered to be one-dimensional arrays. We put all the values inside c() and separate them with "," except for the last value.

val= c(1,2,3,4,5,6)

# We also can mix different data types such as numeric and characters, a variable's name can be anything except for those started by an special character. 

y= c(1,2.0,3.0,4,5, "Hello", "OK")

# What R does in cases like the one above is to try to convert the values mentioned for Y to the same type. However, as r cannot convert "Hello" and "OK" to numeric, it converts values "1,2.0,3.0,4,5" to character values and assings all of them to variable y.

class(y)

# We can label vectors or give names to different values according to our needs.

temperatura = c(moring = 20, before_noon = 23, after_noon = 25, evening = 22, night = 18)

## BASIC OPERATIONS WITH VECTORS

# We have prices $10, $20 and $30 for commodities potatoes, rice and oil respectively in January 2018, denoted by the vector "jan_price". On the other hand, we have all the prices of these elements increased by $1, $2, $3 respectively by March 2018, denoted by "increase".

jan_price = c(10,20,30)
increase = c(1,2,3)
mar_price = jan_price + increase

# Of course we can also excute other operations as subtract, multiply, division, etc.

x = c(10,20,30)
y = c(1,2,3)
x * y
x - y
x / y
x * 2

# If we want to know which values are greater than 15, we will see "TRUE" for those that fit this condition and "FALSE" for those that does not :

x > 15

# For selecting or excluding a value we use [] and [-]:

x[2]
x[-2]

## MATRIX

# A matrix is basically a two-dimensional array of data elements with a number of columns and rows fixed. Like a vector, it can also contain one type of values/elements; two or more is not permitted. By using "matrix()" command, we can combine vector in one matrix, follow by a comma and ´nrow = 3´ indicating that there are three different items, in this case.

june_price = c(20,25,33) # Added to carry out the example.
june_price

all_prices = matrix (c(jan_price,mar_price,june_price), nrow = 3)
all_prices

# Introducing 'byrow = TRUE' in the matrix we get the vectors row-wise organized.

all_prices2 = matrix(c(jan_price,mar_price,june_price), nrow = 3, byrow = TRUE)
all_prices2

## ARRAY

#Arrays are also matrices, but they allow us to have more than two dimensions.
# Let's suppose that we want to add prices for the same period in 2017. We can do so by using array(), as in this case we'd like to add two 3x3 matrices (2018 and 2017); in array(m,n,p) m and n stands for the dimensions of the matrix and p stands for how many matrices we want to store. To carry out this example we must create 6 new vectors:

jan_price2018 = jan_price
mar_price2018 = mar_price
june_price2018 = june_price
jan_price2017 = c(10,10,17)
mar_price2017 = c(18,23,21)
june_price2017 = c(25,31,35)

combined = array(c(jan_price2018,mar_price2018,june_price2018,jan_price2017,mar_price2017,june_price2017), dim = c(3,3,2))
combined

## DATA FRAMES

# Data frames are like matrices, except for the condition that now we can have a nix of different element types. Data frames allow us to put names to items along with their prices. In order to do that, first we create a variable containing the names of food items.

items = c("potato", "rice", "oil")

#Now we define the data frame by using 'data.frame' as follows:

all_prices3 = data.frame(items, jan_price, mar_price, june_price)
all_prices3

# Accessing elements in a data frame can be done by using either [[]] or $. For example, let's select 'mar_price' on the second column, we can do either of the two ways explained.

all_prices3$mar_price
all_prices3[["mar_price"]]

# Also we can use [] to access to a data frame. In this instance, we use both rows and columns dimensions to access an element (or elements) in the order [row, column]. Similarly we can drop elements by adding '-'.

all_prices3[2,3]
all_prices4 = all_prices3[-1] # Column "items" was dropped. 
all_prices4

# We can add a row by using the command rbind(). To recreate this we will define the vector "pen" which is numerical and contains prices for this item in the months mentioned above.

pen = c(3,4,3.5)
all_prices4 = rbind(all_prices4, pen)
all_prices4 # Here we see the values for 'pen' in each month in row number 4.

# A new column can be defined by cbind().

aug_price = c(22,24,31,5)
all_prices4 = cbind(all_prices4, aug_price)
all_prices4

## LISTS

# Using lists we can get almost all the advantages of a dta frame in addition to its capacity for storing different sets of elements with different lenghts.

all_prices_list2 = list(items, jan_price, mar_price, june_price)
all_prices_list2

# Accessing list elements can be done by using [] (for a list) and [[]] if wanna have back an specific element.

all_prices_list2[2]
class(all_prices_list2[2]) #To confirm it is a "list".

# We can get data in its original type by [[]].

all_prices_list2[[2]]
class(all_prices_list2[[2]]) # `numeric`

# Categorical variables con be created with factor().

x= c(1,2,3)
x= factor(x)
class(x) # "factor".

# To look at the internal structure of a vector is possible with str().

str(x)



## LOOPING, FUNCTIONS, AND APPLY FAMILY IN R
# Looping allow us to do repetitive tasks in a couple of lines of code, saving us much effort and time. Functions allow us to write a block of instructions that could be modified by to work according to the way they are being called.

## LOOPING IN R

# Suppose we want to loop through all the values of the aug_price column inside all_prices4 and square them and return them. We can do so in the following way:

jan = all_prices4$jan_price
  for(price in jan){
    print (price^2)
  }

## FUNCTIONS IN R

# The prior result can be achieved also by using a function. Let's name this function `square`:

square = function(data){
  for(price in data){
    print(price^2)
  }
}

# The resulting function must be called in the following way:

square(all_prices4$jan_price)

# For having the ability to take elements to any power, not just `square`, we attain it by making a little tweak the function:

power_function = function(data,power){
  for(price in data){
    print(price ^ power)
  }
}

power_function(all_prices4$june_price, 4)

## APPLY FAMILY - LAPPLY, SAPPLY, APPLY, TAPPLY.

# This family of functions allow us not to write loops and reduces our workload.

# APPLY works in arrays or matrices and gives us an easier way to compute something row-wise or column-wise. This function takes the following form: `apply(data, margin, function)`. this data has to be an array or a matrix, the margin can be either 1 (row-wise) or 2 (column-wise) for the operations. We'll work with the matrix "all_prices":

# all_prices structure =        [,1] [,2] [,3]
#                         [1,]   10   11   20
#                         [2,]   20   22   25
#                         [3,]   30   33   33

# If we want to know which items fluctuated most over the three months, we would have to compute and standard deviation (sd) row-wise for each now.

apply(all_prices, 1, sd)

# If we want to know the month-wise total cost of all three items:

apply(all_prices, 2, sum)

# LAPPLY allows us to define a function (or use an existing one) over all the elements of a list or vector and it returns a list, and advantage of its use is that we stop using  `for` loop to loop. Let's redefine power_function for this example.

# Structure: lapply(data, function, arguments_of_the_function) 

power_function2 = function(data, power){
  data^power
}
lapply(all_prices4$june_price, power_function2, 4) # What we obtain is a list, we can use `unlist()`to get a simple vector for our convenience.

unlist(lapply(all_prices4$june_price, power_function2, 4))

# Now we'll work with a combined array, which has the prices mentioned for 2017 and 2018.

# Structure of the arrays:2018       [,1] [,2] [,3]
#                               [1,]   10   11   20
#                               [2,]   20   22   25
#                               [3,]   30   33   33

#                         2017       [,1] [,2] [,3]
#                              [1,]   10   18   25
#                              [2,]   10   23   31
#                              [3,]   17   21   35

combined2 = list(matrix(c(jan_price2018, mar_price2018, june_price2018), nrow = 3),
matrix(c(jan_price2017, mar_price2017, june_price2017), nrow = 3))
combined2

# Now, if we want the prices for March of 2017 and 2018, we can use lapply():

lapply(combined2, "[", 2, )

# "[" selects items, "2" selects second row, "lapply" means for all lists, " space after 2," means for all columns.

# `lapply()` can be used with data frames, lists, and vectors.

#SAPPLY

# What we have got in line 215 can be obtained simply by using `sapply(data, function, arguments_of_the_function)`.

sapply(all_prices4$june_price, power_function2, 4)

#TAPPLY

# Let's suppose we have prices for all years from 2015 to 2018. This new data frame is defined as follows:

items = factor(items)
all_prices = data.frame(items=rep(c("potato", "rice", "oil"), 4),
jan_price = c(10,20,30,10,18,25,9,17,24,9,19,27),
mar_price = c(11,22,33,13,25,32,12,21,33,15,27,39),
june_price = c(20,25,33,21,24,40,17,22,27,13,18,23)
)

all_prices

# To extract the mean prices for every March in all years, we use `tapply(numerical_variable, categorical_variable, function)`. So we will need to convert the items column of the all_prices data frame to a categorical varable to take the mean price.

tapply(all_prices$mar_price, factor(all_prices$items), mean) 
# This gives us mean March price for oil, potato, and rice in all years.

class(items)
items = factor(items)
str(all_prices)
