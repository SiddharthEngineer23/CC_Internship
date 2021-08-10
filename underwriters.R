library(readxl)
library(xlsx)

xl20 <- read_excel("R/internship/2020 issuances underwriters.xlsx")

hist(xl20$Undewriters, breaks=86, main="Histogram of Underwriters Used Per Issuance (2020)", xlab="Number of Underwriters")

getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}
getmode(xl20$Undewriters)
median(xl20$Undewriters, na.rm=TRUE)
mean(xl20$Undewriters, na.rm=TRUE)
max(xl20$Undewriters, na.rm=TRUE)


for(row in 1:length(xl20$CUSIP)){
  if(xl20$Undewriters[row] == 86){
    print(xl20$CUSIP[row])
  }
}

size = 11
cutoffs_min = c(0, 1, 2, 4, 6, 10, 15, 20, 30, 40, 50)
cutoffs_max = c(2, 3, 5, 7, 11, 16, 21, 31, 41, 51, 87)

buckets = data.frame(
  id = c(1:size),
  count = vector(mode="numeric", length=size),
  amount = vector(mode="numeric", length=size)
)


for(row in 1:length(xl20$Undewriters)){
  for(i in 1:size){
    if(xl20$Undewriters[row] > cutoffs_min[i] && xl20$Undewriters[row] < cutoffs_max[i]){
      buckets$count[i] = buckets$count[i] + 1
      buckets$amount[i] = buckets$amount[i] + xl20$`Amt Issued`[row]
    }
  }
}

print(buckets)

write.xlsx(buckets, "R/internship/pie_chart.xlsx", sheetName = "Sheet1", 
           col.names = TRUE, row.names = TRUE, append = FALSE)

averages = c()

for(row in 1:length(buckets$id)){
  averages[row] = buckets$runners[row] / buckets$count[row]
}

plot(averages, type="h")

plot(xl20$`Amt Issued`, xl20$Undewriters, xlab="Amount Issued", ylab="")


cor(xl20$`Amt Issued`, xl20$Undewriters)
