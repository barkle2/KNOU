# 디렉토리 설정
setwd("D:/학습/3학년 1학기/5.회귀모형")
options(scipen = 0)

# 1번 문제

# animal.csv 파일 읽기
animal = read.csv("animal.csv", header=FALSE)
# animal.csv가 제대로 읽혔나 확인한다
head(animal)
tail(animal)
# 컬럼명을 정해준다
names(animal) <- c("Number", "Animal_Name", "Weight", "Brain_Weight")

# 두뇌무게:Y, 몸무게:X 로 산점도 및 잔차산점도 그리기
## 산점도 그리기
plot(animal$Brain_Weight~animal$Weight, pch=19, xlab="몸무게", ylab="두뇌무게")
### 회귀모형 적합하기
animal.lm = lm(animal$Brain_Weight~animal$Weight, data=animal)
### 회귀모형 확인
summary(animal.lm)
### 산점도에 회귀선을 그린다
abline(animal.lm)

## 잔차산점도 그리기
names(animal.lm)
plot(animal$Brain_Weight, animal.lm$residuals, pch=19, xlab="두뇌무게", ylab="잔차")
abline(h=0, lty=2)

out = animal[identify(animal$Brain_Weight, animal.lm$residuals), ]


## 잔차의 제곱합 내림차순으로 정렬시켜서 영향이 큰 데이터를 확인한다
animal_total <- cbind(animal, animal.lm$residuals^2, animal.lm$fitted.values)
animal_total
head(animal_total)
order(animal_total$`animal.lm$residuals^2`)
animal_total[c(order(-animal_total$'animal.lm$residuals^2')),]

## 변수의 변환이 필요하다.
## 전체 데이터 중에서 African elephant, Asian elephant, Human의 잔차가 다른 데이터보다 매우 크기 때문에
##잔차의 제곱합을 최소화할 때 다른 변수들이 제대로 반영되기 어렵다.
## 잔차산점도를 보아도 잔차가 0을 중심으로 일정한 범위 내에 있다고 볼 수 없다.

animal_diag = ls.diag(animal.lm)
animal_diag
rstudent_2 = -rstudent(animal.lm)^2  
rstudent_2[order(-rstudent(animal.lm)^2)]
rstudent_2 = round(rstudent_2, 3)
rstudent_2
# 특이점 검정
outlierTest(animal.lm)
# 쿡의 거리로 관측값 영향력 계산
Di = cooks.distance(animal.lm)
Di = round(Di, 3)
Di[order(-Di)]

rbind(animal[19,], animal[32,], animal[33, ])
# 등분산 가정의 성립 여부 확인
ncvTest(animal.lm)
# 회귀모형의 선형성 확인
plot(animal$Weight, animal.lm$residuals, pch=19, xlab="두뇌무게", ylab="잔차")

library(mvnormtest)
# 오차의 정규성 확인
animal.rstudent = rstudent(animal.lm)
shapiro.test(animal.rstudent)

head(animal)

# animal에 로그 변환한 값을 추가한다
animal$LWeight = log(animal$Weight)
animal$LBrain_Weight = log(animal$Brain_Weight)
head(animal)

### 회귀모형 적합하기
animal.Llm = lm(animal$LBrain_Weight~animal$LWeight, data=animal)
### 회귀모형 확인
summary(animal.Llm)
### 산점도 및 회귀직선 그리기
plot(animal$LBrain_Weight~animal$LWeight, pch=19, xlab="몸무게(로그)", ylab="두뇌무게(로그)")
abline(animal.Llm)
animal[identify(animal$LBrain_Weight~animal$LWeight), ]

library(car)
# 특이점 검정
outlierTest(animal.Llm)
# 쿡의 거리로 관측값 영향력 계산
Di = cooks.distance(animal.Llm)
Di = round(Di, 3)
Di[order(-Di)]

# 등분산 가정의 성립 여부 확인
ncvTest(animal.Llm)
# 회귀모형의 선형성 확인
plot(animal$LWeight, animal.Llm$residuals, pch=19, xlab="두뇌무게(로그)", ylab="잔차")

library(mvnormtest)
# 오차의 정규성 확인
animal.rstudent = rstudent(animal.Llm)
shapiro.test(animal.rstudent)

# 2번 문제
library(leaps)
auto = read.csv("autodata.csv", header=T)
# 앞으로부터 선택법
start.lm = lm(Y ~ 1, data=auto)
full.lm = lm(Y ~ . , data=auto)
step(start.lm, scope=list(lower=start.lm, upper=full.lm), direction="forward")

# 뒤로부터 제거법
step(full.lm, data=auto, direction="backward")

# 단계별 회귀방법
step(start.lm, scope=list(upper=full.lm), data=auto, direction="both")

# 3번 문제
school = read.csv("pfsalary.csv", header=T)
head(school)
# 성별을 표시하는 기호를 이용한 (월급액, 근속연수) 산점도
plot(school$YR, school$SL, xlab="근속연수", ylab="월급액", type="n")
points(school$YR[school$SEX==0], school$SL[school$SEX==0], pch=17, col="BLUE")
points(school$YR[school$SEX==1], school$SL[school$SEX==1], pch=19, col="RED")
legend("bottomright", legend=c("남성", "여성"), pch=c(17, 19), col=c("BLUE", "RED"))

# (월급액~ 근속연수, 성별) 회귀모형을 구한다
school.lm = lm(school$SL ~ school$YR, data=school)
summary(school.lm)
# (월급액~ 근속연수, 성별) 회귀모형(교호작용X)을 구한다
school.lm1 = lm(school$SL ~ school$YR + school$SEX, data=school)
summary(school.lm1)
# (월급액~ 근속연수, 성별) 회귀모형(교호작용O)을 구한다
school.lm2 = lm(school$SL ~ school$YR + school$SEX + school$YR:school$SEX, data=school)
summary(school.lm2)

head(school)

# 직위(RK)를 반영하기 위한 가변수 정의
school$D1 = factor(school$RK, labels=c(1, 0, 0))
school$D2 = factor(school$RK, labels=c(0, 1, 0))
school[c(1, 14, 21),]

# 근속년수의 회귀모형에 성별, 직위, 최종학력을 포함하여 분석한다.
attach(school)
# 근속년수의 회귀모형에 성별, 직위, 최종학력을 포함하여 분석한다.
school.lm3 = lm(SL ~ YR + SEX + DG + D1 + D2 + 
                  YR:SEX + YR:DG + YR:D1 + YR:D2 + SEX:DG + SEX:D1 + SEX:D2 + DG:D1 + DG+D2, data=school)

summary(school.lm3)

school.lm4 = lm(SL ~ YR + SEX + DG + D1 + D2, data=school)
summary(school.lm4)

plot(school$YR, school$SL, xlab="근속연수", ylab="월급액",
     pch=c("M","F")[school$SEX+1], col=c("BLUE", "RED")[school$SEX+1])

school.lm4 = lm(SL ~ YR + D1 + D2, data=school)
summary(school.lm4)

library(leaps)
all.lm = regsubsets(SL ~ SEQ + SEX + YR + DG + D1 + D2, data=school)
rs= summary(all.lm)
rs
rs$rsq
rs$adjr2
rs$cp

# 월급액에 대하여 근속연수와 성별을 설명변수로 하는 회귀모형 구하기
school.lm = lm(school$SL ~ school$YR + school$SEX, data=school)
summary(school.lm)

# 문제5

glider = read.csv("sugar_glider_binomial.csv")
head(glider)
attach(glider)
logit_m1 <- glm(occurr~p_size_km+con_metric, family=binomial(link=logit), data=glider)
summary(logit_m1)

logit_m0 <- glm(occurr~1, family=binomial(link=logit), data=glider)
anova(logit_m0, logit_m1, test="Chisq")

logit_m2 = glm(occurr~p_size_km, family=binomial(link=logit), data=glider)
summary(logit_m2)

anova(logit_m2, logit_m1, test="Chisq")

AIC(logit_m2, logit_m1)

library(MASS)
stepAIC(logit_m1, direction="both")

exp(coef(logit_m2))

exp(confint(logit_m2, parm="p_size_km", level=0.95))

x=120
predict(logit_m2, list(p_size_km=x), type="link")
vcov(logit_m2)
coef(logit_m2)
sqrt(vcov(logit_m)[1,1]+x^2*vcov(logit_m)[2,2]+2*x*vcov(logit_m)[2,1])

0.0789 - 1.96*0.335
0.0789 + 1.96*0.335

exp(-0.5777) / (1+exp(-0.5777))
exp(0.7355) / (1+exp(0.7355))

x= 120
exp(-2.528+0.0217*x) / ( 1+ exp(-2.528+0.0217*x))

vcov(logit_m)
coef(logit_m)
sqrt(vcov(logit_m)[1,1]+x^2*vcov(logit_m)[2,2]+2*x*vcov(logit_m)[2,1])



probit_m <- glm(occurr~p_size_km, family=binomial(link=probit))
summary(probit_m)

predict(probit_m, list(p_size_km=150), type="response")

