#***********************************
# get data from file
# jangsea.park@gmail.com
# 2015-06-15
#***********************************

# read data ---------------------------------------------------------------

login <- read.csv(file='fake_logs.csv', stringsAsFactors = F, header = F)
names(login) <- c('cid', 'datetime')
