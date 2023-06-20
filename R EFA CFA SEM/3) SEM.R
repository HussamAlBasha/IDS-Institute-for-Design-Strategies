## Packages to be installed - only needs to be done once.

install.packages("lavaan") 
install.packages("semPlot") 

## Pull the packages out of the library

library(lavaan)
library(semPlot)

## Read in & View the data set (Note the path might change in your case)

dat <- read.csv("https://stats.idre.ucla.edu/wp-content/uploads/2021/02/worland5.csv")

################################################################################################

## Simple regression using lm()

m1a <- lm(read ~ motiv, data=dat)
(fit1a <-summary(m1a))

## Simple regression using lavaan 

m1b <-   '
  # regressions
    read ~ 1 + motiv
  # variance (optional)
    motiv ~~ motiv
'
fit1b <- sem(m1b, data=dat)
summary(fit1b)

################################################################################################

## Multiple Regression

m2 <- '
  # regressions
    read ~ 1 + ppsych + motiv
 # covariance
    ppsych ~~ motiv
'
fit2 <- sem(m2, data=dat)
summary(fit2)

################################################################################################

## Multivariate Regression

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

################################################################################################

## Modeling a path analysis in lavaan

# Regressions
m4a <- '
  read ~ 1 + ppsych + motiv
arith ~ 1 + motiv + read
'
fit4a <- sem(m4a, data=dat)
summary(fit4a)

################################################################################################

##Structural regression with two endogenous variables

m6b <- '
# measurement model
adjust =~ motiv + harm + stabi
risk =~ verbal + ses + ppsych
achieve =~ read + arith + spell
# regressions
adjust ~ risk 
achieve ~ adjust + risk
'
fit6b <- sem(m6b, data=dat)
summary(fit6b, standardized=TRUE, fit.measures=TRUE)

lavaanPlot(model = fit6b,
          node_options = list(shape = "box", fontname = "Helvetica"),
          edge_options = list(color = "grey"),
          coefs = T,
          stand = T,
          covs  = T)

## Plot the model with coefficients

plot_model <- lavaanPlot(model = fit6b, 
                         node_options = list(shape = "box", fontname = "Helvetica"), 
                         edge_options = list(color = "grey"), 
                         coefs = TRUE, 
                         stand = TRUE,
                         covs  = TRUE)

plot_model


