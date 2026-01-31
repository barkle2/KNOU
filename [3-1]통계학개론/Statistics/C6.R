# example 6-5
X_bar=1600; mu=1500; sd=200; n=30; alpha=0.05;

# explanation 1
T = (X_bar-mu)/(sd/sqrt(n));
t_alpha = qt(alpha, df=n-1, lower.tail = FALSE);
result_1 = T > t_alpha;
# explanation 2
p_value = pt(T, df=n-1, lower.tail = FALSE);
result_2 = p_value < alpha;

# example 6-6
X_bar=12.2; mu=12; sd=0.2; n=10; alpha=0.05;

# explanation 1
T = (X_bar-mu)/(sd/sqrt(n));
t_alpha = qt(alpha/2, df=n-1, lower.tail = FALSE);
result_1 = T > t_alpha;
# explanation 2
p_value = 2*pt(T, df=n-1, lower.tail = FALSE);
result_2 = p_value < alpha;

# example 6-7
X_bar=12.2; mu=12; sd=0.2; n=10; alpha=0.05;

# explanation 1
T = (X_bar-mu)/(sd/sqrt(n));
t_alpha = qt(alpha, df=n-1, lower.tail = FALSE);
result_1 = T > t_alpha;
# explanation 2
p_value = pt(T, df=n-1, lower.tail = FALSE);
result_2 = p_value < alpha;

# example 6-8
C6_E8 <- c(5, 23, 20, 1, 10, 15, 15, 10, 9, 13, 18, 11, 18, 20, 19, 19)
X_bar=mean(C6_E8); mu=11; sd=sqrt(var(C6_E8)); n<-length(C6_E8); alpha=0.05;

# explanation 1
T = (X_bar-mu)/(sd/sqrt(n));
t_alpha = qt(alpha, df=n-1, lower.tail = FALSE);
result_1 = T > t_alpha;
# explanation 2
p_value = pt(T, df=n-1, lower.tail = FALSE);
result_2 = p_value < alpha;

# example 6-9
C6_E8 <- read.table("/home/barkle/workspace/KNOU/Statistics/C5_E4.csv", 
                 header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)
X_bar=mean(C6_E8$WAGE); mu=160; sd=sqrt(var(C6_E8$WAGE)); n<-length(C6_E8$WAGE); alpha=0.05;

# explanation 1
T = (X_bar-mu)/(sd/sqrt(n));
t_alpha = qt(alpha, df=n-1, lower.tail = FALSE);
result_1 = T > t_alpha;
# explanation 2
p_value = pt(T, df=n-1, lower.tail = FALSE);
result_2 = p_value < alpha;

# example 6-10
phat=0.7; p=0.6; n=50; alpha=0.05;

# explanation 1
Z = (phat-p)/(sqrt(p*(1-p)/n));
z_alpha = qnorm(alpha, lower.tail=FALSE);
result_1 = Z > z_alpha;
# explanation 2
p_value = pnorm(Z, lower.tail=FALSE);
result_2 = p_value < alpha;

# example 6-11
n=10; S2=0.16; sigma2=1; alpha=0.05;

# explanation 1
CHI2 = (n-1)*S2/sigma2;
chi_alpha = qchisq(0.05, df=n-1, lower.tail=TRUE);
result_1 = CHI2 < chi_alpha;
# explanation 2
p_value = pchisq(CHI2, df=n-1, lower.tail=TRUE);
result2 = p_value < alpha;

# example 6-12
C6_E12 <- c(5, 23, 20, 1, 10, 15, 15, 10, 9, 13, 18, 11)
X_bar=mean(C6_E12); sigma2=16; S2=var(C6_E12); n<-length(C6_E12); alpha=0.05;

# explanation 1
CHI2 = (n-1)*S2/sigma2;
chi_alpha = qchisq(0.05, df=n-1, lower.tail=FALSE);
result_1 = CHI2 > chi_alpha;
# explanation 2
p_value = pchisq(CHI2, df=n-1, lower.tail=FALSE);
result2 = p_value < alpha;

# example 6-13
C6_E13 <- read.table("/home/barkle/workspace/KNOU/Statistics/C6_E13.csv", 
                    header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)
with(C6_E13, (t.test(WAGE, alternative='greater', mu=160, conf.level=.95)))

# Q11
C6_Q11 <- c(154, 154, 186, 243, 159, 174, 183, 163, 192, 181)
X_bar=mean(C6_Q11); mu=160; sd=sqrt(var(C6_Q11)); n<-length(C6_Q11); alpha=0.05;
# explanation 1
T = (X_bar-mu)/(sd/sqrt(n));
t_alpha = qt(alpha, df=n-1, lower.tail = FALSE);
result_1 = T > t_alpha;
# explanation 2
p_value = pt(T, df=n-1, lower.tail = FALSE);
result_2 = p_value < alpha;

# Q12
C6_Q12 <- c(3,3,1,1,0.5,2,2,4,5,4,5,3,1,3,1,4,1,1,4,2,5,3,1,1,1,0.75,1.5,3,3,2)
X_bar=mean(C6_Q12); mu=3; sd=sqrt(var(C6_Q12)); n<-length(C6_Q12); alpha=0.05;
# explanation 1
T = (X_bar-mu)/(sd/sqrt(n));
t_alpha = qt(alpha, df=n-1, lower.tail = TRUE);
result_1 = T < t_alpha;
# explanation 2
p_value = pt(T, df=n-1, lower.tail = TRUE);
result_2 = p_value < alpha;

# Q13
C6_Q13 <- c(5.2, 5.0, 4.8, 5.3, 5.1, 4.7, 4.9, 4.6, 4.5, 5.2,
            4.2, 5.4, 4.8, 5.2, 5.1, 5.3, 4.7, 5.6, 5.5, 4.8,
            5.2, 4.7, 4.8, 5.0, 4.9)
X_bar=mean(C6_Q13); mu=5; sd=sqrt(var(C6_Q13)); n<-length(C6_Q13); alpha=0.05;
t.test(C6_Q13, alternative=c("two.sided"), conf.level=0.95)

# Q14
phat=0.45; p=0.4; n=1000; alpha=0.05;

Z = (phat-p)/(sqrt(p*(1-p)/n));
z_alpha = qnorm(alpha, lower.tail=FALSE);
result_1 = Z > z_alpha;

# Q15
C6_Q15 <- c(226, 228, 226, 225, 232, 228, 227, 229, 225, 230)
X_bar=mean(C6_Q15); S2=var(C6_Q15); sigma2=1.5^2; n<-length(C6_Q15); alpha=0.05;

# explanation 1
CHI2 = (n-1)*S2/sigma2;
chi_alpha = qchisq(0.05, df=n-1, lower.tail=FALSE);
result_1 = CHI2 > chi_alpha;
# explanation 2
p_value = pchisq(CHI2, df=n-1, lower.tail=FALSE);
result2 = p_value < alpha;