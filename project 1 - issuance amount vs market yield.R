library(readxl)
library(lubridate)
issuance_2020 <- read_excel("C:/Users/ME/Desktop/Raw data/issuance 2020.xlsx")
sector <- read_excel("C:/Users/ME/Desktop/Raw data/Sector.xlsx")

issuance_2020$`Issue Date` = as.Date(issuance_2020$`Issue Date`, "%m/%d/%Y")
issuance_2020$Amount = as.numeric(issuance_2020$Amount)
class(issuance_2020$`Issue Date`)
class(issuance_2020$Amount)

sector$Date = as.Date(sector$Date)
class(sector$Date)

# size = 15
# sum = vector(mode="numeric", length=size)
# d = ymd("2019-10-01")
# 
# for(index in 1:size){
#   month = issuance_2020$Amount[issuance_2020$`Issue Date` > d & issuance_2020$`Issue Date` < (d %m+% months(1))]
#   sum[index] = sum(month, na.rm = TRUE)
#   d = d %m+% months(1)
# }
# 
# plot(sum, type="l")

date = c()
amount = c()
bench = c()

d = ymd("2019-10-01")
index = 1
period_length = 7

while(d < "2021-01-01"){
  #tracking date
  date[index] = d
  
  #tracking amount in period
  period = issuance_2020$Amount[issuance_2020$`Issue Date` > d & issuance_2020$`Issue Date` < (d + period_length)]
  amount[index] = sum(period, na.rm = TRUE)
  
  #tracking average yield of benchmark in period
  bench_period = sector$AUSDDNFI5Y[sector$Date > d & sector$Date < (d + period_length)]
  bench[index] = mean(bench_period, na.rm = TRUE)
  
  index = index + 1
  d = d + period_length
}

plot(as_date(date), amount, xlab="Date", ylab="Amount", main="Issuance amount versus market yield", type="l", col="red")
par(new=TRUE)
plot(as_date(date), bench, xaxt="n", yaxt="n", xlab="", ylab="", type="l", col="blue")
axis(side=4)



d1 = ymd("2020-03-10")
list = c()
list[1] = d1
