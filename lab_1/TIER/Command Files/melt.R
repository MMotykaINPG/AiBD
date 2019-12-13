df <- read.spss("pew.sav", use.value.label=TRUE, to.data.frame=TRUE)
library(foreign)
install.packages('dplyr')
library(dplyr)
install.packages('reshape2')
library(reshape2)
data = select(df, q16,income)

tmp = factor(data)
tmp = factor(data[2])
tmp = factor(data)


data$income <- c("Less than $10,000" = "<$10k",
                 "10 to under $20,000" = "$10-20k",
                 "20 to under $30,000" = "$20-30k",
                 "30 to under $40,000" = "$30-40k",
                 "40 to under $50,000" = "$40-50k",
                 "50 to under $75,000" = "$50-75k",
                 "75 to under $100,000" = "$75-100k",
                 "100 to under $150,000" = "$100-150k",
                 "$150,000 or more" = ">150k",
                 "Don't know/Refused (VOL)" = "Don't know/refused")[data$income]

data$income <- factor(data$income, levels = c("<$10k", "$10-20k", "$20-30k", "$30-40k", "$40-50k", "$50-75k",
                                              "$75-100k", "$100-150k", ">150k", "Don't know/refused"))






relogionFactor = factor(data$q16)
incomeFactor = factor(data$income)
table1 = matrix(0L,nrow=nlevels(relogionFactor),ncol=nlevels(incomeFactor))
rownames(table1) = levels(relogionFactor)
colnames(table1) = levels(incomeFactor)


table1t = table1
for (i in 1:nrow(data))
{
  xx = data[i,1]
  yy = data[i,2]
  table1[xx,yy] = table1[xx,yy]+1
}
colnames(table1) = levels(incomeFactor)
colnames(table1) = levels(incomeFactor)
write.csv(table1,"pew_final.csv")

table2 = melt(table1)
colnames(table2) = c("religion","income","freq")

write.csv(table2,"dwa.csv")
