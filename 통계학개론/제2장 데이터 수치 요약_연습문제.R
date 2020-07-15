C2_Q15 = c(57, 61, 57, 58, 57, 61, 54, 68, 51)

# 최빈값을 구하는 Mode 함수
Mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x,ux)))]
}

mean(C2_Q15) # 평균
Mode(C2_Q15) # 최빈값
median(C2_Q15) # 중위값
