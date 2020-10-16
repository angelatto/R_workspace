install.packages("leaflet")
library(leaflet)   # R과 Javascript에서 사용하는 지도 라이브러리

install.packages("readxl")
library(readxl)  # excel 파일을 읽기 위한 패키지

install.packages("dplyr")
library(dplyr)   # 데이터 프레임 전처리, 가공# data manipulation and pipe operator (%>%)

library(stringr)

# 서울특별시 공공자전거 대여소 정보 > 가장 최근 파일 다운로드
# https://data.seoul.go.kr/dataList/datasetView.do?infId=OA-13252&srvType=F&serviceKind=1&currentPageNo=1
station <- read_excel('./서울시 공공자전거 대여소 설치 일시 정보(20190517).xlsx')

# 서울특별시 공공자전거 이용정보(월별)  > 가장 최근 파일 다운로드
# https://data.seoul.go.kr/dataList/datasetView.do?infId=OA-15245&srvType=F&serviceKind=1&currentPageNo=1
bike <- read_excel('./공공자전거 대여소별 이용정보_201812_201905.xlsx')

View(station)
View(bike)
# 2018년 12월 한달치 이용정보만 이용
bike_201812 <- bike %>%
  filter(대여일자 == 201812)

# station 데이터 프레임에서 필요한 열만 추출
sub_station <- station %>%
  select(대여소ID, 위도, 경도, 거치대수)

# 이용정보 데이터와 합치기 위해 열 이름 변경
names(bike_201812)[2] <- "대여소ID"

# 이용 정보 데이터 프레임에서 대여소 ID 전처리 (rbind- 행결합, cbind-열결함, merge-by='key'의한 결합)
sid_df <- data.frame(do.call(rbind, str_split(bike_201812$대여소ID, ". ", n=2)))
View(sid_df)
# 분리된 대여소 ID(X1)와 대여소 명을(X2) 원본에 대입
bike_201812$대여소ID <- sid_df$X1
bike_201812$대여소명 <- sid_df$X2

# 대여소 정보와 병합
bike_201812_merge <- merge(bike_201812, sub_station, by='대여소ID')

# 지도 시각화 진행 (마커 클릭시 거치대수 출력, 마커 마우스 오버시 대여소명 출력)
leaflet(data = bike_201812_merge) %>%
  addTiles() %>%
  addMarkers(bike_201812_merge$경도, bike_201812_merge$위도, popup = as.character(bike_201812_merge$거치대수), label = as.character(bike_201812_merge$대여소명))

# 지도 시각화 진행 (마커를 원으로 변경, 클릭시 거치대수 출력, 마커 마우스 오버시 대여소명 출력, 대여건수를 마커의 원의 크기로 설정)
#bike_201812_merge$  대신 ~
leaflet(data = bike_201812_merge) %>%
  addTiles() %>%
  addCircleMarkers(~경도, ~위도, radius = ~대여건수/100,
                   popup = ~as.character(거치대수), label = ~as.character(대여소명))

