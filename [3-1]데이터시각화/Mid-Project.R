# 디렉토리 설정
setwd("/home/barkle/workspace/KNOU/Visualization")

library(sp)

# 그래프를 그릴 새 창을 만든다.
graphics.off()
X11(width=10, height=10, xpos=0, ypos=0)

# 시도별 지도 데이터를 불러온다
map_data <- readRDS("gadm36_KOR_1_sp.rds")
# 시도별 고연령자 비율 데이터를 불러온다
aging_data = read.csv("./data/pop_S2.csv", header = T)

# 시도 순서를 비교한다
map_data@data
aging_data

# 시도 순서를 일치시킨다
sido_order = c(2, 11, 12, 3, 6, 10, 5, 9, 15, 16, 4, 17, 13, 14, 8, 1, 7)
aging_data_sort <- aging_data[sido_order,]

# 연도별 고령자 비율 데이터를 map_data에 추가한다
map_data$aging1980 <- as.factor(aging_data_sort$Y1980)
map_data$aging2000 <- as.factor(aging_data_sort$Y2000)
map_data$aging2020 <- as.factor(aging_data_sort$Y2020)
map_data$aging2040 <- as.factor(aging_data_sort$Y2040)

aging_data_sort$Y1980
# 히트맵 구간을 정한다
interval = c(0, 5, 10, 15, 20, 25, 30, 35, 40, 45)
aging_cut_1980 <- cut(aging_data_sort$Y1980, breaks=interval)
aging_cut_2000 <- cut(aging_data_sort$Y2000, breaks=interval)
aging_cut_2020 <- cut(aging_data_sort$Y2020, breaks=interval)
aging_cut_2040 <- cut(aging_data_sort$Y2040, breaks=interval)

# 연도별 고령자 비율 데이터를 map_data에 추가한다
map_data$agingcut1980 <- as.factor(aging_cut_1980)
map_data$agingcut2000 <- as.factor(aging_cut_2000)
map_data$agingcut2020 <- as.factor(aging_cut_2020)
map_data$agingcut2040 <- as.factor(aging_cut_2040)

# 히트맵 색상을 정한다
library(RColorBrewer)
col = brewer.pal(9, "Reds")

# 연도별 그래프를 그리고 각각 변수에 저장한다
p1980 <- spplot(map_data, "agingcut1980", col.regions=col, main = "1980년 고령자 비율")
p2000 <- spplot(map_data, "agingcut2000", col.regions=col, main = "2000년 고령자 비율")
p2020 <- spplot(map_data, "agingcut2020", col.regions=col, main = "2020년 고령자 비율")
p2040 <- spplot(map_data, "agingcut2040", col.regions=col, main = "2040년 고령자 비율")

# 연도별 그래프를 4개 분면에 각각 출력한다
print(p1980, pos=c(0, 0.5, 0.5, 1), more=TRUE)
print(p2000, pos=c(0.5, 0.5, 1, 1), more=TRUE)
print(p2020, pos=c(0, 0, 0.5, 0.5), more=TRUE)
print(p2040, pos=c(0.5, 0, 1, 0.5), more=TRUE)
