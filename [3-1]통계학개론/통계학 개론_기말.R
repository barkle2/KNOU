# 디렉토리 설정
setwd("D:/학습/3학년 1학기/3.통계학개론")

q1 = c(20, 18, 15, 17, 18, 21, 25, 28, 24, 25)

boxplot(q1, horizontal=TRUE)

summary(q1)

q4_city = c(22, 24, 24, 30, 21, 28, 33, 24, 28, 26)
q4_rural = c(20, 21, 24, 26, 28, 22, 20, 24, 25, 29)

summary(q4_city)
var(q4_city)
sd(q4_city)

summary(q4_rural)
var(q4_rural)
sd(q4_rural)

hist(q4_city, xlim=c(20,34), ylim=c(0,4))
hist(q4_rural, xlim=c(20,34), ylim=c(0,4))

boxplot(q4_city)
boxplot(q4_rural)

q4 <- data.frame(q4_city, q4_rural)
boxplot(q4)

t.test(q4_city, q4_rural)

mild = c(34, 45, 49, 55, 58, 59, 60, 62, 86)
serious = c(5, 8, 18, 24, 60, 84, 96)

X_m = mean(mild); X_m
X_s = mean(serious); X_s

n_m = length(mild); n_m
n_s = length(serious); n_s

S_m = sd(mild); S_m
S_s = sd(serious); S_s

T = (X_m - X_s) / sqrt(S_m^2/n_m + S_s^2/n_s); T

phi = (S_m^2/n_m + S_s^2/n_s)^2 / ( ( (S_m^2/n_m)^2 / (n_m - 1) ) + ( (S_s^2/n_s)^2 / (n_s - 1) ) ); phi

alpha = 0.05

qt(alpha/2, phi, lower.tail=FALSE)

mild = c(34, 45, 49, 55, 58, 59, 60, 62, 86)
serious = c(5, 8, 18, 24, 60, 84, 96)

t.test(mild, serious)

low = c(22.2, 97.8, 29.1, 97.0, 35.8, 44.2, 82.0, 56.0, 9.3, 19.9, 39.5, 12.8, 37.4)
mid = c(15.1, 23.2, 10.5, 13.9, 9.7, 19.0, 19.8, 9.1, 30.1, 15.5, 10.3, 11.0)
high = c(10.2, 11.3, 11.4, 5.3, 14.5, 11.0, 13.6, 33.4, 25.0, 27.0, 36.3, 17.7)

T = c(low, mid, high)
T_avg = mean(T); T_avg
L_avg = mean(low); L_avg
M_avg = mean(mid); M_avg
H_avg = mean(high); H_avg
CT = sum(T)^2 / 37;
ST = sum(T^2) - CT; ST
SA = (L_avg - T_avg)^2*length(low) + (M_avg - T_avg)^2*length(mid) + (H_avg - T_avg)^2*length(high); SA
SE = ST - SA; SE
phi_A = 2; phi_E = 35; 
VA = SA/phi_A; VA
VE = SE/phi_E; VE
F = VA/VE;F
qf(0.05, 2, 35, lower.tail=FALSE)


t_value = qt(0.025, 35, lower.tail=FALSE)

# CI: Confidence Interval
CI_L = t_value * sqrt(VE/13)
CI_M = t_value * sqrt(VE/12)
CI_H = t_value * sqrt(VE/12)

L_avg - CI_L; L_avg + CI_L;
M_avg - CI_M; M_avg + CI_M;
H_avg - CI_H; H_avg + CI_H;
  
group = c("1_LOW", "2_MID", "3_HIGH")  
Min = c(L_avg-CI_L, M_avg-CI_M, H_avg-CI_H)
Center = c(L_avg, M_avg, H_avg)  
Max = c(L_avg+CI_L, M_avg+CI_M, H_avg+CI_H)

df = data.frame(group, Min, Center, Max)
sapply(df, class)  
df$group = as.character(df$group)
sapply(df, class)

library(ggplot2)
ggplot(df, aes(x=df$group, y=df$Center)) +
  geom_point(size=4) +
  geom_errorbar(aes(ymax=df$Max, ymin=df$Min), width=0.3) +
  coord_cartesian(ylim=c(0:60))

LSD_12 = t_value * sqrt(2*VE/12)
LSD_125 = t_value * sqrt(2*VE/12.5)

L_avg - M_avg
L_avg - H_avg
M_avg - H_avg
