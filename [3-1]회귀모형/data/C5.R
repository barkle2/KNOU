# 디렉토리 설정
setwd("D:/학습/3학년 1학기/5.회귀모형")
options(scipen = 0)

# 5.3 특이점

## Forbes 자료: 번호, 물끓는 온도(화씨), 대기압력
forbes = read.table("forbes.txt", header=T)
## 대기압력에 상용로그를 취한 값이 100을 곱한 값을 반응변수로 한다
forbes$Lpress = 100 * log10(forbes$press)
head(forbes)

## (Lpress, temp) 산점도
plot(forbes$temp, forbes$Lpress, pch=19)
## 원하는 점을 클릭해서 알아낸다(그래프 클릭 후 ESC)
identify(forbes$temp, forbes$Lpress)

## 회귀선 적합
forbes.lm = lm(forbes$Lpress~forbes$temp, data=forbes)
summary(forbes.lm)

## 분산분석
anova(forbes.lm)

## 잔차분석
forbes.res = ls.diag(forbes.lm)
names(forbes.res)
resid.result = cbind(forbes.res$std.res, forbes.res$stud.res, forbes.res$hat)
colnames(resid.result) = c("standardized resid", "studentized resid", "Hat")
resid.result = round(resid.result, 3)
print(resid.result)
## 스튜던트화 잔차 (ls.diag에 있다)
rstudent(forbes.lm)
## 특이점을 찾는다
library(car)
outlierTest(forbes.lm)
## 쿡의 거리를 계산한다 (ls.diag에 있다)
Di = cooks.distance(forbes.lm)
round(Di, 3)
## rstudent 함수와 cooks.distance 함수는 ls.diag로 대체된다
ls.diag(forbes.lm)
