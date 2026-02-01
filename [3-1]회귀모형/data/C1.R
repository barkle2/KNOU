# 디렉토리 설정
setwd("D:/학습/3학년 1학기/5.회귀모형")

# 그래프를 그릴 새 창을 만든다.
graphics.off()
X11(width=8, height=8, xpos=0, ypos=0)

# [그림 1.1] 광고료와 총판매액의 산점도
market = read.table("market-1.txt", header=T)
head(market)
plot(market$X, market$Y, xlab="광고료", ylab="총판매익", pch=19)
title("광고료와 판매액의 산점도")

market.lm = lm(Y ~ X, data=market)
summary(market.lm)

# [그림 1.2] 적합된 회귀직선
plot(market$X, market$Y, xlab="광고료", ylab="총판매익", pch=19)
title("광고료와 판매액의 산점도")
abline(market.lm)

names(market.lm)
market.lm$resid
sum(market.lm$resid)
sum(market$X*market.lm$resid)

anova(market.lm)
qf(0.95, 1, 13)
1-pf(192.9, 1, 13)

summary(market.lm)

pred.frame=data.frame(X=seq(3.5, 14.5, 0.2))
pc = predict(market.lm, int="c", newdata=pred.frame)
pp = predict(market.lm, int="p", newdata=pred.frame)
head(pc)
head(pp)

# [그림 1.4] 추정값의 신뢰구간
pred.X = pred.frame$X
pred.X
plot(market$X, market$Y, ylim=range(market$Y, pp))
matlines(pred.X, pc, lty=c(1,2,2), col="BLUE")
matlines(pred.X, pp, lty=c(1,3,3), col="RED")

summary(market.lm)

x = c(1,2,3,4,5)
y = c(2,3,5,8,7)
w = 1/x
w.lm = lm(y ~ x, weights=w)
summary(w.lm)
anova(w.lm)

# 1.7 분석사례
# (1) 자료파일 만들기
super = read.table("supermarket.txt", header=T)
head(super, 3)
# (2) 자료를 읽어 산점도 그리기
plot(super$price, super$time, pch=19)
# (3) 회귀모형 적합하기
super.lm = lm(time ~ price, data=super)
summary(super.lm)
# (4) 분산분석표 구하기
anova(super.lm)
# (5) 잔차 및 추정값 보기
names(super.lm)
cbind(super, super.lm$resid, super.lm$fitted)
# (6) 잔차그림 그리기
plot(super$price, super.lm$resid, pch=19)
abline(h=0, lty=2)
# (7) 추정값의 신뢰대 그리기
p.x = data.frame(price=c(1, 45))
pc = predict(super.lm, int="c", newdata=p.x)
pred.x = p.x$price
plot(super$price, super$time, ylim=range(super$time, pc))
matlines(pred.x, pc, lty=c(1,2,2), col="BLUE")

# 연습문제1
# (1) 이 데이터의 산점도를 그려라
machine = read.table("machine.txt", header=T)
plot(machine$age, machine$cost, pch=19)
# (2) 최소제곱법에 의한 회귀직선을 적합시켜라
machine.lm = lm(cost ~ age, data=machine)
# (3) 추정치의 표준오차 Sy-x를 구하라
# (4) 결정계수와 상관계수를 구하라
summary(machine.lm)
# (5) 분산분석표를 작성하고 회귀직선의 유의 여부를 검정하라(유의수준 a=0.05 사용)
anova(machine.lm)
# (6) 사용연도가 4년인 기계의 평균정비비용은 어느 정도인가를 추정하라.
29.107 + 13.637 * 4
# (7) 잔차 ei=yi-yihat를 구하여 잔차의 합이 0임을 확인하라
sum(machine.lm$resid)
# (8) 잔차들의 xi에 대한 가중합을 구하라
sum(machine$age * machine.lm$resid)
# (9) 잔차들의 yihat에 대한 가중합을 구하라
sum((29.107 + 13.637*machine$age) * machine.lm$resid)
# (10) 두 변수 x,y를 표준화된 변수로 고친 후 회귀직선을 적합시키고, 그 회귀계수가 두 변수 x,y 간의 상관계수와 같음을 밝혀라
age_std = (machine[1] - mean(unlist(machine[1]))) / sd(unlist(machine[1]))
cost_std = (machine[2] - mean(unlist(machine[2]))) / sd(unlist(machine[2]))
machine2 <- cbind( machine, age_std, cost_std )
names(machine2)[3] <- c("age_std")
names(machine2)[4] <- c("cost_std")
machine2.lm = lm(cost_std ~ age_std , data=machine2)
summary(machine2.lm)
sqrt(0.6098)

# 연습문제2
# (1) x에 대한 y의 회귀직선을 최소제곱법에 의하여 구하여라. 데이터의 산점도를 그리고, 구한 회귀직선을 산점도 위에 그려 넣어라
car = read.table("car.txt", header=T)
plot(car$weight, car$energy, pch=19)
car.lm = lm(energy ~ weight, data=car)
summary(car.lm)
abline(car.lm)

# (2) 분산분석표를 작성하고 회귀직선의 유의 여부를 검정하라(유의수준 a=0.05 사용)
anova(car.lm)
# (3) 무게가 3,000kg이 되는 차량의 에너지 소모량은 어느 정도일까를 예측하라.
-0.1157 + 2.1626 * 3000
# (4) 원점을 지나는 회귀직선을 구하라
car2.lm = lm(energy ~ weight + 0, data=car)
# (5) 원점을 지나는 회귀직선의 결정계수를 구하라
summary(car2.lm)
# (6) 오차항의 분산이 같지 않다는 것이 밝혀지고, Var(ei)=kx^2으로 x^2의 크기에 비례한다면 가중회귀를 사용하여야 한다.
#이 경우 회귀변동(SSR)을 구하라
w = car$weight * car$weight
car3.lm = lm(energy ~ weight, data=car, weights=w)
summary(car3.lm)
anova(car3.lm)

# 연습문제5
SXX = sum((machine$age - mean(machine$age))^2)
anova(machine.lm)
MSE = 847.2

b1_min = 13.637 + qt(0.05, 12, lower.tail = TRUE) * sqrt(MSE/SXX)
b1_max = 13.637 + qt(0.05, 12, lower.tail = FALSE) * sqrt(MSE/SXX)
b1_min; b1_max

X_bar_pow2 = mean(machine$age)^2

b0_min = 29.107 + qt(0.05, 12, lower.tail = TRUE) * sqrt(MSE * ((1/14) + (X_bar_pow2/SXX)))
b0_max = 29.107 + qt(0.05, 12, lower.tail = FALSE) * sqrt(MSE * ((1/14) + (X_bar_pow2/SXX)))
b0_min; b0_max

Y_hat = 29.107 + 13.637 * 8
(8-mean(machine$age))^2

Y_hat_min = Y_hat + qt(0.05, 12, lower.tail = TRUE) * sqrt(MSE * (1 + 1/14 + 12.755/85.429))
Y_hat_max = Y_hat + qt(0.05, 12, lower.tail = FALSE) * sqrt(MSE * (1 + 1/14 + 12.755/85.429))
Y_hat_min; Y_hat_max


