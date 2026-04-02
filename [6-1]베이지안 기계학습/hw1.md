# 베이지안 정규분포 모형 - 사후분포 추정

## 모형 설정

다음과 같은 정규분포 모형에서 $n$개의 자료를 관찰하였다:

$$Y_1, \ldots, Y_n \mid \theta \overset{iid}{\sim} N(\theta, 1)$$

모수 $\theta$ 에 다음과 같은 사전분포를 고려하자:

$$\theta \sim N(0, 25)$$

## 모의실험 데이터 생성

모의실험 자료를 다음과 같이 생성한다 (R code):

```r
set.seed(1);  n = 50;  y = rnorm(n, mean = 10, sd = 1)
```

## 문제

이때, R의 **rstan** 패키지를 활용하여 $\theta$ 의 사후분포에서 **1,000개의 사후분포 표본(posterior sample)**을 얻고,
이를 통해 **95% credible interval**을 그리는 R code를 작성하시오.