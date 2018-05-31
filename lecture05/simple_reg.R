#******************************
# FastCampus lecture05
# simple regression
# jangsea.park@gmail.com
# 2015-06-21
#******************************

# load packages -----------------------------------------------------------

library(MASS)
library(ggplot2)


# read dataset ------------------------------------------------------------

mammals
str(mammals)
?mammals


# fit simple regression model ---------------------------------------------

# fit simple regression model without log10 transformation
fit0 <- lm(brain ~ body, data=mammals)
summary(fit0)
mammals.corr <- with(mammals, cor(brain, body))
mammals.corr^2

# fit simple regression model with log10 transformation
fit <- lm(log10(brain) ~ log10(body), data=mammals)
summary(fit)

# check attributes of 'lm' object
class(fit)
attributes(fit)

# coefficients
fit$coefficients
coefficients(fit)

# residuals
fit$residuals
residuals(fit)

# fitted values
fit$fitted.values
fitted(fit)


# draw simple regression line ---------------------------------------------

# mammals data
ggplot(mammals, aes(x=log10(body), y=log10(brain))) +
    geom_point(shape=1) +
    geom_smooth(method=lm, se=F) +
    theme_bw()

# iris data without grouping
ggplot(iris, aes(x=Petal.Length, y=Petal.Width)) +
    geom_point(shape=1) +
    geom_smooth(method=lm, se=F) +
    theme_bw()

# iris data with color
ggplot(iris, aes(x=Petal.Length, y=Petal.Width, color=Species)) +
    geom_point(shape=1) +
    geom_smooth(method=lm, se=F) +
    theme_bw()

# iris data: scatter plot matrix
ggpairs(iris, 1:4, color='Species',
        lower = list(continuous = "smooth"))
