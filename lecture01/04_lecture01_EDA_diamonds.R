#*****************************
# EDA diamonds
# jangsea.park@boxnwhis.kr
# 2015-06-07
#*****************************

# load package ------------------------------------------------------------

install.packages('ggplot2')
library(ggplot2)


# read data ---------------------------------------------------------------

filepath <- list.files(path='.', pattern='dia.*.csv')
d <- read.csv(file=filepath)
head(d)
View(d)
str(d)


# summary -----------------------------------------------------------------

str(diamonds)
summary(diamonds)
diamonds$carat
View(diamonds)

# carat
ggplot(diamonds, aes(x=carat)) +
    geom_histogram(binwidth=.1, colour='black', fill='white')

ggplot(diamonds, aes(x=carat)) +
    geom_density(fill = 'white')

ggplot(diamonds, aes(x=carat, fill=cut)) +
    geom_histogram(binwidth=.1, alpha=.4, position='identity')

ggplot(diamonds, aes(x=carat, fill=cut)) +
    geom_density(alpha=.3)

# cut
table(diamonds$cut)
ggplot(diamonds, aes(x=cut)) +
    geom_histogram()

# color
table(diamonds$color)
round(table(diamonds$color) / sum(table(diamonds$color)), 4)
ggplot(diamonds, aes(x=color, fill=cut)) +
    geom_histogram(position='dodge')

# depth
ggplot(diamonds, aes(x=depth)) +
    geom_histogram(binwidth=1)

ggplot(diamonds, aes(x=depth, fill=cut)) +
    geom_histogram(binwidth=1, position='identity', alpha=.2)

ggplot(diamonds, aes(x=depth, fill=cut)) +
    geom_density(alpha=.2)

# table
ggplot(diamonds, aes(x=table, fill=cut)) +
    geom_density(alpha=.3) +
    xlim(c(50, 70))

# depth * table | cut
ggplot(diamonds, aes(x=depth, y=table, color=cut)) +
    geom_jitter(alpha=.2) +
    xlim(c(50, 75)) +
    ylim(c(45, 75))

ggplot(diamonds, aes(y=depth/table, x=cut)) +
    geom_boxplot()

ggplot(diamonds, aes(x=depth/table, y=log10(price))) +
    geom_point()

ggplot(diamonds, aes(x=price)) +
    geom_histogram(binwidth=10) +
    xlim(c(0, 2000))

ggplot(diamonds, aes(x=price, fill=cut)) +
    geom_density(alpha=.2)

# x, y, z
ggplot(diamonds, aes(x=x)) +
    geom_histogram()
ggplot(diamonds, aes(x=y)) +
    geom_histogram()
ggplot(diamonds, aes(x=z)) +
    geom_histogram()

ggplot(diamonds, aes(x=y, y=z)) +
    geom_point()

ggplot(diamonds, aes(x=x*y*z, y=carat)) + geom_point()
diamonds[diamonds$x == 0,]
diamonds[diamonds$y == 0,]
diamonds[diamonds$z == 0,]

# price
ggplot(diamonds, aes(x=carat, y=price)) +
    geom_point(alpha=.1)

ggplot(diamonds, aes(x=price/carat, y=price)) +
    geom_point(alpha=.1)

ggplot(diamonds, aes(x=price/carat, y=price, color=carat)) +
    geom_point(alpha=.1)

ggplot(diamonds, aes(x=carat, y=price/carat)) +
    geom_point(alpha=.1)

ggplot(diamonds, aes(x=carat, y=price/carat, color=color)) +
    geom_jitter(alpha=.2) +
    facet_grid(cut ~ clarity, labeller=label_both, margin=T) +
    scale_colour_brewer() +
    xlim(c(0, 3)) +
    geom_smooth() +

ggsave('diamond_scatterplot.png')
