# Example 5-4
C5_E4 <- read.table("/home/barkle/workspace/KNOU/Statistics/C5_E4.csv", 
                     header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)

# (1)
t.test(C5_E4$WAGE, alternative = c("two.sided"), mu=mean(C5_E4$WAGE), conf.level=0.95)

man_wage <- subset(C5_E4$WAGE, C5_E4$SEX == 1)
woman_wage <- subset(C5_E4$WAGE, C5_E4$SEX == 2)

# (2) man
t.test(man_wage, alternative = c("two.sided"), mu=mean(man_wage), conf.level=0.95)
# (2) woman
t.test(woman_wage, alternative = c("two.sided"), mu=mean(woman_wage), conf.level=0.95)

# Example 5-5
C5_E5 <- c(13, 18, 1, 10, 15, 15, 10, 5, 23, 20, 9, 11)

t.test(C5_E5, alternative = c("two.sided"), mu=mean(C5_E5), conf.level=0.95)