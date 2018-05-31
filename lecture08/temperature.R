conv.date1 <- function(df) {
  return(transform(df, date=as.integer(substr(date, 7, 9))))
}
conv.date2 <- function(df) {
  return(transform(df, date=as.integer(substr(date, 5, 7))))
}
conv.f2c <- function(df) {
  return(transform(df, temp=(temp - 32) / 1.8))
}
cleanse <- function(src, columns, convs) {
  temp <- read.csv(src)
  temp <- subset(temp, select=columns)
  colnames(temp) <- c('date', 'temp')
  
  for(conv in convs) {
    temp <- conv(temp)
  }  
  return(temp)
}

df <- rbind(
  cleanse('http://s.g15e.com/temp01.csv', c('date', 'temp'), c(conv.date1)),
  cleanse('http://s.g15e.com/temp02.csv', c('dt', 'temperature'), c(conv.date1)),
  cleanse('http://s.g15e.com/temp03.csv', c('month.and.date', 'fahrenheit'), c(conv.date2, conv.f2c))
)
