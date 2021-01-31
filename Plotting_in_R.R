# Author: Welifer Lebron  Vicente
# Student and Research Assistant at Universidad Autónoma de Santo Domingo (UASD).
# Date: January, 2021.

### Bibliography: Hands-On Spatial Data Analysis with R and QGIS 3.2.2. (Islam S., 2018).

### PRACTICE WITH R, ESSENTIAL KNOLEDGE FOR CODING.

## PLOTTING IN R.

# We can make simple plot using the "plot()" function. Now we we will simulate 50 values from a normal distribution using rnorm() and assign these to "x" and similarly generate and assign 50 normally distributed values to "y". We can plot these values i the following way:

x = rnorm(50)
y = rnorm(50)
# pch = 19 stands for filled dot
plot(x,y,pch = 19, col= 'blue')

# We can also generate a line plot type of graph by adding 'type=l' inside 'plot()'.
plot(x,y,pch = 19, col= 'blue', type = "l")

# Now we'll look at a very strong graphical library called 'ggplot2' (Wickham H.). Let's have a look at the 'all_prices' data frame, for this example:

str(all_prices)
