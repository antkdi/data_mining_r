library(stringr)

# 웹사이트에 연결하여 소스코드 읽어오기
conn <- url("http://www.bagazimuri.com/product/list.html?cate_no=150")
lines <- readLines(conn, encoding='UTF-8')
close(conn)

# 상품명 추출하기
p.product <- "cate_no=150&.+>(.+)</span></a>"
products <- str_match(lines, p.product)[,2]
products <- products[!is.na(products)]

# 상품 가격 추출하기
p.price <- ">판매가.+?([\\d,]+)원"
prices <- str_match(lines, p.price)[,2]
prices <- prices[!is.na(prices)]
prices <- gsub(",", "", prices)
prices <- as.integer(prices)

# 상품명에서 카테고리 추출하기
p.category <- ".+-(.+)$"
categories <- str_match(products, p.category)[,2]

# data frame으로 만들기
df <- data.frame(products, prices, categories)
names(df) <- c('product', 'price', 'category')
