# 실거래가 데이터 수집 및 가공
install.packages("XML")
install.packages("RCurl")
library(XML)
library(RCurl)

key <- "ibxzH4eRUCqeGIvpkkpH%2FXZ294v31%2B6MD6h6VYaDdrZCN85OiGMCah4auAIMwBg%2FsSIgRrhE1ma40McF4SqArA%3D%3D"

url <- "http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTradeDev?"

# paste0 > 문자열 합치기 함수 
#법정동 코드 : 행정안전부 > 주민등록주소코드> 주민등록 행정구역 코드 (앞5자리)
url <- paste0(url, 'LAWD_CD=', 11110)    # LAWD_CD : 법정동 코드 (서울시 종로구)
url <- paste0(url, '&DEAL_YMD=', 201908) # DEAL_YMD : 거래 년월 
url <- paste0(url, '&serviceKey=', key)  # serviceKey : 인증키 > 개발 1000건, 운영 100만

res <- getURL(url, .encoding = "UTF-8")
res
doc <- xmlParse(res)
doc
getNodeSet(doc, "//item")
df <- xmlToDataFrame(getNodeSet(doc, "//item")) # <item></item>
View(df)

# names(df) 실행시 한글이 깨지는 경우 
names(df) <- iconv(names(df), from="UTF-8", to="cp949")

# 데이터 프레임 조작 패키지
install.packages("dplyr")
library(dplyr)
# c + shift + m 
apt<-df %>% select(거래금액, 건축년도,법정동,아파트, 전용면적, 층,지역코드)
apt

apt$거래금액 <- as.numeric(sub(",", "",apt$거래금액))
apt$전용면적 <- as.numeric(as.character(apt$전용면적))
apt$`전용면적(평)` <- apt$전용면적 / 3.306
apt$지역코드 <- as.numeric(as.character(apt$지역코드))

View(apt)
