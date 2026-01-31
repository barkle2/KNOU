# Q13
nA=60; bar_X=14800; SA = sqrt(180000);
nB=70; bar_Y=14500; SB = sqrt(133000);
alpha = 0.05;

# H0: Mu1-Mu2=0
# H1: Mu1 > Mu2

# SP, T 
T = (bar_X - bar_Y) / (sqrt(SA^2/nA + SB^2/nB));
Z_alpha = qnorm(alpha, lower.tail=FALSE);

# explanation
if (T > Z_alpha) {
  result = "H0: rejected"
} else {
  result = "H0: not rejected"
}

# Q14
before = c(8, 12, 5, 4, 6, 3, 4, 3, 2, 6, 6, 9);
after  = c(5, 3,  2, 1, 4, 2, 2, 4, 3, 5, 4, 3);
n=12;
alpha = 0.05;

D_bar = mean(before-after);
SD = sqrt( var(before-after) );
T = D_bar / (SD/sqrt(n));

# H0: Mu1-Mu2=0
# H1: Mu1 > Mu2

# explanation 1
t_alpha = qt(alpha, df=n-1, lower.tail = FALSE);
if (T > t_alpha) {
  result = "H0: rejected"
} else {
  result = "H0: not rejected"
}

# Q15
X = c(12, 11, 7, 13, 9, 11, 12, 9)
Y = c(8, 10, 7, 5, 6, 10, 7, 8, 11, 7, 8)
Z = c(9, 3, 7, 8, 4, 6, 6, 5)
alpha = 0.01;

T = c(X, Y, Z)
T_avg = mean(T); X_avg = mean(X); Y_avg = mean(Y); Z_avg = mean(Z);
CT = sum(T)^2 / 27;
ST = sum(T^2) - CT;
SA = (X_avg-T_avg)^2*length(X) + (Y_avg-T_avg)^2*length(Y) + (Z_avg-T_avg)^2*length(Z)
SE = ST - SA;
phi_A = 2; phi_E = 24; phi_T = 26;
VA = SA/phi_A; VE = SE/phi_E;
F = VA/VE;

# explanation
f_alpha = qf(alpha, 2, 24, lower.tail=FALSE)
if (F > f_alpha) {
  result = "H0: rejected"
} else {
  result = "H0: not rejected"
}

# Q16
A = c(69, 67, 65, 59, 68, 61, 66);
B = c(56, 63, 55, 59, 52, 57);
C = c(71, 72, 70, 68, 74);
alpha = 0.05;

T = c(A, B, C)
T_avg = mean(T); A_avg = mean(A); B_avg = mean(B); C_avg = mean(C);
CT = sum(T)^2 / 18;
ST = sum(T^2) - CT;
SA = (A_avg-T_avg)^2*length(A) + (B_avg-T_avg)^2*length(B) + (C_avg-T_avg)^2*length(C);
SE = ST - SA;

phi_A = 2; phi_E = 15; phi_T = 18;
VA = SA/phi_A; VE = SE/phi_E;
F = VA/VE;

# explanation
f_alpha = qf(alpha, 2, 15, lower.tail=FALSE)
if (F > f_alpha) {
  result = "H0: rejected"
} else {
  result = "H0: not rejected"
}

# Q17
C7_Q17 <- read.table("/home/barkle/workspace/KNOU/Statistics/C7_Q17.csv", 
                    header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)

C7_Q17 <- within(C7_Q17, {
  Material <- factor(Material, labels=c('A1','A2','A3','A4','A5'))
  Amount <- factor(Amount, labels=c('B1','B2','B3','B4'))
})

summary(aov(Pstr~Material+Amount, data=C7_Q17))

Fa = 264.7;
Fb = 73.8;
fa_alpha = qf(0.05, 4, 12, lower.tail=FALSE);
fb_alpha = qf(0.05, 3, 12, lower.tail=FALSE);

if (Fa > fa_alpha) {
  result_a = "H0: rejected"
} else {
  result_a = "H0: not rejected"
}

if (Fb > fb_alpha) {
  result_b = "H0: rejected"
} else {
  result_b = "H0: not rejected"
}
