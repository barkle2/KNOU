C2_Q15 <- read.table("/home/barkle/workspace/KNOU/Statistics/C2_Q15.csv", 
                     header=FALSE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)

Mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x,ux)))]
}

mean(C2_Q15$V1)
Mode(C2_Q15$V1)
median(C2_Q15$V1)

C2_Q16 <- read.table("/home/barkle/workspace/KNOU/Statistics/C2_Q16.csv", 
                     header=FALSE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)

mean(C2_Q16$V1)
median(C2_Q16$V1)

setwd("D:/Git/KNOU/통계학개론")

C2_Q17 <- read.table("./data/Ch2_Q17.csv", 
                     header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)

mean(C2_Q17$A)
median(C2_Q17$A)
mean(C2_Q17$B)
median(C2_Q17$B)
mean(C2_Q17$C)
median(C2_Q17$C)

C2_Q18 <- read.table("/home/barkle/workspace/KNOU/Statistics/C2_Q18.csv", 
                     header=FALSE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)

mean(C2_Q18$V1)
sd(C2_Q18$V1)
median(C2_Q18$V1)
max(C2_Q18$V1)-min(C2_Q18$V1)

summary(C2_Q18$V1)

C2_Q19 <- read.table("/home/barkle/workspace/KNOU/Statistics/C2_Q19.csv", 
                     header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)

summary(C2_Q19$A)
summary(C2_Q19$B)
sd(C2_Q19$A)
sd(C2_Q19$B)
#Boxplot(~A, data=C2_Q19)
#Boxplot(~B, data=C2_Q19)

Boxplot(C2_Q19)
