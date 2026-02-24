# 디렉토리 설정
setwd("D:/학습/3학년 1학기/5.회귀모형")

# 연습문제1
# (1) 이 데이터의 산점도를 그려라
machine = read.table("machine.txt", header=T)
plot(machine$age, machine$cost, pch=19)
# (2) 최소제곱법에 의한 회귀직선을 적합시켜라
machine.lm = lm(cost ~ age, data=machine)
machine.lm
# (3) 추정치의 표준오차 Sy-x를 구하라
# (4) 결정계수와 상관계수를 구하라
summary(machine.lm)
sqrt(0.6098)
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


temp_std = (factory[1] - mean(unlist(factory[1]))) / sd(unlist(factory[1]))
press_std = (factory[2] - mean(unlist(factory[2]))) / sd(unlist(factory[2]))
str_std = (factory[3] - mean(unlist(factory[3]))) / sd(unlist(factory[3]))
factory2 <- cbind(temp_std, press_std, str_std)
factory2.lm = lm(str ~ temp + press, data=factory2)
summary(factory2.lm)

# 연습문제2
n=14
qt(0.005, n-2)
MSE=847.2
S_XX= sum( (machine$age - mean(machine$age))^2)
bar_X = mean(machine$age)

beta1_min = 29.107 - 1.782 * sqrt(MSE/S_XX)
beta1_max = 29.107 + 1.782 * sqrt(MSE/S_XX)
beta1_min; beta1_max

beta0_min = 13.637 - 1.782 * sqrt(MSE*((1/n) + (bar_X^2)/S_XX))
beta0_max = 13.637 + 1.782 * sqrt(MSE*((1/n) + (bar_X^2)/S_XX))
beta0_min; beta0_max

hat_Y_min = 138.203 - 1.782 * sqrt(MSE * (1 + 1/n + (8-bar_X)^2 / S_XX))
hat_Y_max = 138.203 + 1.782 * sqrt(MSE * (1 + 1/n + (8-bar_X)^2 / S_XX))
hat_Y_min; hat_Y_max

t_0 = (13.637 - 10) / sqrt(MSE/S_XX)
t = qt(0.005, n-2, lower.tail=FALSE)
t_0; t
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

factory = read.table("factory.txt", header=T)
factory.lm = lm(str ~ temp + press, data=factory)
summary(factory.lm)

anova(factory.lm)
factory
X = factory[, c(1:2)]
X = cbind(1, X)
X = as.matrix(X)
XTX = t(X) %*% X
XTXI = solve(XTX)
469.4*XTXI[1,1];469.4*XTXI[2,2];469.4*XTXI[3,3];


water = read.table("water.txt", header=T)
water.lm = lm(water ~ temp+day+ton, data=water)
summary(water.lm)
anova(water.lm)

(2.00432+0.00227+0.03988)/3
0.6822/0.2959

library(leaps)
TA = read.csv("p116.csv", header=T)
# 앞으로부터 선택법
start.lm = lm(Y ~ 1, data=TA)
full.lm = lm(Y ~. , data=TA)
step(start.lm, scope=list(lower=start.lm, upper=full.lm), direction="forward")
# 뒤로부터 제거법
step(full.lm, data=TA, direction="backward")
# 단계별 회귀방법
step(start.lm, scope=list(upper=full.lm), data=TA, direction="both")
# 모든 가능한 회귀방법
TA.lm = regsubsets(Y ~. , data=TA)
rs = summary(TA.lm)
rs$adjr2


car = read.csv("p118.csv", header=T)
# 앞으로부터 선택법
start.lm = lm(Y ~ 1, data=car)
full.lm = lm(Y ~. , data=car)
step(start.lm, scope=list(lower=start.lm, upper=full.lm), direction="forward")
# 뒤로부터 제거법
step(full.lm, data=car, direction="backward")
# 단계별 회귀방법
step(start.lm, scope=list(upper=full.lm), data=car, direction="both")
# 모든 가능한 회귀방법
car.lm = regsubsets(Y ~. , data=car)
rs = summary(car.lm)
rs
rs$adjr2
