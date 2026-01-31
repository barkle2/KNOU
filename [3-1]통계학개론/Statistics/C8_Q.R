# C8_Q13
year = c(1.0, 1.5, 2.0, 2.0, 2.0, 3.0, 3.0, 3.2, 4.0, 4.5, 5.0, 5.0, 5.5)
price = c(4.5, 4.0, 3.2, 3.4, 2.5, 2.3, 2.3, 2.3, 1.6, 1.5, 1.0, 0.8, 0.4)
C8_Q13 = data.frame(year, price)

scatterplot(price~year, data=C8_Q13, regLine=TRUE, smooth=FALSE, boxplot=FALSE)

Model8_13 <- lm(price~year, data=C8_Q13)
summary(Model8_13)

# fitted regression Line: price_hat_i = 4.90687 - 0.81509 * year_i

# C8_Q14
mid = c(92, 65, 75, 83, 95)
final = c(87, 71, 75, 84, 93)
C8_Q14 = data.frame(mid, final)

scatterplot(final~mid, data=C8_Q14, regLine=TRUE, smooth=FALSE, boxplot=FALSE)

Model8_14 <- lm(final~mid, data=C8_Q14)
summary(Model8_14)

# fitted regression Line: final_hat_i = 23.872 + 0.70888 * mid_i

# C8_Q15
coffee = c(0.68, 1.21, 1.92, 1.81, 1.55, 1.87, 1.56)
sugar = c(0.245, 0.126, 0.092, 0.086, 0.101, 0.223, 0.212)
C8_Q15 = data.frame(coffee, sugar)

scatterplot(sugar~coffee, data=C8_Q15, regLine=TRUE, smooth=FALSE, boxplot=FALSE)

Model8_15 <- lm(sugar~coffee, data=C8_Q15)
summary(Model8_15)

# fitted regression Line: sugar_hat = 0.26801 + -0.07463 * coffee_i
# p-value: 0.2772