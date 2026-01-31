library(MASS)

german = read.table('C:/germandata.txt', header=T)
summary(german)

german$numcredits = factor(german$numcredits)
table(german$numcredits)

install.packages('dummy')
library(dummy)

german = read.table('C:/germandata.txt', header=T)

german2 = dummy(german$numcredits)
head(german2, 20)
summary(german2)

german$numcredits = factor(german$numcredits)
summary(german$numcredits)


german[,dvar]
german2 = german2[,-c(10,14,17,20,24)]
german2 = cbind(german[,-dvar], german2)
for(i in 1:ncol(german2))
  if(!is.numeric(german2[,i]))
    german2[,i] = as.numeric(german2[,i])

german2$y = ifelse(german$y=="good",1,0)

head(german2)

german3 = german[,c(15,16)]
german3 = dummy(german3$numcredits)
german3

german2

1-(10/18)^2-(8/18)^2

1-(4/6)^2-(2/6)^2

1-(6/12)^2-(6/12)^2

6/18 * 0.444 + 12/18 * 0.5

1-(4/5)^2-(1/5)^2

1-(6/13)^2-(7/13)^2

5/18 * 0.32 + 13/18 * 0.497

1-(2/7)^2-(5/7)^2

1-(8/11)^2-(3/11)^2

7/18 * 0.408 + 11/18 * 0.397

# library 설치 및 호출
install.packages("neuralnet")
library(neuralnet)

# 학번: 202035-368086 / 이름: 김동현
set.seed(368086)

# 데이터 확인
head(iris)

# 데이터의 50%를 임의로 선정하여 학습데이터로 지정
i1 = sample(1:50, 25)
i2 = sample(51:100, 25)
i3 = sample(101:150, 25)
i = append(i1, i2)
i = append(i, i3)

train = iris[i,]
summary(train)

# 나머지 데이터는 테스트데이터로 지정
test = iris[-i,]
summary(test)

# 학습 데이터로 신경망 작성
NN = neuralnet(Species ~ ., train, hidden=c(5,3))

summary(NN)

# 신경망 구조도 확인
plot(NN)

# test 데이터로 예측하기
pred = neuralnet::compute(NN, test[,c(1,2,3,4)])

# 가장 큰 result 값이 몇 번째 열에 있는지 기록
pred.2 <- data.frame()
for(i in 1:75) {
  pred.2 <- rbind(pred.2, which.max(pred$net.result[i,]))
}

# 첫번째 열이 가장 크면 setosa
pred.2$X1L <- gsub(1, "setosa" , pred.2$X1L)
# 두번째 열이 가장 크면 versicolor
pred.2$X1L <- gsub(2, "versicolor" , pred.2$X1L)
# 세번째 열이 가장 크면 virginica
pred.2$X1L <- gsub(3, "virginica" , pred.2$X1L)

# 예측 값을 prediction에 저장
prediction <- as.factor(pred.2$X1L)

# 정답 값을 reference에 저장
reference <- test[,5]

# 결과를 표로 정리
library(caret)
confusionMatrix(prediction, reference)

# USArrests 데이터를 불러온다.
data(USArrests)
# USArrests 데이터를 표준화하여 저장
data = data.frame(scale(USArrests))

# 단일연결법
single = hclust(dist(data, method="manhattan"), method="single")
plot(single)

# 완전연결법
complete = hclust(dist(data, method="manhattan"), method="complete")
plot(complete)

# 평균연결법
average = hclust(dist(data, method="manhattan"), method="average")
plot(average)

install.packages("cluster")

library(cluster)
# DIANA 군집화
diana_cluster = diana(data, metric="manhattan")
plot(diana_cluster)


# K-means 군집화
data_mat = as.matrix(data)
ikmeans = kmeans(data_mat, 4, algorithm = "MacQueen")
ikmeans

5/6
