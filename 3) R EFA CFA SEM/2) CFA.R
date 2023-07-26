## Packages to be installed - only needs to be done once.

install.packages("readxl")      ### reads excel
install.packages("lavaan")      ### does LAtent VAriable ANalysis see https://lavaan.ugent.be/
install.packages("lavaanPlot")  ### make plots https://cran.r-project.org/web/packages/lavaanPlot/vignettes/Intro_to_lavaanPlot.html
install.packages("tidySEM") 

## Pull the packages out of the library

library(readxl)
library(lavaan)
library(lavaanPlot)
library(tidySEM)

## Turn off scientific notation

options(scipen = 999)

## Read in & View the data set (Note the path might change in your case)

ATGC_cfa <- read_excel("C:/Users/fspintern1/Desktop/Internship - Hussam/Intern/R EFA CFA SEM/ATGC_expfa.xlsx")

View(ATGC_cfa)        

## Fit the model

model1 <- 'f1 =~ ATGC_1 + ATGC_2 + ATGC_3 
          f2 =~ ATGC_4 + ATGC_5 + ATGC_6
          f3 =~ ATGC_7 + ATGC_8 + ATGC_9'
fit <- cfa(model1, data = ATGC_cfa)  

## Display the results. Standardized = T gives beta values (std.all column), ci = T gives 95% CIs

summary(fit, standardized = T, ci = T, fit.measures = T) 



## Fitting Methods

#### Lavaan fits the model using a maximum likelihood model by default

#### Lavaan allows lots of different estimators

# 1) "GLS" : generalized least squares. For complete data only.
# 2) "WLS" : weighted least squares (sometimes called ADF estimation). For complete data only.
# 3) "DWLS": diagonally weighted least squares
# 4) "ULS" : unweighted least squares

#### fit <- cfa(model,estimator = "ULS", data = ATGC)

#Many estimators have 'robust' variants, meaning that they provide robust standard errors and a scaled test:
#"MLM": maximum likelihood estimation with robust standard errors and a Satorra-Bentler scaled test
#statistic. For complete data only.
#"MLMVS": maximum likelihood estimation with robust standard errors and a mean- and variance adjusted
#test statistic (aka the Satterthwaite approach). For complete data only.
#"MLMV": maximum likelihood estimation with robust standard errors and a mean- and variance adjusted
#test statistic (using a scale-shifted approach). For complete data only.
#"MLF": for maximum likelihood estimation with standard errors based on the first-order derivatives, and
#conventional test statistic. For both complete and incomplete data.
#"MLR": maximum likelihood estimation with robust (Huber-White) standard errors and a scaled test
#statistic that is (asymptotically) equal to the Yuan-Bentler test statistic. For both complete and incomplete data

########################################################################################

# Modification indices tell you if your model can be improved by using covariances. 
# Modification index is the chi squared reduction adding a covariance. 
# Covariance should only be added were logical.  


modindices(fit, minimum.value = 10, sort = TRUE)


############# ATGC5 and ATGC6 are flagged up by the MI

model_COV <- 'f1 =~ ATGC_1 + ATGC_2 + ATGC_3 
              f2 =~ ATGC_4 + ATGC_5 + ATGC_6
              f3 =~ ATGC_7 + ATGC_8 + ATGC_9
              ATGC_5 ~~ ATGC_6'
          
fitcov <- cfa(model_COV, data = ATGC_cfa)
summary(fitcov, ci=TRUE, standardized=TRUE, fit.measures=TRUE)
modindices(fitcov, minimum.value = 10, sort = TRUE)

## Plot

## I have asked for coefficients
## coefs=T and for these to be standardised stand =T.
## if you want covariances between factors add ,covs=T, 

lavaanPlot(model = fit,
           node_options = list(shape = "box", fontname = "Helvetica"),
           edge_options = list(color = "grey"),
           coefs = T,
           stand = T,
           sig = .05)

lavaanPlot(model = fit,
           node_options = list(shape = "box", fontname = "Helvetica"),
           edge_options = list(color = "grey"),
           coefs = T,
           stand = T,
           covs  = T)

# Graphics without customization
graph_sem(model = fit)

# Customize Layout
cfa_layout <- get_layout("", "f3", "","","f1","","","f2", "",
                         "ATGC_7", "ATGC_8", "ATGC_9", "ATGC_1", "ATGC_2", "ATGC_3", "ATGC_4", "ATGC_5", "ATGC_6", rows = 2)

# Graphic with customization
graph_sem(model = fit, layout = cfa_layout)
