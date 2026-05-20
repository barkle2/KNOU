# -*- coding: utf-8 -*-
"""
HW2: Pyro를 활용한 베이지안 회귀모형 (변분추론, SVI)

immigrants 자료에 대해
    wage(Y) ~ sp + lit + n_live (X)
의 베이지안 선형회귀모형을 변분추론(Stochastic Variational Inference)으로 적합한다.

모형:
    beta_j  ~ Normal(0, 10)        (j = 절편, sp, lit, n_live)
    sigma   ~ HalfNormal(10)       (관측 오차의 표준편차)
    y_i     ~ Normal(beta0 + X_i·beta, sigma)

추론:
    AutoDiagonalNormal guide(평균장 정규근사) + ELBO 최대화(SVI)
"""

import os
import sys

# Windows 콘솔(cp949)에서도 한글/특수문자 출력이 깨지지 않도록 UTF-8로 설정
sys.stdout.reconfigure(encoding="utf-8")

import numpy as np
import pandas as pd
import torch
import matplotlib.pyplot as plt

import pyro
import pyro.distributions as dist
from pyro.infer import SVI, Trace_ELBO, Predictive
from pyro.infer.autoguide import AutoDiagonalNormal
from pyro.optim import Adam

# 재현성
pyro.set_rng_seed(0)
torch.set_default_dtype(torch.float64)

HERE = os.path.dirname(os.path.abspath(__file__))
CSV = os.path.join(HERE, "immigrants.csv")

# ---------------------------------------------------------------------------
# 1. 데이터 로딩 및 전처리
# ---------------------------------------------------------------------------
df = pd.read_csv(CSV, index_col=0)
feature_names = ["sp", "lit", "n_live"]

X_raw = df[feature_names].to_numpy(dtype=float)
y_raw = df["wage"].to_numpy(dtype=float)

# 변분추론의 수렴 안정성을 위해 독립변수를 표준화한다.
# (적합 후 계수를 원래 척도로 환산하여 해석한다.)
X_mean, X_std = X_raw.mean(axis=0), X_raw.std(axis=0)
X_std_mat = (X_raw - X_mean) / X_std

X = torch.tensor(X_std_mat)
y = torch.tensor(y_raw)

N, P = X.shape
print(f"[데이터] 표본수 N={N}, 독립변수 수 P={P} ({', '.join(feature_names)})")


# ---------------------------------------------------------------------------
# 2. 모형 정의
# ---------------------------------------------------------------------------
def model(X, y=None):
    # 사전분포
    beta0 = pyro.sample("beta0", dist.Normal(0.0, 10.0))                     # 절편
    beta = pyro.sample("beta", dist.Normal(torch.zeros(P), 10.0).to_event(1))  # 기울기
    sigma = pyro.sample("sigma", dist.HalfNormal(10.0))                       # 오차 표준편차

    mean = beta0 + X @ beta
    with pyro.plate("data", X.shape[0]):
        return pyro.sample("obs", dist.Normal(mean, sigma), obs=y)


# 평균장 정규근사 가이드
guide = AutoDiagonalNormal(model)


# ---------------------------------------------------------------------------
# 3. 변분추론(SVI) 학습
# ---------------------------------------------------------------------------
pyro.clear_param_store()
svi = SVI(model, guide, optim=Adam({"lr": 0.01}), loss=Trace_ELBO())

n_steps = 5000
losses = []
for step in range(n_steps):
    loss = svi.step(X, y)
    losses.append(loss)
    if step % 500 == 0 or step == n_steps - 1:
        print(f"  step {step:5d}  ELBO loss = {loss:,.3f}")


# ---------------------------------------------------------------------------
# 4. 사후분포 요약 (표준화된 척도)
# ---------------------------------------------------------------------------
predictive = Predictive(model, guide=guide, num_samples=4000,
                        return_sites=["beta0", "beta", "sigma"])
samples = predictive(X)

beta0_s = samples["beta0"].reshape(-1)
beta_s = samples["beta"].reshape(-1, P)
sigma_s = samples["sigma"].reshape(-1)


def summarize(name, s):
    s = s.detach().numpy()
    lo, hi = np.percentile(s, [2.5, 97.5])
    return name, s.mean(), s.std(), lo, hi


print("\n[사후분포 요약 - 표준화된 독립변수 기준]")
print(f"{'parameter':<14}{'mean':>10}{'sd':>10}{'2.5%':>10}{'97.5%':>10}")
rows = [summarize("Intercept", beta0_s)]
for j, fn in enumerate(feature_names):
    rows.append(summarize(f"beta[{fn}]", beta_s[:, j]))
rows.append(summarize("sigma", sigma_s))
for name, m, sd, lo, hi in rows:
    print(f"{name:<14}{m:>10.4f}{sd:>10.4f}{lo:>10.4f}{hi:>10.4f}")


# ---------------------------------------------------------------------------
# 5. 원래 척도로 계수 환산 (해석용)
#    표준화: x' = (x - mean)/std  =>  beta_orig_j = beta_std_j / std_j
#            intercept_orig = beta0_std - sum_j beta_std_j * mean_j / std_j
# ---------------------------------------------------------------------------
std_t = torch.tensor(X_std, dtype=torch.float64)
mean_t = torch.tensor(X_mean, dtype=torch.float64)

beta_orig = beta_s / std_t                       # (S, P)
intercept_orig = beta0_s - (beta_s * mean_t / std_t).sum(axis=1)

print("\n[원래 척도로 환산한 계수]")
print(f"{'parameter':<16}{'mean':>10}{'2.5%':>10}{'97.5%':>10}")


def line(name, s):
    s = s.detach().numpy()
    lo, hi = np.percentile(s, [2.5, 97.5])
    print(f"{name:<16}{s.mean():>10.4f}{lo:>10.4f}{hi:>10.4f}")


line("Intercept", intercept_orig)
for j, fn in enumerate(feature_names):
    line(fn, beta_orig[:, j])


# ---------------------------------------------------------------------------
# 6. 그래프 저장: ELBO 수렴, 계수 사후분포
# ---------------------------------------------------------------------------
fig, axes = plt.subplots(1, 2, figsize=(12, 4.5))

axes[0].plot(losses, lw=0.8)
axes[0].set_title("ELBO loss (SVI convergence)")
axes[0].set_xlabel("SVI step")
axes[0].set_ylabel("-ELBO")

for j, fn in enumerate(feature_names):
    axes[1].hist(beta_orig[:, j].detach().numpy(), bins=40, alpha=0.5, label=fn)
axes[1].axvline(0, color="k", ls="--", lw=1)
axes[1].set_title("Posterior of slope coefficients (original scale)")
axes[1].set_xlabel("coefficient value")
axes[1].legend()

fig.tight_layout()
out_png = os.path.join(HERE, "hw2_result.png")
fig.savefig(out_png, dpi=120)
print(f"\n[그래프 저장] {out_png}")
