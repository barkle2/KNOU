HP <- read.table("/home/barkle/workspace/KNOU/Statistics/HIGH_PRESSURE.csv",
                 header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)

Boxplot( ~ AGE, data=HP, id=list(method="y"))