setwd("D:/공부/방송통신대/3학년 2학기/비정형데이터분석/Health-Tweets")

bbc <- read.table("bbchealth.txt", quote="", sep='|', header=FALSE)
bbc[1:15,]