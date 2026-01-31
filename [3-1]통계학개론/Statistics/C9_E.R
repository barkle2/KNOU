# example 9-6
C9_E6 <- read.table("/home/barkle/workspace/KNOU/Statistics/C9_E6.csv", 
                    header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)

library(abind, pos=17)
local({.Table <- xtabs(~SMOKING+SEX, data=C9_E6)
 cat("\nFrequency table:\n")
 print(.Table)
 .Test <- chisq.test(.Table, correct=FALSE)
 print(.Test)
})

# example 9-7
wage = c(160,100,200,120,70,80,190,100,120,110,
         150,150,210,160,80,70,250,300,100,160,
         150,170,130,200,230,160,70,130,80,150,
         220,200,90,150,150,100,120,349,80,100)

C9_E7 = data.frame(wage)
normalityTest(~wage, test="shapiro.test", data=C9_E7)