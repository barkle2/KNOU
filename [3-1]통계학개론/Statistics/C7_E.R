# example 7-1
n1=15; x_bar1=752000; S1=22000;
n2=14; x_bar2=695000; S2=31000;
alpha=0.01; 

Sp = sqrt(((n1-1)*(S1^2) + (n2-1)*(S2^2)) / (n1+n2-2));
T = (x_bar1-x_bar2) / (Sp*sqrt(1/n1 + 1/n2));

# explanation 1
t_alpha = qt(alpha/2, df=n1+n2-2, lower.tail = FALSE);
if (abs(T) > t_alpha) {
  result_1 = "H0: rejected"
} else {
  result_1 = "H0: not rejected"
}
# explanation 2
p_value = 2*pt(T, df=n1+n2-2, lower.tail = FALSE);
if (p_value < alpha) {
  result_2 = "H0: rejected"
} else {
  result_2 = "H0: not rejected"
}

# example 7-2
n1=15; x_bar1=752000; S1=22000;
n2=14; x_bar2=695000; S2=31000;
alpha=0.01; 

Sp = sqrt(((n1-1)*(S1^2) + (n2-1)*(S2^2)) / (n1+n2-2));
T = (x_bar1-x_bar2) / (Sp*sqrt(1/n1 + 1/n2));
phi = ( (S1^2/n1)+(S2^2/n2) )^2 / ( ((S1^2)/n1)^2/(n1-1) + ((S2^2)/n2)^2/(n2-1) );

# explanation 1
t_alpha = qt(alpha/2, df=phi, lower.tail = FALSE);
if (abs(T) > t_alpha) {
  result_1 = "H0: rejected"
} else {
  result_1 = "H0: not rejected"
}

# explanation 2
p_value = 2*pt(T, df=phi, lower.tail = FALSE);
if (p_value < alpha) {
  result_2 = "H0: rejected"
} else {
  result_2 = "H0: not rejected"
}

# example 7-3
before = c(52, 60, 63, 43, 46, 56, 62, 50);
after  = c(58, 62, 62, 48, 50, 55, 68, 57);
n=8;
alpha = 0.05;

D_bar = mean(before-after);
SD = sqrt( var(before-after) );
T = D_bar / (SD/sqrt(n));

# explanation 1
t_alpha = qt(alpha, df=n-1, lower.tail = TRUE);
if (T < t_alpha) {
  result_1 = "H0: rejected"
} else {
  result_1 = "H0: not rejected"
}

# explanation 2
p_value = pt(T, df=n-1, lower.tail = TRUE);
if (p_value < alpha) {
  result_2 = "H0: rejected"
} else {
  result_2 = "H0: not rejected"
}

# example 7-4
n1=15; x_bar1=752000; S1=22000;
n2=14; x_bar2=695000; S2=31000;
alpha=0.05; 

F = (S2^2) / (S1^2);

# explanation 1
f_alpha = qf(alpha, df1=n2, df2=n1, lower.tail = FALSE);
if (F > f_alpha) {
  result_1 = "H0: rejected"
} else {
  result_1 = "H0: not rejected"
}

# explanation 2
p_value = pf(F, df1=n2, df2=n1, lower.tail = FALSE);
if (p_value < alpha) {
  result_2 = "H0: rejected"
} else {
  result_2 = "H0: not rejected"
}

# example 7-5 (1)
A1 = c(8.44, 8.36, 8.28);
A2 = c(8.59, 8.91, 8.60);
A3 = c(9.34, 9.41, 9.69);
A4 = c(8.92, 8.92, 8.74);
l=4; m=3;
alpha = 0.05;

A <- c(A1, A2, A3, A4);
T1 = sum(A1); T2 = sum(A2); T3 = sum(A3); T4 = sum(A4);
T <- c(T1, T2, T3, T4)
CT = sum(T)^2 / 12;

ST = sum(A^2) - CT;
SA = sum(T^2)/3 - CT;
SE = ST - SA;
phi_A = l-1; phi_E = l*(m-1);
VA = SA/phi_A; VE = SE/phi_E;
F = VA/VE;

# explanation 1
f_alpha = qf(alpha, df1=phi_A, df2=phi_E, lower.tail = FALSE);
if (F > f_alpha) {
  result_1 = "H0: rejected"
} else {
  result_1 = "H0: not rejected"
}

# explanation 2
p_value = pf(F, df1=phi_A, df2=phi_E, lower.tail = FALSE);
if (p_value < alpha) {
  result_2 = "H0: rejected"
} else {
  result_2 = "H0: not rejected"
}

# example 7-5 (2)
# CI: Confidence Interval
CI = qt(0.05/2, phi_E, lower.tail=FALSE) * sqrt(VE/phi_A);

# make dataframe for graph
group = c("A1", "A2", "A3", "A4");
Low = c(mean(A1)-CI, mean(A2)-CI, mean(A3)-CI, mean(A4)-CI);
Center = c(mean(A1), mean(A2), mean(A3), mean(A4));
High = c(mean(A1)+CI, mean(A2)+CI, mean(A3)+CI, mean(A4)+CI);

data_df = data.frame(group, Low, Center, High);
sapply(data_df, class);

data_df$group = as.character(data_df$group);
sapply(data_df, class);

library(ggplot2);
ggplot(data_df, aes(x=data_df$group, y=data_df$Center)) +
  geom_point(size = 4) +
  geom_errorbar(aes(ymax = data_df$High, ymin = data_df$Low),width=0.3) +
  coord_cartesian(ylim = c(5:10))

# example 7-5 (3)
# 5% LSD
LSD = qt(0.025, 8, lower.tail=FALSE) * sqrt(2*VE/m)

x1_x2 = mean(A1)-mean(A2)
x1_x3 = mean(A1)-mean(A3)
x1_x4 = mean(A1)-mean(A4)
x2_x3 = mean(A2)-mean(A3)
x2_x4 = mean(A2)-mean(A4)
x3_x4 = mean(A3)-mean(A4)

library(Rcmdr)

C7_E6 <- read.table("/home/barkle/workspace/KNOU/Statistics/C7_E6.csv", 
                    header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)

C7_E6 <- within(C7_E6, {
  Material <- factor(Material, labels=c('America','Japan','Korea'))
  Temp <- factor(Temp, labels=c('180','190','200','210'))
})

summary(aov(Yield~Temp+Material, data=C7_E6))
