## Packages to be installed - only needs to be done once.

install.packages("readxl")     
install.packages("lavaan") 
install.packages("semPlot") 
install.packages("tidySEM") 
install.packages("lavaanPlot")
install.packages("paran")

## Pull the packages out of the library

library(readxl)
library(lavaan)
library(semPlot)
library(tidySEM)
library(lavaanPlot)
library(psych)
library(REdaS)
library(GPArotation)
library(paran)

## Read in & View the data set (Note the path might change in your case)

dat <- read_excel("C:/Users/fspintern1/Desktop/Internship - Hussam/Intern/DATA/SEM Data.xlsx")
View(dat)

##Structural regression with two endogenous variables

model <- ' # measurement models

           AE =~ dBA + Freq + Psychoacoustics  
           C  =~ Enclosed + Sky_Condition + Human_Density
           F  =~ Geometry_of_the_Facade  + Material_of_the_Facade + Mechanical_Equipment
           
           #SA =~ uneventful + eventful + pleasant + vibrant
           #SP =~ calm + chaotic + annoying + monotonous  
           P  =~ uneventful + eventful + pleasant + vibrant + calm + chaotic + annoying + monotonous 

         # regressions
           AE ~ F
           C  ~ F
           P  ~ C + AE 
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
sem_layout <- get_layout("Material_of_the_Facade", "Geometry_of_the_Facade","","", "Human_Density","Sky_Condition",
                         "Mechanical_Equipment", "F","","", "C","Enclosed",
                         "", "", "", "pleasant", "","eventful",
                         "dBA", "AE","","", "P","calm",
                         "Freq", "Psychoacoustics","","uneventful", "","vibrant",
                         "", "",                   "","chaotic", "annoying","monotonous",
                          rows = 6)
# Graphic with customization
graph_sem(model = fit, layout = sem_layout)


