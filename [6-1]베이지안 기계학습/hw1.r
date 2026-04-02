library(rstan)

# 데이터 생성(샘플수 50)
set.seed(1)
n <- 50
y <- rnorm(n, mean = 10, sd = 1)

# Stan 모델 정의
stan_model_code <- "
data {
  int<lower=0> n;
  vector[n] y;
}
parameters {
  real theta;
}
model {
  // 사전분포: theta ~ N(0, 25) → sd = 5
  theta ~ normal(0, 5);

  // 가능도: Y_i | theta ~ N(theta, 1)
  y ~ normal(theta, 1);
}
"

# Stan에 넘길 데이터 리스트
stan_data <- list(n = n, y = y)

# MCMC 실행 (사후분포에서 7,000개 샘플 추출)
fit <- stan(
  model_code = stan_model_code,
  data       = stan_data,
  iter       = 10000, # burn-in 3000 + sample 7000
  warmup     = 3000,
  chains     = 1,
  seed       = 42
)

# 사후분포 샘플 추출
posterior_samples <- extract(fit)$theta # 길이 7000

# 95% Credible Interval 계산
ci_95 <- quantile(posterior_samples, probs = c(0.025, 0.975))
cat("95% Credible Interval: [", ci_95[1], ",", ci_95[2], "]\n")

# --- 이미지 파일로 저장 시작 ---
png("hw1_plot.png", width = 800, height = 1600, res = 120)

# 화면 분할: 3번째 패널 높이 비율 넉넉하게
layout(matrix(1:3, nrow = 3, ncol = 1), heights = c(2.5, 1.5, 1.5))

# ── 그래프 1: 사후분포 히스토그램 ──
par(mar = c(4, 4, 3, 1))
hist(posterior_samples,
  breaks = 40,
  col    = "lightblue",
  border = "white",
  main   = "Posterior Distribution of θ (rstan)",
  xlab   = "θ",
  freq   = FALSE
)
lines(density(posterior_samples), col = "darkblue", lwd = 2)
abline(v = ci_95, col = "red", lwd = 2, lty = 2)
legend("topright",
  legend = c(
    "Posterior density",
    paste0("95% CI: [", round(ci_95[1], 3), ", ", round(ci_95[2], 3), "]")
  ),
  col = c("darkblue", "red"),
  lwd = 2,
  lty = c(1, 2)
)

# ── 그래프 2: 체인추적그래프 ──
par(mar = c(4, 4, 3, 1))
chain_samples <- extract(fit, permuted = FALSE)[, , "theta"]
matplot(chain_samples,
  type = "l", lty = 1, col = "darkblue",
  main = "체인추적그래프 of θ", xlab = "Iteration", ylab = "θ"
)

# ── 그래프 3: 자기상관 ──
par(mar = c(5, 4, 4, 1)) # 상하 여백 넉넉하게
acf(chain_samples, main = "자기상관 of θ")

dev.off()
# --- 이미지 저장 끝 ---
