setwd("D:/공부/방송통신대/3학년 2학기/실험계획과응용")

y = c(4,5,8,5,7,8)
A = c(1,2,3,1,2,3)
B = c(1,1,1,2,2,2)
c = data.frame(y, A, B)

c$A = factor(c$A, levels=c(1,2,3), labels=c("A1", "A2", "A3"))
c$B = factor(c$B, levels=c(1,2), labels=c("B1", "B2"))

anova <- aov(y ~ A*B+Error(A/B), data=c)
summary(anova)

y = c(1.0,4.2,5.3,0.3,3.3,6.2,3.2,6.1,6.6,2.6,5.3,7.1,1.3,3.1,6.0,1.9,4.1,6.4)
A = rep(c(1,2,3),6)
B = c(rep(1,6), rep(2,6), rep(3,6))
c = data.frame(y, A, B)

c$A = factor(c$A, levels=c(1,2,3), labels=c("A1", "A2", "A3"))
c$B = factor(c$B, levels=c(1,2,3), labels=c("B1", "B2", "B3"))
c

with(c, interaction.plot(x.factor=A, trace.factor=B, response=y, fun=mean, type='b', legend=T))

anova <- aov(y ~ A*B+Error(A/B), data=c)
summary(anova)

y = c(3,2,4,2,3,5,3,1,6)
A = factor(c(1,2,3,1,2,3,1,2,3))
B = factor(c(1,1,1,2,2,2,3,3,3))
C = factor(c(1,3,2,2,1,3,3,2,1))

df = data.frame(y, A, B, C)
df
anova = aov(y ~ A+B+C, data=df)
summary(anova)

y = c(10,15,18,23,18,18,24,26)
A = factor(c(0,1,0,1,0,1,0,1))
B = factor(c(0,0,1,1,0,0,1,1))
C = factor(c(0,0,0,0,1,1,1,1))
df = data.frame(y, A, B, C)
anova = aov(y ~ A*B*C, data=df)
summary(anova)

y = c(3.1,3.3,6.3,6.7,4.1,4.0,6.5,6.3)
A = c(0,1,0,1,0,1,0,1)
B = c(0,0,1,1,0,0,1,1)
C = c(0,0,0,0,1,1,1,1)
block = c(1,2,2,2,1,1,1,2)
df = data.frame(y, A, B, C, block)
df$A = factor(df$A, levels=c(0,1))
df$B = factor(df$B, levels=c(0,1))
df$C = factor(df$C, levels=c(0,1))
df$block = factor(df$block, levels=c(1,2))
upto4 = aov(y~(A+B+C)^3, data=df)
summary(upto4)
df
anova = aov(y~A+B+C, data=df)
summary(anova)
df$
  