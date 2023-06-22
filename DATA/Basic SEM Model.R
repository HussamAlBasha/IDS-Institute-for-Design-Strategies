## Packages to be installed - only needs to be done once.

install.packages("readxl")     
install.packages("lavaan") 
install.packages("semPlot") 
install.packages("tidySEM") 
install.packages("lavaanPlot")

## Pull the packages out of the library

library(readxl)
library(lavaan)
library(semPlot)
library(tidySEM)
library(lavaanPlot)

## Read in & View the data set (Note the path might change in your case)

dat <- read_excel("C:/Users/fspintern1/Desktop/Internship - Hussam/Intern/DATA/SEM Data.xlsx")
View(dat)



##Structural regression with two endogenous variables

# SD = Social Demographics
# c = Context
# F = Facade Influence

model <- ' # measurement models

           #SA =~ chaotic + uneventful + annoying + monotonous
           #SP =~ pleasant + vibrant + calm + eventful
           #SD =~ age + gender + occupation + education + ethnicity   

           P=~ chaotic + uneventful + annoying + monotonous +
                         pleasant + vibrant + calm + eventful
                         
                  
                  

           AE =~ s_lvl + freq + psychoacoustics  
           C =~ location + weather + space_use + time
           F =~ Geometry_of_the_Facade  + Material_of_the_Facade + Mechanical_equipment
           
         # regressions
           AE ~ F
           C ~ F
           #P ~ SA + SP + SD + C + AE 
           P ~ C + AE 
'

fit <- sem(model, data=dat)
summary(fit, standardized=T, fit.measures=T)

lavaanPlot(model = fit,
          node_options = list(shape = "box", fontname = "Helvetica"),
          edge_options = list(color = "grey"),
          coefs = T,
          stand = T,
          covs  = T)

# Graphics without customization
graph_sem(model = fit)

# Customize Layout
sem_layout <- get_layout("", "risk", "","","achieve","","","adjust", "",
                         "verbal", "ses", "ppsych", "read", "arith", "spell", "motiv", "harm", "stabi", rows = 3)
# Graphic with customization
graph_sem(model = fit, layout = sem_layout)
