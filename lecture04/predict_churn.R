#*********************************
# predict churns
# 2015-06-15
# jangsea.park@gmail.com
#*********************************

# load packages -----------------------------------------------------------

library(dplyr)
library(ggplot2)

# read data ---------------------------------------------------------------

source('get_data.R')
head(login)
tail(login)
str(login)
View(login)

# calculate session intervals ---------------------------------------------

login <- tbl_df(login)
login$datetime <- as.POSIXct(login$datetime, 
                             format = '%Y-%m-%d %H:%M:%S', 
                             tz = 'UTC')
interval_logs <- 
    login %>%
    group_by(cid) %>%
    mutate(next_datetime = lead(datetime),
           interval_days = as.integer(difftime(next_datetime, 
                                               datetime, 
                                               unit = 'days'))) %>%
    filter(interval_days > 0 & !is.na(interval_days)) %>%
    mutate(interval_number = row_number(datetime),
           last_lapse = as.integer(difftime(as.POSIXct('2015-03-31 23:59:59',
                                                       format = '%Y-%m-%d %H:%M:%S',
                                                       tz = 'UTC'),
                                            max(next_datetime),
                                            unit = 'days')),
           churn = as.integer(last_lapse > 8))

# calculate the rate of churn users --------------------------------------

cnt_churn <- 
  interval_logs %>%
  ungroup %>%
  filter(churn == TRUE) %>%
  summarise(cnt_churn = n_distinct(cid))

as.integer(cnt_churn) / length(unique(interval_logs$cid))

# calculate the means of intervals ----------------------------------------

rr_logs <- 
  interval_logs %>%
  group_by(cid) %>%
  summarise(risk_ratio = max(last_lapse) / mean(interval_days),
            churn = max(churn))


# fit logistic regression -------------------------------------------------

fit <- glm(churn ~ risk_ratio, data = rr_logs, family = binomial())


# draws curve -------------------------------------------------------------

df_curve = data.frame(risk_ratio = rr_logs$risk_ratio, 
                      p_churn = predict(fit, type="response"))
plot(df_curve$risk_ratio, df_curve$p_churn, xlim = c(0, 5), type = 'p', cex = .1)

ggplot(df_curve, aes(risk_ratio, p_churn)) + 
    geom_line() +
    xlab('Risk Ratio') +
    ylab('Probability of Churn') +
    xlim(0, 5) +
    ylim(0, 1) +
    annotate("text", 
             x = 4, 
             y = 0.1, 
             label = paste0('Prob.Churn==over(1, 1 + exp(',
                            round(-fit$coefficients[1], 2), 
                            ' ', 
                            round(-fit$coefficients[2], 2), 
                            ' %*% RR))'), 
             parse = TRUE, 
             size = 5) +
    theme_bw(base_size = 12, base_family = "")

ggsave(file='single_churn_curve.png')
