#Exploratory factor analysis in R Dr Paul Christiansen

## Packages to install- only needs to be done once.

install.packages("psych")        ## PCA/EFA amongst many other things!
install.packages("REdaS")        ## Produces KMO and Bartletts test
install.packages("readxl")       ## Reads excel
install.packages("GPArotation")  ## For Rotation

## Pull packages out of the library

library(psych)
library(readxl)
library(REdaS)
library(GPArotation)

## Read in the data set

ATGC <- read_excel("C:/Users/fspintern1/Desktop/Internship - Hussam/R/test/ATGC_expFA.xlsx")
View(ATGC)        
attach(ATGC)

#############

bart_spher(ATGC) ###### produces Bartletts test of spherecity (you want this to be significant)
KMO(ATGC)        ###### Kaiser-Meyer-Olkin measure, you want to be above .7


############# FA, if you are doing a PCA switch fa to say principal

############# Using Kaisers rule, Eigenvalues > 1 represent valid factors

### set nfactors to n items, in this case there is 9 items so we state nfactors = 9
### oblimin is selected as the rotation although this is default for factor analysis (variamx is default for pca)
### orthagonal roatations availible ="none", "varimax", "quartimax", "bentlerT", "equamax", "varimin", "geominT" "bifactor" 
### oblique roatations availible "Promax", "promax", "oblimin", "simplimax", "bentlerQ, "geominQ" "biquartimin" "cluster" 

fa(ATGC, nfactors = 9, rotate =  "simplimax" )  


fa(ATGC, nfactors = 3, rotate =  "oblimin" )

################### you can produce a figure 

M1<-fa(ATGC, nfactors = 3, rotate =  "oblimin" ) ##save the analysis as the object m1
fa.diagram(M1,main="Title")                      ## produce a figure with the title "" note fa.diagram still works for PCA























