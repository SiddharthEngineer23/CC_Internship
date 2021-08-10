library(readxl)
data <- read_excel("C:/Users/ME/OneDrive/Desktop/Raw data/BBG-Eikon Comparison.xlsx")


ref = data$`Comcast 5Y Eikon`
bbg = data$`Comcast 5Y BBG`

bbg = as.numeric(bbg)

plot(ref, bbg)

unfiltered = ref - bbg
filtered = c()
count = 0
for(x in unfiltered){
  if(!is.na(x)){
    filtered[count] = x
    count = count + 1
  }
}

mean(filtered)
sd(filtered)
t.test(filtered, alternative = "two.sided", mu=0, conf.level=0.95)

plot(filtered, type="l")
abline(h=0)

ref = data$`Comcast 30Y Eikon`
bbg = data$`Comcast 30Y BBG`

bbg = as.numeric(bbg)

plot(ref, bbg)

cor(ref, bbg, use="complete.obs")
