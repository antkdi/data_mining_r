#******************************
# FastCampus lecture05
# basic
# jangsea.park@gmail.com
# 2015-06-21
#******************************

# load packages -----------------------------------------------------------

library(ggplot2)

# factor ------------------------------------------------------------------

grade <- c('A', 'B', 'C', 'D', 'F')
grades <- sample(grade, 50, replace=T)

grades1 <- factor(grades)
grades1
class(grades1)

grades2 <- factor(grades, levels=rev(grade), ordered = T)
grades2
class(grades2)

# frequency table ---------------------------------------------------------

?mtcars
str(mtcars)
View(mtcars)

# frequency table
mtcars$cyl
table(mtcars$cyl)
table(mtcars$mpg)

# histogram
qplot(mtcars$mpg, binwidth=5)
qplot(iris$Sepal.Length, binwidth=.5)
