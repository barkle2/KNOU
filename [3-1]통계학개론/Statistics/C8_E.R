# example 8-1
C8_E1 <- read.table("/home/barkle/workspace/KNOU/Statistics/C8_E1.csv", 
                     header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)

# drawing sactter-plot graph
scatterplot(Sell~Ad, regLine=FALSE, smooth=FALSE, boxplots=FALSE, data=C8_E1)

# example 8-2
# calculate covariance
cov(C8_E1$Ad, C8_E1$Sell)

# calculate correlation coefficient
cor(C8_E1$Ad, C8_E1$Sell)

# example 8-3
# calculate least squares estimator : a=28.672, b=2.503
lm(C8_E1$Sell~C8_E1$Ad)

# example 8-4
# calculate SST, SSR, SSE and R^2
yhat = 28.672 + 2.503 * C8_E1$Ad
ymean = mean(C8_E1$Sell)

SST = sum((C8_E1$Sell-ymean)^2)
SSR = sum((yhat-ymean)^2)
SSE = SST-SSR
R2 = SSR/SST

s = sqrt(sum((C8_E1$Sell-yhat)^2)/8)

# example 8-5
# F-statistic = 172.1  F(1,8,0.95) = 5.317655
RegModel.1 <- lm(Sell~Ad, data=C8_E1)
summary(RegModel.1)
F = 172.1
f_alpha = qf(0.95, 1, 8)

if (F > f_alpha) {
  result = "H0: rejected"
} else {
  result = "H0: not rejected"
}

# example 8-6
# confidence band of beta 
b = 2.503
SE_b = s / sqrt(sum((C8_E1$Ad-mean(C8_E1$Ad))^2))
t_alpha_2 = qt(0.025, 8, lower.tail = FALSE)

# [2.063 ~ 2.943]
beta_low = b - SE_b * t_alpha_2
beta_high = b + SE_b * t_alpha_2

# H0 Hypothesis Test about beta
Tb_val = b / SE_b

if (abs(Tb_val) > t_alpha_2) {
  result_b = "H0: rejected"
} else {
  result_b = "H0: not rejected"
}

# confidence band of alpha
a = 28.672
SE_a = s * sqrt((1/10) + mean(C8_E1$Ad)^2/sum((C8_E1$Ad-mean(C8_E1$Ad))^2))

# [24.820 ~ 32.524]
alpha_low = a - SE_a * t_alpha_2
alpha_high = a + SE_a * t_alpha_2

Ta_val = a / SE_a
if (abs(Ta_val) > t_alpha_2) {
  result_a = "H0: rejected"
} else {
  result_a = "H0: not rejected"
}

# confidence band of Y: when x=8
yhat_8 = 28.672 + 2.503 * 8
xbar=mean(C8_E1$Ad)
SE_Y8 = s * sqrt((1/10) + (8-xbar)^2 / sum((C8_E1$Ad-xbar)^2))

# [47.600 ~ 49.792]
Y8_low = yhat_8 - t_alpha_2*SE_Y8
Y8_high = yhat_8 + t_alpha_2*SE_Y8

# example 8-7
Res_val = C8_E1$Sell - yhat

# Residual-yhat
scatterplot(yhat, Res_val, regLine=FALSE, smooth=FALSE, boxplots=FALSE)
# Residual-independent variable
scatterplot(C8_E1$Sell, Res_val, regLine=FALSE, smooth=FALSE, boxplots=FALSE)
# Residual-order
scatterplot(1:10, Res_val, regLine=FALSE, smooth=FALSE, boxplots=FALSE)
# normal probability plot
qqnorm(Res_val)

# example 8-8/8-9
C8_E8 <- read.table("/home/barkle/workspace/KNOU/Statistics/C8_E8.csv", 
                    header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)
RegModel.2 <- lm(Y~X1+X2, data=C8_E8)
summary(RegModel.2)

b0 = 28.3389; b1=1.0450; b2=2.0972;
p_value = 0.0000002786