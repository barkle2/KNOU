Dataset3 <- read.table("/home/barkle/workspace/KNOU/Statistics/Income.csv", 
  header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)

scatterplot(INCOME~AGE, regLine=TRUE, smooth=FALSE, id=list(method='mahal', 
  n=10), boxplots='xy', data=Dataset3)
