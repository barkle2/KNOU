C3_Q13 <- read.table("/home/barkle/workspace/KNOU/Statistics/C3_Q13.csv", 
                     header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)

# probability distribution graph
pic1<-C3_Q13$Labor / sum(C3_Q13$Labor)
names(pic1)<-0:10
barplot(pic1, ylim=c(0, 0.2), xlab="Days absent")

# cumulative probability distribution graph
pic2<-cumsum(C3_Q13$Labor/sum(C3_Q13$Labor))
names(pic2)<-0:10
barplot(pic2, ylim=(c(0,1)), xlab="Days absent")

# mean, variance
ma<-pic1*C3_Q13$X
mean1 = sum(ma)

va<-pic1*(C3_Q13$X^2)
var1 = sum(va) - mean1^2
