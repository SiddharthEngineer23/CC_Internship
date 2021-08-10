library(readxl)
library(lubridate)
xl18 <- read_excel("R/internship/2018 issuance.xlsx")
xl19 <- read_excel("R/internship/2019 issuance.xlsx")
xl20 <- read_excel("R/internship/2020 issuance.xlsx")
xl21 <- read_excel("R/internship/2021 issuance.xlsx")

xl18$`Issue Date` = mdy(xl18$`Issue Date`)
xl19$`Issue Date` = mdy(xl19$`Issue Date`)
xl20$`Issue Date` = mdy(xl20$`Issue Date`)
xl21$`Issue Date` = mdy(xl21$`Issue Date`)

val18 = c()
val19 = c()
val20 = c()
val21 = c()
total = c()
count = 1
i = 1

useAll = FALSE
sector = "Health Care"


for(j in 1:length(xl18$`Issuer Name`)){
  if(useAll || xl18$`BICS Level 1`[j]==sector){
    x = wday(xl18$`Issue Date`[j], label=TRUE)
    val18[i] = x
    total[count] = x
    count = count + 1
    i = i + 1
  }
}

i = 1
for(j in 1:length(xl19$`Issuer Name`)){
  if(useAll || xl19$`BICS Level 1`[j]==sector){
    x = wday(xl19$`Issue Date`[j], label=TRUE)
    val19[i] = x
    total[count] = x
    count = count + 1
    i = i + 1
  }
  
  # if(wday(xl19$`Issue Date`[i], label=TRUE) == 1){
  #   print(xl19$CUSIP[i])
  # }
}

i = 1
for(j in 1:length(xl20$`Issuer Name`)){
  if(useAll || xl20$`BICS Level 1`[j]==sector){
    x = wday(xl20$`Issue Date`[j], label=TRUE)
    val20[i] = x
    total[count] = x
    count = count + 1
    i = i + 1
  }
}

i = 1
for(j in 1:length(xl21$`Issuer Name`)){
  if(useAll || xl21$`BICS Level 1`[j]==sector){
    x = wday(xl21$`Issue Date`[j], label=TRUE)
    val21[i] = x
    total[count] = x
    count = count + 1
    i = i + 1
  }
}

hist(val18, xlab="Day of week", main="Histogram of 2018 Bonds Issued")
hist(val19, xlab="Day of week", main="Histogram of 2019 Bonds Issued")
hist(val20, xlab="Day of week", main="Histogram of 2020 Bonds Issued")
hist(val21, xlab="Day of week", main="Histogram of 2021 Bonds Issued")
hist(total, xlab="Day of week", main="Histogram of All Bonds Issued")
