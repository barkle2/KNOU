# -*- coding: utf-8 -*-
import sys
sys.stdout.reconfigure(encoding="utf-8")

import jax
import numpyro
import numpyro.distributions as dist
import pandas as pd
import os

HERE = os.path.dirname(os.path.abspath(__file__))

# 데이터
dset = pd.read_csv(os.path.join(HERE, "immigrants.csv"), index_col=0)

# 데이터 표준화 (평균 0, 표준편차 1) -- 추가 예제와 동일 방식
standardize = lambda x: (x - x.mean()) / x.std()
dset["wageScaled"] = dset.wage.pipe(standardize)
dset["spScaled"] = dset.sp.pipe(standardize)
dset["litScaled"] = dset.lit.pipe(standardize)
dset["n_liveScaled"] = dset.n_live.pipe(standardize)


# 모형정의 - likelihood, prior
def regmodel(sp=None, lit=None, n_live=None, wage=None):
    # prior
    a = numpyro.sample("a", dist.Normal(0, 10))          # 절편
    b_sp = numpyro.sample("b_sp", dist.Normal(0, 10))    # 기울기 sp
    b_lit = numpyro.sample("b_lit", dist.Normal(0, 10))  # 기울기 lit
    b_nlive = numpyro.sample("b_nlive", dist.Normal(0, 10))  # 기울기 n_live
    tausq = numpyro.sample("tausq", dist.Gamma(0.01, 0.01))
    sigma = jax.numpy.sqrt(1.0 / tausq)
    mu = a + b_sp * sp + b_lit * lit + b_nlive * n_live

    # likelihood
    with numpyro.plate("data", len(wage)):
        numpyro.sample("obs", dist.Normal(mu, sigma), obs=wage)


# 변분분포 정의
def guide(sp=None, lit=None, n_live=None, wage=None):
    # tau
    alpha_tau = numpyro.param("alpha_tau", 1.0, constraint=dist.constraints.positive)
    beta_tau = numpyro.param("beta_tau", 1.0, constraint=dist.constraints.positive)
    numpyro.sample("tausq", dist.Gamma(alpha_tau, beta_tau))

    # a
    loc_a = numpyro.param("loc_a", 0.0)
    scale_a = numpyro.param("scale_a", 1.0, constraint=dist.constraints.positive)
    numpyro.sample("a", dist.Normal(loc_a, scale_a))

    # b_sp
    loc_sp = numpyro.param("loc_sp", 0.0)
    scale_sp = numpyro.param("scale_sp", 1.0, constraint=dist.constraints.positive)
    numpyro.sample("b_sp", dist.Normal(loc_sp, scale_sp))

    # b_lit
    loc_lit = numpyro.param("loc_lit", 0.0)
    scale_lit = numpyro.param("scale_lit", 1.0, constraint=dist.constraints.positive)
    numpyro.sample("b_lit", dist.Normal(loc_lit, scale_lit))

    # b_nlive
    loc_nlive = numpyro.param("loc_nlive", 0.0)
    scale_nlive = numpyro.param("scale_nlive", 1.0, constraint=dist.constraints.positive)
    numpyro.sample("b_nlive", dist.Normal(loc_nlive, scale_nlive))


# 최적화
from numpyro.infer import SVI, Trace_ELBO
from numpyro.optim import Adam

optimizer = Adam(step_size=0.001)
svi = SVI(regmodel, guide, optimizer, loss=Trace_ELBO())

n_steps = 10000
svi_state = svi.init(
    jax.random.PRNGKey(0),
    sp=dset.spScaled.values,
    lit=dset.litScaled.values,
    n_live=dset.n_liveScaled.values,
    wage=dset.wageScaled.values,
)

elbo_values = []
for step in range(n_steps):
    svi_state, elbo = svi.update(
        svi_state,
        sp=dset.spScaled.values,
        lit=dset.litScaled.values,
        n_live=dset.n_liveScaled.values,
        wage=dset.wageScaled.values,
    )
    elbo_values.append(-elbo)
    if step % 1000 == 0:
        print("step {}: ELBO = {}".format(step, elbo))

params = svi.get_params(svi_state)
print("\n--- params ---")
for k, v in params.items():
    print(k, float(v))

print("\n--- 회귀계수 사후평균 (표준화 척도) ---")
print("a      =", float(params["loc_a"]))
print("b_sp   =", float(params["loc_sp"]))
print("b_lit  =", float(params["loc_lit"]))
print("b_nlive=", float(params["loc_nlive"]))
print("tausq mean =", float(params["alpha_tau"] / params["beta_tau"]))
