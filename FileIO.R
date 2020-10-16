#csv file read
df <- read.csv("./서울시 실시간 자치구별 대기환경 현황.csv",  fileEncoding = "utf-8")
df

#csv file save
write.csv(df, file="dataframe.csv")

# excel file read 
# -> must install readxl package when use library function
#install.packages("readxl")
library(readxl)

jumin <- read_excel("./peopleSeoul.xls")
jumin <- jumin[-c(1:3), ]
str(jumin)

# string -> int
jumin <- jumin[, c(2,4,7,10,14)]
View(jumin)

# change column name
names(jumin) <- c("구별","인구수","한국인","외국인","고령자")
names(jumin)
str(jumin)
# string -> int
jumin$구별 <- as.numeric(jumin$구별)
jumin$인구수 <- as.numeric(jumin$인구수)
jumin$한국인 <- as.numeric(jumin$한국인)
jumin$외국인 <- as.numeric(jumin$외국인)
jumin$고령자 <- as.numeric(jumin$고령자)

# 외국인 비율 컬럼 생성
jumin$외국인비율 <- round(jumin$외국인 / jumin$인구수 * 100,2)
jumin$고령자비율 <- round(jumin$고령자 / jumin$인구수 * 100,2)

# install 시각화 package
#install.packages("ggplot2")
library(ggplot2)

# ggplot() 사용법
#1. 데이터를 지정, 축 설정
#2. 그래프의 종류 지정
ggplot(jumin, aes(x = 인구수 , y = 고령자))
# 산점도 그래프 
ggplot(jumin, aes(x = 인구수 , y = 고령자)) + geom_point()
ggplot(jumin, aes(x = 인구수 , y = 고령자)) + geom_point(aes(col = 구별, size = 2))
# 회귀선 추가
ggplot(jumin, aes(x = 인구수 , y = 고령자)) + geom_point(aes(col = 구별, size = 2)) + geom_smooth()
# 막대 그래프 
ggplot(jumin, aes(x = 구별, y = 인구수)) + geom_bar(stat='identity', fill = 'blue')

ggplot(jumin, aes(x = 구별, y = 인구수)) + geom_boxplot()
