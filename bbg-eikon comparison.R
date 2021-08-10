library(readxl)
BBG_Eikon_Comparison <- read_excel("C:/Users/ME/OneDrive/Desktop/Raw data/BBG-Eikon Comparison.xlsx")
View(BBG_Eikon_Comparison)

#intel 5 year
plot(BBG_Eikon_Comparison$`Intel 5Y Eikon`, BBG_Eikon_Comparison$`Intel 5Y BBG`,
     xlab="Refinitiv Eikon", ylab="Bloomberg", main="Intel 5Y Scatterplot")

class(BBG_Eikon_Comparison$`Intel 5Y BBG`)
BBG_Eikon_Comparison$`Intel 5Y BBG` = as.numeric(BBG_Eikon_Comparison$`Intel 5Y BBG`)

i5_unfiltered = BBG_Eikon_Comparison$`Intel 5Y Eikon` - BBG_Eikon_Comparison$`Intel 5Y BBG`
i5_filtered = c()
count = 0
for(x in i5_unfiltered){
  if(!is.na(x)){
    i5_filtered[count] = x
    count = count + 1
  }
}

mean(i5_filtered)
sd(i5_filtered)
t.test(i5_filtered, alternative = "two.sided", mu=0, conf.level=0.95)

plot(i5_filtered, type="o", col="red")
points(i5, col="blue")
abline(h=0)

#intel 30 year
i30_unfiltered = BBG_Eikon_Comparison$`Intel 30Y Eikon` - BBG_Eikon_Comparison$`Intel 30Y BBG`
i30_filtered = c()
count = 0
for(x in i30_unfiltered){
  if(!is.na(x)){
    i30_filtered[count] = x
    count = count + 1
  }
}

mean(i30_filtered)
sd(i30_filtered)
plot(i30_filtered)
t.test(i30_filtered, alternative = "two.sided", mu=0, conf.level=0.95)


#intel 5 year minus first 10 days
i5 = c()
count = 0

for(row in 1:nrow(BBG_Eikon_Comparison)){
  date = BBG_Eikon_Comparison[row, 1]
  x = BBG_Eikon_Comparison$`Intel 5Y Eikon`[row] - BBG_Eikon_Comparison$`Intel 5Y BBG`[row]
  if(date >= 43920 && !is.na(x)){
    i5[count] = x
    count = count + 1
  }
}

plot(i5)
abline(h=0)

mean(i5)
sd(i5)

t.test(i5, alternative = "two.sided", mu=0, conf.level=0.95)

plot(BBG_Eikon_Comparison$`Comcast 5Y Eikon`, BBG_Eikon_Comparison$`Comcast 5Y BBG`)

t.test(BBG_Eikon_Comparison$`Comcast 30Y Eikon`, BBG_Eikon_Comparison$`Comcast 30Y BBG`, alternative = "two.sided", paired = TRUE, var.equal = TRUE, conf.level=0.95)

n5
n30
c5
c30


#correlation
samples = c('Intel 5Y Eikon', 'Intel 30Y Eikon', 'Nike 5Y Eikon', 'Nike 30Y Eikon',
            'Comcast 5Y Eikon', 'Comcast 30Y Eikon', 'Intel 5Y BBG', 'Intel 30Y BBG',
            'Nike 5Y BBG', 'Nike 30Y BBG', 'Comcast 5Y BBG', 'Comcast 30Y BBG')

cor(BBG_Eikon_Comparison$`Intel 5Y Eikon`, BBG_Eikon_Comparison$`Intel 5Y BBG`, use="complete.obs")

#retrieving initial bootstrapping sample
i5_unfiltered = BBG_Eikon_Comparison$`Intel 5Y Eikon` - BBG_Eikon_Comparison$`Intel 5Y BBG`
i5_filtered = c()
count = 0
for(x in i5_unfiltered){
  if(!is.na(x)){
    i5_filtered[count] = x
    count = count + 1
  }
}

#bootstrapping
lambda_hat_storage = c()
B = 1000

for(b in 1:B){
  boot_sample = sample(x=i5_filtered, size=length(i5_filtered), replace=TRUE)
  lambda_hat_storage[b] = mean(boot_sample)
}

quantile(lambda_hat_storage, c(0.025, 0.975))