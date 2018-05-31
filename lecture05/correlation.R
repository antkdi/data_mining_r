#******************************
# FastCampus lecture05
# correlation
# jangsea.park@gmail.com
# 2015-06-21
#******************************

# load packages -----------------------------------------------------------

library(MASS)
library(ggplot2)
library(GGally)


# read dataset ------------------------------------------------------------

mammals
str(mammals)
?mammals


# draw scatter plot -------------------------------------------------------

ggplot(mammals, aes(x=body, y=brain)) +
    geom_point()

ggplot(mammals, aes(x=log10(body), y=log10(brain), label=rownames(mammals))) +
    geom_point() +
    theme_bw() +
    geom_text(hjust=0, vjust=0, angle=-45, alpha=.4)


# calculate correlation coefficient ---------------------------------------

with(mammals, cor(body, brain))
with(mammals, cor(log10(body), log10(brain)))


# draw scatter plot matrix ------------------------------------------------

ggpairs(iris[, 1:4])
ggpairs(iris, 1:4, colour = 'Species')
ggpairs(iris, colour = 'Species')
