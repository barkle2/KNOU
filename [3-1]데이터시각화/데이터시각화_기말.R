setwd("D:/학습/3학년 1학기/2.데이터시각화")

data(Titanic)
Titanic
head(Titanic)
str(Titanic)

addmargins(apply(Titanic, c(1,4), sum))
addmargins(apply(Titanic, c(2,4), sum))
addmargins(apply(Titanic, c(3,4), sum))

# 전체 생존율
mosaicplot(~ Survived, data=Titanic, col=c("Grey", "White"))

# 클래스별 생존율
mosaicplot(~ Class+Survived, data=Titanic, col=c("Grey", "White"))

# 성별 생존율
mosaicplot(~ Sex+Survived, data=Titanic, col=c("Grey", "White"))

# 연령별 생존율
mosaicplot(~ Age+Survived, data=Titanic, col=c("Grey", "White"))

summary(Titanic)


# 시도 지도를 읽는다.
map_data <- readRDS("gadm36_KOR_1_sp.rds")
# 실업률 자료를 읽는다.
UL <- read.csv("Unemployment.csv", header=T)

# 2010년 자료를 Factor->Character로 변환
UL$X2010 <- as.character(UL$X2010)
str(UL)
# 2010년 세종시 자료를 -1로 대체
UL$X2010 <- ifelse(UL$X2010=="-", "-1", UL$X2010)
# Character->Numeric으로 변환
UL$X2010 <- as.numeric(UL$X2010)

# 히트맵 구간을 정한다
interval = c(0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5)
UL$L2010 <- cut(UL$X2010, breaks=interval)
UL$L2019 <- cut(UL$X2019, breaks=interval)

# 지역별 실업률 데이터를map_data에 추가한다
map_data$UL2010 <- as.factor(UL$L2010)
map_data$UL2019 <- as.factor(UL$L2019)
map_data$UL2010

# 히트맵 색상을 정한다
library(RColorBrewer)
col = brewer.pal(9, "Reds")

# 출력한다.
spplot(map_data, "UL2010", col.regions=col, main = "2010년 지역별 실업률")
spplot(map_data, "UL2019", col.regions=col, main = "2019년 지역별 실업률")
