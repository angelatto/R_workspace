# 이리컴/이채정-20201016
# 변수
a <- 4
a

b <- 3.14
b

# combine 함수 c() - 1차원 벡터 생성 
c <- c(2,4,6,8,10)
c

d <- 1:10
# d <- seq(1, 10, by=1)
d

# seq는 증가함수
e <- seq(2, 3, by=0.5)
e

# repeat 함수
f <- rep(1:2, time=3)
f
g <- rep(1:2, each=3)
g

# 날짜 데이터
h <- seq(as.Date("2020-10-16"), as.Date("2020-10-24"), by="day")
h

i <- seq(as.Date("2020-10-16"), as.Date("2020-10-24"), by="month")
i

df <- data.frame(col1 = c(1,2,3,4,5), 
                 col2 = c(1.1, 2.1, 3.1, 4.1, 5.1),
                 col3 = c('a', 'b', 'c', 'd', 'e'),
                 col4 = c('1', '2', '3', '4', '5'))
df

nrow(df) #row
ncol(df) #column
dim(df)  # both

str(df)
summary(df) # 통계 요약 정보 출력

head(df) # 상위 6개 데이터만 출력 
head(df, 3) 
tail(df, 2)

names(df) # column name
View(df) # table format 

# select data from "data frame"
df[1, 2] # index 
df[2,] #row 2
df[3,3]
df[2:4, 3]
df[-1, ] # except row-1 
df[,-1] # except col-1

# compare 1df, 2df print 
df[,2] #1df
df$col2 #1df
df["col2"] #2df

# add col
df$col5 <- c('aa','bb','cc','dd','ee')
df

df$col1 + df$col2
df$col6 <- df$col1 + df$col2
df
