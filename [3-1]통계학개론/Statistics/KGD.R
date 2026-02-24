KDG <- read.table("/home/barkle/workspace/KNOU/Statistics/Kg_Decrease.csv", 
                  header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)

numSummary(KDG[,"Kg_decrease", drop=FALSE], statistics=c("mean", "sd", 
                                                         "IQR", "quantiles"), quantiles=c(0,.25,.5,.75,1))
summary(KDG)