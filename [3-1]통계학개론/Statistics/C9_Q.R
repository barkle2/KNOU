# Q11
O = c(50,62,26,18,4)
E = c(48,64,24,16,8)
CHI2 = sum((O-E)^2 / E)
chi2_alpha = qchisq(0.05, df=4, lower.tail = FALSE)

if (CHI2 > chi2_alpha) {
  result = "H0: rejected"
} else {
  result = "H0: not rejected"
}

# Q12
O = c(192,342,44,22)
E = 600*c(0.3,0.6,0.08,0.02)

CHI2 = sum((O-E)^2 / E)
chi2_alpha = qchisq(0.05, df=3, lower.tail = FALSE)

if (CHI2 > chi2_alpha) {
  result = "H0: rejected"
} else {
  result = "H0: not rejected"
}

# Q13
d<-data.frame(x = c("book_H", "book_L", "book_H", "book_L"),
              y = c("TV_H", "TV_H", "TV_L", "TV_L"),
              num = c(40,18,41,11))
tab=xtabs(num~y+x, data=d);tab

chisq.test(tab, correct=FALSE)
CHI2 = 1.3788
chi2_alpha = qchisq(0.05, df=1, lower.tail=FALSE)

if (CHI2 > chi2_alpha) {
  result = "H0: rejected"
} else {
  result = "H0: not rejected"
}

# Q14
d<-data.frame(x = c("Fac_A", "Fac_B", "Fac_A", "Fac_B"),
              y = c("bad_mind", "bad_mind", "bad_mat", "bad_mat"),
              num = c(21,72,46,26))
tab=xtabs(num~y+x, data=d);tab

chisq.test(tab, correct=FALSE)
CHI2 = 28.713
chi2_alpha = qchisq(0.05, df=1, lower.tail=FALSE)

if (CHI2 > chi2_alpha) {
  result = "H0: rejected"
} else {
  result = "H0: not rejected"
}

# Q15
d<-data.frame(x = c("Dead", "Live", "Dead", "Live"),
              y = c("Low_P", "Low_P", "High_P", "High_P"),
              num = c(25,2650,58,3288))
tab=xtabs(num~y+x, data=d);tab

chisq.test(tab, correct=FALSE)
CHI2 = 6.9777
chi2_alpha = qchisq(0.05, df=1, lower.tail=FALSE)

if (CHI2 > chi2_alpha) {
  result = "H0: rejected"
} else {
  result = "H0: not rejected"
}