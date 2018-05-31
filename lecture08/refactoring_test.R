temp01 <- read.csv('http://s.g15e.com/temp01.csv')
temp02 <- read.csv('http://s.g15e.com/temp02.csv')
temp03 <- read.csv('http://s.g15e.com/temp03.csv')

temp01 <- transform(temp01, date=as.integer(substr(date, 7, 9)))
temp02 <- transform(temp02, dt=as.integer(substr(dt, 7, 9)))
temp03 <- transform(temp03, month.and.date=as.integer(substr(month.and.date, 5, 7)))

temp03 <- transform(temp03, fahrenheit=(fahrenheit-32)/1.8)

temp01 <- subset(temp01, select=c("date", "temp"))
temp02 <- subset(temp02, select=c("dt", "temperature"))
temp03 <- subset(temp03, select=c("month.and.date", "fahrenheit"))

colnames(temp02) <- c("date","temp")
colnames(temp03) <- c("date","temp")

df <- rbind(temp01, temp02, temp03)


# upgrade coding ----------------------------------------------------------

cleanse01 <- function(){
  temp01 <- read.csv('http://s.g15e.com/temp01.csv')
  temp01 <- transform(temp01, date=as.integer(substr(date, 7, 9)))
  temp01 <- subset(temp01, select=c("date", "temp"))
  return(temp01)
}

cleanse02 <- function(){
  temp02 <- read.csv('http://s.g15e.com/temp02.csv')
  temp02 <- transform(temp02, dt=as.integer(substr(dt, 7, 9)))
  temp02 <- subset(temp02, select=c("dt", "temperature"))
  colnames(temp02) <- c("date","temp")
  return(temp02)
}

cleanse03 <- function(){
  temp03 <- read.csv('http://s.g15e.com/temp03.csv')
  temp03 <- transform(temp03, month.and.date=as.integer(substr(month.and.date, 5, 7)))
  temp03 <- transform(temp03, fahrenheit=(fahrenheit-32)/1.8)
  temp03 <- subset(temp03, select=c("month.and.date","fahrenheit"))
  colnames(temp03) <- c("date","temp")
  return(temp03)
}

df <- rbind(cleanse01(),cleanse02(),cleanse03())


# upgrade coding 2 --------------------------------------------------------
# 최대한 동일하게 맞춰 반복을 제거한다

func.1 <- function(df) {
  return(transform(df, date=as.integer(substr(date, 7, 9))))
}
func.2 <- function(df) {
  return(transform(df, date=as.integer(substr(date, 5, 7))))
}
func.3 <- function(df) {
  return(transform(df, temp=(temp-32)/1.8))
}

cleanse <- function(src, columns, convs){
  temp <- read.csv (src)
  temp <- subset(temp, select=columns)
  colnames(temp) <- c("date","temp")
  
  for (conv in convs){
    temp <- conv(temp)
  }
  return(temp)
  
}

df <- rbind(
  cleanse('http://s.g15e.com/temp01.csv', c("date", "temp"), c(func.1)),
  cleanse('http://s.g15e.com/temp02.csv', c("dt", "temperature"), c(func.1)),
  cleanse('http://s.g15e.com/temp03.csv', c("month.and.date","fahrenheit"), c(func.2, func.3))
)

cleanse(src, columns, convs)  
  

