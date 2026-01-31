library(MASS)

# Boston Housing 데이터에 y 컬럼 추가
Boston$y = ifelse(Boston$medv>21,"H","L")
# Boston Housing 데이터에서 14번째 컬럼(medv)을 삭제하여 Input_data 생성
Input_data = Boston[,c(-14)]
# Input_data의 y 컬럼을 1, 0 으로 변환
Input_data$y = ifelse(Input_data$y=="H",1,0)
# Input_data의 chas, rad 컬럼을 범주형 변수로 변환
Input_data$chas = factor(Input_data$chas)
Input_data$rad = factor(Input_data$rad)

# y를 목표변수로 하고, 나머지를 입력변수로 하는 로지스틱 회귀모형
fit.all = glm(formula = y ~ ., family=binomial, data=Input_data)
# 단계적 선택법
fit.step = step(fit.all, direction="both")
# 단계 2와 3에서 indus, zn 변수 삭제되었음
fit.step$anova
# 최종 모형
summary(fit.step)

p = predict(fit.step, newdata=Input_data, type="response")
threshold = 0.5
yhat = ifelse(p > threshold, 1, 0)
class.tab = table(Input_data$y, yhat, dnn=c("Actual", "Predicted"))
class.tab

# Prediction Accuracy
sum(Input_data$y==yhat)/length(Input_data$y)
# Misclassification Rate
sum(Input_data$y!=yhat)/length(Input_data$y)
# Specificity
class.tab[1,1]/apply(class.tab, 1, sum)[1]
# Sensitivity
class.tab[2,2]/apply(class.tab, 1, sum)[2]

library(ROCR)

# ROC Curve
pred = prediction(p, Input_data$y)
perf = performance(pred, "tpr", "fpr")
plot(perf, lty=1, col=2, xlim=c(0,1), ylim=c(0,1),
     xlab="1-Specificity", ylab="Sensitivity", main="ROC Curve")
lines(x=c(0,1), y=c(0,1), col="grey")

# AUC
performance(pred, "auc")@y.values

# 
X1 = rep(c("1","2","3","1","2","3","1","2","3"), c(2,0,0,3,6,0,4,1,2))
X2 = rep(c("1","1","1","2","2","2","3","3","3"), c(2,0,0,3,6,0,4,1,2))
data_1 = data.frame(X1 = X1, X2 = X2)

.Table = xtabs(~X2+X1, data=data_1)
.Table

.Test = chisq.test(.Table, correct=FALSE)
.Test

X1 = rep(c("1","2","3","1","2","3","1","2","3"), c(2,0,0,3,6,0,4,1,2))
X2 = rep(c("1","1","1","2","2","2","3","3","3"), c(2,0,0,3,6,0,4,1,2))
Y = rep(c("1"),c(18))
data_1 = data.frame(X1=X1, X2=X2, Y=Y)

X1 = rep(c("1","2","3","1","2","3","1","2","3"), c(0,2,5,0,4,7,2,0,1))
X2 = rep(c("1","1","1","2","2","2","3","3","3"), c(0,2,5,0,4,7,2,0,1))
Y = rep(c("0"),c(21))
data_2 = data.frame(X1=X1, X2=X2, Y=Y)

data = rbind(data_1, data_2)

library(rpart)

my.control = rpart.control(xval=10, cp=0, minsplit=1)
fit.data = rpart(Y ~ ., data=data, method="class", control=my.control)
print(fit.data)

plot(fit.data, uniform=T, compress=T, margin=0.1)
text(fit.data, use.n=T, col="blue")



printcp(fit.data)

my.control = rpart.control(xval=10, cp=0.1, minsplit=1)
fit.data = rpart(Y ~ ., data=data, method="class", control=my.control)
print(fit.data)

plot(fit.data, uniform=T, compress=T, margin=0.1)
text(fit.data, use.n=T, col="blue")

pred.data = predict(fit.data, newdata=data, type="class")
tab = table(data$Y, pred.data, dnn=c("Actual", "Predicted"))
print(tab)

1-sum(diag(tab))/sum(tab)
