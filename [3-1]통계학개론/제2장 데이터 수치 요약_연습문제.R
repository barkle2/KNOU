# 연습문제 15번
C2_Q15 = c(57, 61, 57, 58, 57, 61, 54, 68, 51)

# 최빈값을 구하는 Mode 함수
Mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x,ux)))]
}

mean(C2_Q15) # 평균
Mode(C2_Q15) # 최빈값
median(C2_Q15) # 중앙값

# 연습문제 16번
C2_Q16 = c(92, 107, 353, 90, 78, 92, 102, 86, 106, 109, 95, 102, 91)

mean(C2_Q16) # 평균
median(C2_Q16) # 중앙값

# 연습문제 17번
C2_Q17 <- read.table("./data/Ch2_Q17.csv", header=TRUE, 
                      sep=",", na.strings="NA", dec=".", strip.white=TRUE)

mean(C2_Q17$A) # A 평균
median(C2_Q17$A) # A 중앙값
mean(C2_Q17$B) # B 평균
median(C2_Q17$B) # B 중앙값
mean(C2_Q17$C) # C 평균
median(C2_Q17$C) # C 중앙값

# 연습문제 18번
C2_Q18 = c(0.062, 0.071, 0.067, 0.068, 0.066, 0.062, 0.068, 0.067, 0.060, 0.065)

mean(C2_Q18) # 평균
sd(C2_Q18) # 표준편차
median(C2_Q18) # 중앙값
max(C2_Q18)-min(C2_Q18) # 범위

# 연습문제 19번
C2_Q19 <- read.table("./data/Ch2_Q19.csv", 
                     header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)

summary(C2_Q19$A) # A 점수 분석
summary(C2_Q19$B) # B 점수 분석
sd(C2_Q19$A) # A 표준편차
sd(C2_Q19$B) # B 표준편차
boxplot(C2_Q19) # 상자그림
