## Packages to be installed - only needs to be done once.

install.packages("readxl")      ### reads excel
install.packages("lavaan") 
install.packages("semPlot") 
install.packages("tidySEM") 

## Pull the packages out of the library

library(readxl)
library(lavaan)
library(semPlot)
library(tidySEM)
#library(dplyr)
#library(ggplot2)

## Read in & View the data set (Note the path might change in your case)

dat <- read_excel("C:/Users/fspintern1/Desktop/Internship - Hussam/Intern/DATA/SEM Data.xlsx")
View(dat)



##Structural regression with two endogenous variables

m6b <- ' # measurement model
           SA =~ motiv + harm + stabi
           SP =~ verbal + ses + ppsych
           SD =~ age + gender + spell
           
         # regressions
           adjust ~ risk  
           achieve ~ adjust + risk '

fit6b <- sem(m6b, data=dat)
summary(fit6b, standardized=T, fit.measures=T)

lavaanPlot(model = fit6b,
          node_options = list(shape = "box", fontname = "Helvetica"),
          edge_options = list(color = "grey"),
          coefs = T,
          stand = T,
          covs  = T)

# Graphics without customization
graph_sem(model = fit6b)

# Customize Layout
sem_layout <- get_layout("", "risk", "","","achieve","","","adjust", "",
                         "verbal", "ses", "ppsych", "read", "arith", "spell", "motiv", "harm", "stabi", rows = 3)
# Graphic with customization
graph_sem(model = fit6b, layout = sem_layout)
