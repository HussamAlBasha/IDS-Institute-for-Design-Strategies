# Load the library
library(lavaan)

# Load the data
dat <- read.csv("https://stats.idre.ucla.edu/wp-content/uploads/2021/02/worland5.csv")

# Multivariate Regression
m3a <- '
  # regressions
read ~ 1 + ppsych + motiv
arith ~ 1 + motiv
'
fit3a <- sem(m3a, data=dat)
summary(fit3a)

m3d <- '
  # regressions
    read ~ 1 + ppsych + motiv
    arith ~ 1 + motiv
  # covariance
    read ~~ 0*arith 
'
fit3d <- sem(m3d, data=dat)
summary(fit3d)


m3e <- '
  # regressions
    read ~ 1 + ppsych + motiv
    arith ~ 1 + ppsych + motiv
'
fit3e <- sem(m3e, data=dat)
summary(fit3e)