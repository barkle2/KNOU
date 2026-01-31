# F분포를 사용하여 분산을 비교할 경우 분산이 더 큰 값을 V1으로 한다.
var1 = 4.8
df1 = 5
var2 = 1.2
df2 = 14

# 표본분산비 F = 4
F = var1/var2

# 자유도가 5, 14일 때 유의수준 0.025인 F값은 3.663이다.
F_value = qf(p=0.025, df1, df2, lower.tail=FALSE)

# 검정통계량의 값 4는 임계값 3.663보다 크므로 귀무가설을 기각할 수 있다.
sprintf("F:%.3f > F_value:%.3f",F, F_value)

a1 = c(15.4, 14.4, 15.0)
a2 = c(15.9, 14.8, 14.1)
a3 = c(15.5, 15.4, 15.0)
lot = c(a1, a2, a3)
group = c("a1", "a2", "a3")
group <- rep(group, c(3,3,3))
df <- data.frame(group, lot)

tapply(df$lot, df$group, sum)
tapply(df$lot, df$group, mean)

sum(df$lot)
mean(df$lot)

boxplot(df$lot ~ df$group)

bartlett.test(df$lot ~ df$group, data=df)
anova = aov(df$lot ~ df$group, data=df)
summary(anova)

# 문제에서 주어진 데이터 입력한다.
a1 = c(15.4, 14.4, 15.0)
a2 = c(15.9, 14.8, 14.1)
a3 = c(15.5, 15.4, 15.0)

# 분석을 위해 data.frame을 설정한다.
lot = c(a1, a2, a3)
group = c("a1", "a2", "a3")
group <- rep(group, c(3,3,3))
df <- data.frame(group, lot)

# 분산분석을 실시한다.
anova = aov(df$lot ~ df$group, data=df)
summary(anova)

# 박스플롯을 통해 결과를 확인한다.
boxplot(df$lot ~ df$group)

A = matrix(c(1,3,2,-1,1,1,-3,-1,2,1,2,1,1,1,1,1), ncol=4); A
A_inv = solve(A); A_inv

Plain = matrix(c(10,8,12,36,34,32,37,37), ncol=2); P

Password = A%*%Plain; Password

A_inv%*%Password

A = matrix(c(1,-2,2,3,2,0,-2,2,0,0,-2,1,1,3,0,2), ncol=4); A
B = solve(A); B
