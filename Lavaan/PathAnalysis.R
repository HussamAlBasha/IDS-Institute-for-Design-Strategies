# Load the library
library(lavaan)

# Load the data
dat <- read.csv("https://stats.idre.ucla.edu/wp-content/uploads/2021/02/worland5.csv")

# Regressions
m4a <- '
  read ~ 1 + ppsych + motiv
arith ~ 1 + motiv + read
'
fit4a <- sem(m4a, data=dat)
summary(fit4a)
