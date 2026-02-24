# 202035-368086, 김동현

# gutenberg 프로젝트에서 전체 파일을 읽어옵니다.
RC <- scan("http://www.gutenberg.org/files/521/521-0.txt", what="character",
           encoding="UTF-8", sep='\n')

# 로빈슨 크루소는 20개의 챕터로 이뤄져 있습니다.
# 521-0.txt 파일을 보면 CHAPTER 단어가 40번 나옵니다.(차례 20번, 본문 20번)
# 21~40번의 CHAPTER 단어가 나타나는 부분이 CHAPTER의 시작부분입니다.
RC_Chpt_Start <- grep(RC, pattern="CHAPTER")
RC_Chpt_Start <- RC_Chpt_Start[21:40]

# 챕터 2와 챕터 5를 읽어옵니다.
RC_Chpt2 = RC[RC_Chpt[2]:(RC_Chpt[3]-1)]
RC_Chpt5 = RC[RC_Chpt[5]:(RC_Chpt[6]-1)]

print(RC_Chpt2)
print(RC_Chpt5)

# 나누어진 행들을 하나의 문자열로 연결합니다.
RC_Chpt2_v1 = paste(RC_Chpt2, collapse=" ")

# 합치면서 행 사이에 빈칸을 추가했기 때문에 395개의 문자가 늘었습니다.
sum(nchar(RC_Chpt2))
nchar(RC_Chpt2_v1)

# 's 를 삭제합니다.
RC_Chpt2_v2 = gsub(RC_Chpt2_v1, pattern="'s", replacement="")
nchar(RC_Chpt2_v2)

# 아포스트로피(')와 하이픈(-)을 제외한 나머지 문장부호들을 제거합니다.
RC_Chpt2_v3 = gsub(RC_Chpt2_v2, pattern="([^[:alnum:][:blank:]'-])", replacement="")
nchar(RC_Chpt2_v3)

# 대문자를 소문자로 변환합니다.
RC_Chpt2_v4 = tolower(RC_Chpt2_v3)
nchar(RC_Chpt2_v4)

# 문서를 공백 기준으로 나누어 단어 단위로 분리합니다. 
RC_Chpt2_v5 = unlist(strsplit(RC_Chpt2_v4, " "))
sum(nchar(RC_Chpt2_v5))

# 불용어와 빈단어를 삭제합니다.
library(stopwords)
RC_Chpt2_v6 = RC_Chpt2_v5[! RC_Chpt2_v5 %in% c(stopwords())]
sum(nchar(RC_Chpt2_v6))

RC_Chpt2_v7 = gsub(RC_Chpt2_v6, pattern="'", replacement="")
sum(nchar(RC_Chpt2_v7))

# 단어를 표제어로 변환합니다.
library(textstem)
RC_Chpt2_v8 = lemmatize_strings(RC_Chpt2_v7)
sum(nchar(RC_Chpt2_v8))

RC_Chpt2_v8

# 많이 사용된 단어를 볼 수 있도록 도수분포표를 작성합니다.
RC_Chpt2_table = sort(table(RC_Chpt2_v8), decreasing=T)
print(RC_Chpt2_table)

RC_Chpt2_prop_table = sort(prop.table(table(RC_Chpt2_v8)), decreasing=T)
print(RC_Chpt2_prop_table)

# 챕터 5

# 나누어진 행들을 하나의 문자열로 연결합니다.
RC_Chpt5_v1 = paste(RC_Chpt5, collapse=" ")

# 합치면서 행 사이에 빈칸을 추가했기 때문에 395개의 문자가 늘었습니다.
sum(nchar(RC_Chpt5))
nchar(RC_Chpt5_v1)

# 's 를 삭제합니다.
RC_Chpt5_v2 = gsub(RC_Chpt5_v1, pattern="'s", replacement="")
nchar(RC_Chpt5_v2)

# 아포스트로피(')와 하이픈(-)을 제외한 나머지 문장부호들을 제거합니다.
RC_Chpt5_v3 = gsub(RC_Chpt5_v2, pattern="([^[:alnum:][:blank:]'-])", replacement="")
nchar(RC_Chpt5_v3)

# 대문자를 소문자로 변환합니다.
RC_Chpt5_v4 = tolower(RC_Chpt5_v3)
nchar(RC_Chpt5_v4)

# 문서를 공백 기준으로 나누어 단어 단위로 분리합니다. 
RC_Chpt5_v5 = unlist(strsplit(RC_Chpt5_v4, " "))
sum(nchar(RC_Chpt5_v5))

# 불용어와 빈단어를 삭제합니다.
RC_Chpt5_v6 = RC_Chpt5_v5[! RC_Chpt5_v5 %in% c(stopwords())]
sum(nchar(RC_Chpt5_v6))

RC_Chpt5_v7 = gsub(RC_Chpt5_v6, pattern="'", replacement="")
sum(nchar(RC_Chpt5_v7))

# 단어를 표제어로 변환합니다.
RC_Chpt5_v8 = lemmatize_strings(RC_Chpt5_v7)
sum(nchar(RC_Chpt5_v8))

RC_Chpt5_v8

# 많이 사용된 단어를 볼 수 있도록 도수분포표를 작성합니다.
RC_Chpt5_table = sort(table(RC_Chpt5_v8), decreasing=T)
print(RC_Chpt5_table)

RC_Chpt2_prop_table = sort(prop.table(table(RC_Chpt2_v8)), decreasing=T)
print(RC_Chpt2_prop_table)

# 챕터 2와 5에 나오는 단어 리스트를 생성한다.
RC_Chpt25_list = unique(c(RC_Chpt2_v8, RC_Chpt5_v8))

# 생성한 단어 리스트를 기준으로 도수분포표를 작성한다.
RC_Chpt2_table = table(factor(RC_Chpt2_v8, levels=RC_Chpt25_list, ordered=T))
RC_Chpt5_table = table(factor(RC_Chpt5_v8, levels=RC_Chpt25_list, ordered=T))

# 챕터5와 챕터2 사이의 출현빈도의 차값으로 도수분포표를 작성한다.
RC_Chpt5_2_table = sort(RC_Chpt5_table - RC_Chpt2_table)

# 출현빈도의 차가 -5보다 작거나 5보다 큰 경우만 남긴다.
RC_Chpt5_2_table = RC_Chpt5_2_table[abs(RC_Chpt5_2_table)>5]

# 도수분포표를 출력한다.
RC_Chpt5_2_table

# 막대그래프를 출력한다.
barplot(RC_Chpt5_2_table, las=2)

# 공통 단어의 행렬을 만듭니다.
RC_Chpt25_table = cbind(RC_Chpt2_table, RC_Chpt5_table)

# 챕터의 빈도수 합으로 워드 클라우드를 생성합니다.
library(wordcloud)
commonality.cloud(RC_Chpt25_table, max.words=100, random.order=FALSE)

# 챕터의 빈도수 차로 워드 클라우드를 생성합니다.
comparison.cloud(RC_Chpt25_table, max.words=100, random.order=FALSE)

# RC_Chpt25_table 3열에 단어별 출현빈도 차이를 추가합니다.
RC_Chpt25_table = cbind(RC_Chpt25_table, RC_Chpt25_table[,1]-RC_Chpt25_table[,2])

# 챕터 2에 더 많이 나타난 단어는 초록, 챕터 5에 더 많이 나타난 단어는 빨강
RC_Chpt25_col = ifelse(RC_Chpt25_table[,3] > 10, "darkgreen",
                       ifelse(RC_Chpt25_table[,3] < -10, "red", "grey"))
plot(RC_Chpt25_table[,1], RC_Chpt25_table[,2], type='n')
text(RC_Chpt25_table[,1], RC_Chpt25_table[,2], row.names(RC_Chpt25_table), col=RC_Chpt25_col)


# gutenberg 프로젝트에서 전체 파일을 읽어옵니다.
RC <- scan("http://www.gutenberg.org/files/521/521-0.txt", what="character",
           encoding="UTF-8", sep='\n')

# 로빈슨 크루소는 20개의 챕터로 이뤄져 있습니다.
# 521-0.txt 파일을 보면 CHAPTER 단어가 40번 나옵니다.(차례 20번, 본문 20번)
# 21~40번의 CHAPTER 단어가 나타나는 부분이 CHAPTER의 시작부분입니다.
RC_Chpt_Start <- grep(RC, pattern="CHAPTER")
RC_Chpt_Start <- RC_Chpt_Start[21:40]

# 챕터 2와 챕터 5를 읽어옵니다.
RC_Chpt2 = RC[RC_Chpt[2]:(RC_Chpt[3]-1)]
RC_Chpt5 = RC[RC_Chpt[5]:(RC_Chpt[6]-1)]

# 챕터 2와 5에 나오는 단어 리스트를 생성한다.
RC_Chpt25_list = unique(c(RC_Chpt2_v8, RC_Chpt5_v8))
RC25 = rbind(RC_Chpt2_v8, RC_Chpt5_v8)
typeof(RC_Chpt2_table)


View(RC25)
dim(RC_Chpt25_list)
RC25_DTM = lapply(RC25, FUN=function(x, lev){table(factor(x, lev, ordered=T))}, RC_Chpt25_list)
RC25_DTM = matrix(unlist(RC25_DTM), nrow=length(RC25_DTM), byrow=TRUE)

dim(RC25_DTM>0)
sum(RC25_DTM>0)
sum(RC25_DTM==0)
View(RC25_DTM)

library(plyr)

library(lsa)
td=tempfile()
dir.create(td)

write(RC_Chpt2_v8, file=paste(td, "CH2", sep="/"))
write(RC_Chpt5_v8, file=paste(td, "CH5", sep="/"))

myMatrix = textmatrix(td)

lsa::cosine(myMatrix[,1], myMatrix[,2])



