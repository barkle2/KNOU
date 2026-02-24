# 디렉토리 설정
setwd("/home/barkle/workspace/KNOU/Visualization")

# 국가별 확진자 데이터를 불러온다.
confirmed <- read.csv("./data/confirmed.csv", header=T)

# 지역 구분이 없는 국가들의 데이터를 선택한다.
cf_data_temp <- subset(confirmed, 
                  Country.Region == "US" | Country.Region == "Italy" | Country.Region == "Spain" | Country.Region == "Brazil" |
                  Country.Region == "Belgium" | Country.Region == "Germany" |Country.Region == "Iran" | Country.Region == "Korea, South")

# 영국과 프랑스는 지역 데이터가 있으므로 Province.State="" 인 데이터만 선택한다.
UK <- subset(confirmed, Province.State == "" & Country.Region == "United Kingdom")
FR <- subset(confirmed, Province.State == "" & Country.Region == "France")

# 10개 국가의 데이터를 합친다
cf_data <- rbind(cf_data_temp, UK, FR)
# Province.State, Lat, Long 컬럼을 삭제한다.
cf_data <- cbind(cf_data[2], cf_data[5:115])
# 날짜컬럼 형식을 바꾼다
names(cf_data)[2:112] <- c(seq(as.Date('20200122', '%Y%m%d'), as.Date('20200511', '%Y%m%d'), 1))

# 와이드(wide) 형태의 데이터를 롱(long) 형태로 변환한다
library(tidyr)
cf_data_long <- gather(cf_data, date, confirmed, '18283':'18393', factor_key = TRUE)

# Country.Region 컬럼 이름을 country로 바꾼다
names(cf_data_long)[1] <- c("country")

# 숫자형태로 표현되는 날짜 컬럼을 날짜 형태로 변환한다
cf_data_long <- transform(cf_data_long, date=as.Date(as.numeric(date), origin="2020-1-19"))

library(ggplot2)
library(gganimate)

# 그래프를 그릴 새 창을 만든다.
graphics.off()
X11(width=10, height=10, xpos=1920, ypos=0)

# 10개 국가의 확진자수를 꺾은 선 그래프로 표현한다
g <- ggplot(cf_data_long, aes(x=date, y=confirmed, col=country)) + 
    geom_point() + 
    geom_line(aes(group=country))

# 10개 국가의 확진자수가 날짜 변화에 따라 어떻게 변하는지 움직이는 그래프로 표현한다.
g <- g + labs(title='{frame_along}') +
  theme_minimal() +
  transition_reveal(date) +
  ease_aes()

# 움직이는 그래프를 gif 파일로 출력한다
animate(g, 100, fps=20, duration=15, width=400, height=400, renderer=gifski_renderer("corona2.gif"))

g  

g <- g + scale_x_discrete(breaks=c("X1.20.20", "X1.27.20", "X2.3.20", "X2.10.20", "X2.17.20", "X2.24.20", "X3.2.20",
                              "X3.9.20", "X3.16.20", "X3.23.20", "X3.30.20", "X4.6.20", "X4.13.20", "X4.20.20",
                              "X4.27.20", "X5.4.20", "X5.11.20"),
                     labels=c("1.20.", "1.27.", "2.3.", "2.10.", "2.17.", "2.24.", "3.2.",
                              "3.9.", "3.16.", "3.23.", "3.30.", "4.6.", "4.13.", "4.20.",
                              "4.27.", "5.4.", "5.11.")) +
  labs(title='test') +
  theme_minimal() +
  transition_reveal(date) +
  ease_aes()



g

animate(g, 100, fps=20, duration=15, width=400, height=400, renderer=gifski_renderer("corona.gif"))




# 국가별 사망자 데이터를 불러온다.
deaths <- read.csv("./data/deaths.csv", header=T)

dt_data_temp <- subset(deaths, 
                       Country.Region == "US" | Country.Region == "Italy" | Country.Region == "Spain" | Country.Region == "Brazil" |
                       Country.Region == "Belgium" | Country.Region == "Germany" |Country.Region == "Iran" | Country.Region == "Korea, South")

UK <- subset(deaths, Province.State == "" & Country.Region == "United Kingdom")
FR <- subset(deaths, Province.State == "" & Country.Region == "France")

dt_data <- rbind(dt_data_temp, UK, FR)

)

colSums(UK[5:115])
rowSums(UK)
