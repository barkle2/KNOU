q1_data = c(70, 65, 63, 72, 81, 83, 66, 75, 80, 75,
            79, 76, 76, 69, 75, 74, 85, 86, 71, 64,
            78, 80, 74, 72, 77, 81, 82, 80, 80, 80,
            87)

hist(q1_data)

stem(q1_data, scale=0.5)

length(q1_data)
summary(q1_data)

q2_man = c(49, 86, 40, 45, 48, 93, 97, 58, 58, 98,
           58, 82, 52, 56, 50, 85, 80, 60, 62, 80,
           62, 72, 65, 60, 64, 70, 78, 67, 69, 88)
q2_woman = c(60, 72, 66, 65, 75, 78, 62, 64, 74, 58,
             68, 72, 67, 61, 62, 72, 79, 71, 74, 73)

hist(q2_man, breaks = 12)
hist(q2_woman)

mean(q2_man)
sd(q2_man)
cov_man = sd(q2_man) / mean(q2_man);

mean(q2_woman)
sd(q2_woman)
cov_woman = sd(q2_woman) / mean(q2_woman);

q4_data = c(68, 70, 70, 71, 69, 74, 71, 72, 70, 73)

X_bar = mean(q4_data)
S = sd(q4_data)
n = length(q4_data)

min_095 = X_bar - qt(0.025, 9, lower.tail=FALSE)*S/sqrt(n)
max_095 = X_bar + qt(0.025, 9, lower.tail=FALSE)*S/sqrt(n)

min_099 = X_bar - qt(0.005, 9, lower.tail=FALSE)*S/sqrt(n)
max_099 = X_bar + qt(0.005, 9, lower.tail=FALSE)*S/sqrt(n)
