## Packages to install- only needs to be done once.

install.packages("psych")        ## PCA/EFA among many other things!
install.packages("REdaS")        ## Produces KMO and Bartletts test
install.packages("readxl")       ## Reads excel
install.packages("GPArotation")  ## For Rotation
install.packages("paran")        ## For Parallel Analysis

## Pull packages out of the library

library(psych)
library(readxl)
library(REdaS)
library(GPArotation)
library(paran)

## Load & View the Data

ATGC <- read_excel("C:/Users/fspintern1/Desktop/Internship - Hussam/R/test/ATGC_expFA.xlsx")
View(ATGC)        
attach(ATGC)

## When cfa=F, the paran() function performs a principal component parallel analysis (PCA)

paran(ATGC, cfa=T)

## Optional Plotting

paran(ATGC, cfa=TRUE,
      graph=TRUE, color=TRUE, col=c("black", "red", "blue"))

## According to parallel analysis, we need 3 factors

fa(ATGC, nfactors = 3, rotate =  "oblimin" )

## Save the analysis as the object m1

M1<-fa(ATGC, nfactors = 3, rotate =  "oblimin" ) 

## Produce a figure with a Title. Note: fa.diagram still works for PCA

fa.diagram(M1,main="Title")                      

