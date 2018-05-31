#***************************************
# lecture09 - simple prob simulation
# jangsea.park@gmail.com
# 2016-07-05
#***************************************

# install.packages --------------------------------------------------------

# required packages
required_pkgs <- c('uuid',
                   'ggplot2')
# installed packages' names
inst_pkgs <- rownames(installed.packages())
# new packages
new_pkgs <- required_pkgs[!(required_pkgs %in% inst_pkgs)]
# install packages
if (length(new_pkgs) != 0) install.packages(new_pkgs)

# load packages -----------------------------------------------------------

library(uuid)
library(ggplot2)

# make simulation ---------------------------------------------------------

set.seed(1234)
trial <- 365
repeatation <- 200
prob1 <- .51
prob2 <- .49
sim_df <- data.frame()
for (i in seq(repeatation)) {
    id1 <- rep(UUIDgenerate(), trial)
    id2 <- rep(UUIDgenerate(), trial)
    t <- 1:trial
    group1 <- rep(as.character(prob1), trial)
    group2 <- rep(as.character(prob2), trial)
    profit1 <- cumsum(rbinom(trial, 1, prob1) * runif(trial, 1, 3) - 1)
    profit2 <- cumsum(rbinom(trial, 1, prob2) * runif(trial, 1, 3) - 1)
    temp_df <- data.frame(id=c(id1, id2), 
                          t=c(t, t), 
                          profit=c(profit1, profit2), 
                          prob=c(group1, group2))
    sim_df <- rbind(sim_df, temp_df)
} 

# draw line plot ----------------------------------------------------------

# make plot
p_line <- 
    ggplot(sim_df, aes(x=t, y=profit, group=id, color=prob)) +
    geom_line(alpha=.4) +
    theme_bw() +
    xlab('Days') +
    ylab('Cumulative Profit')

# print plot
print(p_line)

# save image file
ggsave('sim_line_plot.png', width=10, height=6)


# draw boxplot ------------------------------------------------------------

# draw boxplot
p_box <- 
    ggplot(sim_df[sim_df$t == trial,], aes(x=prob, y=profit, fill=prob)) +
    geom_boxplot(notch=T) +
    theme_bw() +
    xlab('Prob') +
    ylab('Cumulative Profit at the last')

# print boxplot
print(p_box)

# save image file
ggsave('sim_boxplot.png', width=6, height=6)


# draw smoothing line -----------------------------------------------------

# draw smooth line
p_smooth <- 
    ggplot(sim_df, aes(x=t, y=profit, color=prob)) +
    theme_bw() +
    geom_smooth() +
    xlab('Days') +
    ylab('Cumulative Profit')

# print smooth line
print(p_smooth)

# save image file
ggsave('sim_smooth_line.png', width=10, height=6)

# draw smooth line with points
p_smooth_wp <- 
    ggplot(sim_df, aes(x=t, y=profit, color=prob)) +
    theme_bw() +
    geom_point(alpha=.1) +
    geom_smooth() +
    xlab('Days') +
    ylab('Cumulative Profit')

# print smooth line with points
print(p_smooth_wp)

# save image
ggsave('sim_smooth_line_wp.png', width=10, height=6)
