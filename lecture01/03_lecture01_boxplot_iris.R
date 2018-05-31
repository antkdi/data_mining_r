#*****************************
# EDA: iris boxplot
# jangsea.park@boxnwhis.kr
# 2015-06-07
#*****************************

# load packages -----------------------------------------------------------

library(ggplot2)


# read datasets -----------------------------------------------------------

iris
str(iris)
?iris


# five-number summary -----------------------------------------------------

sl <- iris$Sepal.Length
sw <- iris$Sepal.Width
pl <- iris$Petal.Length
pw <- iris$Petal.Width

# 'fivenum' function
fivenum(sl)
fivenum(sw)
fivenum(pl)
fivenum(pw)

# 'summary' function
summary(iris)


# draw boxplot ------------------------------------------------------------

ggplot(iris, aes(x=Species, y=Sepal.Length)) +
    geom_boxplot() +
    theme_bw()

ggplot(iris, aes(x=Species, y=Sepal.Width)) +
    geom_boxplot() +
    theme_bw()

ggplot(iris, aes(x=Species, y=Petal.Length)) +
    geom_boxplot() +
    theme_bw()

ggplot(iris, aes(x=Species, y=Petal.Width)) +
    geom_boxplot() +
    theme_bw()


# draw boxplot using loop -------------------------------------------------

y.names <- names(iris)[1:4]

# use 'aes_string'
for (y.name in y.names) {
    p <- ggplot(iris, aes_string(x='Species', y=y.name)) +
        geom_boxplot() +
        theme_bw() +
        ggtitle(paste('Box plot for', y.names))
    print(p)
}

# save png files
for (y.name in y.names) {
    p <- ggplot(iris, aes_string(x='Species', y=y.name)) +
        geom_boxplot() +
        theme_bw() +
        ggtitle(paste('Box plot for', y.names))
    ggsave(p, filename=paste0('iris_boxplot_', y.name, '.png'))
}
