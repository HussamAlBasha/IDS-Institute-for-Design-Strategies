# Load the library
library(lavaan)

# Load the data
dat <- read.csv("https://stats.idre.ucla.edu/wp-content/uploads/2021/02/worland5.csv")

# Sample Variance-Covariance Matrix
cov(dat)

#simple regression using lm()
m1a <- lm(read ~ motiv, data=dat)
(fit1a <-summary(m1a))

#simple regression using lavaan 
m1b <-   '
  # regressions
    read ~ 1 + motiv
  # variance (optional)
    motiv ~~ motiv
'
fit1b <- sem(m1b, data=dat)
summary(fit1b)