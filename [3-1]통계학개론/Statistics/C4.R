# example 4-1
p=0.2
n=10

# (1)
dbinom(3, size=n, prob=p)
# (2)
1-pbinom(1, size=n, prob=p, lower.tail=TRUE)
pbinom(1, size=n, prob=p, lower.tail=FALSE)
# (3)
n*p
sqrt(n*p*(1-p))

# example 4-2
p=0.3
n=8

# (1)
dbinom(4, size=n, prob=p)
# (2)
pbinom(7, size=n, prob=p, lower.tail=TRUE) - pbinom(2, size=n, prob=p, lower.tail=TRUE)
# (3)
1-pbinom(5, size=n, prob=p, lower.tail=TRUE)
pbinom(5, size=n, prob=p, lower.tail=FALSE)

# example 4-3
hit=2
miss=3
n=2

dhyper(0, hit, miss, n)
dhyper(1, hit, miss, n)
dhyper(2, hit, miss, n)

# example 4-4
n=1860
p=1/600
lambda = n*p

dpois(0, lambda)
dpois(1, lambda)
dpois(2, lambda)
dpois(3, lambda)

# example 4-5
lambda = 6

dpois(4, lambda)

# example 4-6
# (1)
pnorm(1.96)
# (2)
pnorm(1.96) - pnorm(-1.96)
# (3)
pnorm(1.96, lower.tail=FALSE)

# example 4-7
# (1)
pnorm(94.3, 70, 10)
# (2)
pnorm(57.7, 70, 10, lower.tail=FALSE)
# (3)
pnorm(94.3, 70, 10) - pnorm(57.7, 70, 10)

# example 4-8
# (1)
pnorm(90, 110, 10)
# (2)
pnorm(115, 110, 10) - pnorm(100, 110, 10)
# (3)
pnorm(120, 110, 10, lower.tail=FALSE)

# example 4-9
x <- c(6,2,4,8,10)
mean(x)
var(x)

# example 4-10
p=0.05
n=100
np = n*p
npq = n*p*(1-p)

# (1)
pnorm(2, np, sqrt(npq))
# (2)
pnorm(7, np, sqrt(npq)) - pnorm(3, np, sqrt(npq))

# example 4-12
.Table <- data.frame(Probability=dbinom(0:10, size=10, prob=0.2))
rownames(.Table) <- 0:10 
print(.Table)

# example 4-13
.Table <- data.frame(Probability=dhyper(0:2, m=2, n=3, k=2))
rownames(.Table) <- 0:2 
print(.Table)

# example 4-14
.Table <- data.frame(Probability=dpois(0:16, lambda=6))
rownames(.Table) <- 0:16 
print(.Table)

# example 4-15
pnorm(c(90), mean=110, sd=10, lower.tail=TRUE)
pnorm(c(115), mean=110, sd=10, lower.tail=TRUE)-pnorm(c(100), mean=110, sd=10, lower.tail=TRUE)
1-pnorm(c(120), mean=110, sd=10, lower.tail=TRUE)

# Q2
pnorm(500, mean=400, sd=50) - pnorm(450, mean=400, sd=50)

# Q3
pbinom(315, 1200, 0.25) - pbinom(285, 1200, 0.25)

# Q4
pnorm(3, 3.25, sqrt(0.5^2 / 25))

# Q8
# (1)
pnorm(82, 76, 10) - pnorm(71, 76, 10)
# (2)
pnorm(75, 76, 10, lower.tail=FALSE)
# (3)
pnorm(78, 76, 10)

# Q9
p=1/9
n=4

dbinom(3, n, p)

# Q10
p=0.1
n=5

1-pbinom(0, n, p)

# Q11
# (1)
2.5
# (2)
dpois(5, 2.5)
# (3)
ppois(4, 2.5, lower.tail=FALSE)
1-ppois(4, 2.5)