library(lavaan)
library(semPlot)
library(tidySEM)
library(lavaanPlot)
library(readxl)


dat <- read_excel("C:/Users/fspintern1/Desktop/Internship - Hussam/Collected Data/AllTest_2023-07-4.xlsx")
#View(dat)

model1 <- ' # Regressions
           LAeq ~ Distance 
           N_avg ~ Distance
           S_L_avg ~ Distance
           R_avg  ~ Distance
           
           # Set all covariances to 0
           LAeq ~~ 0*N_avg
           LAeq ~~ 0*S_L_avg
           LAeq ~~ 0*R_avg
           N_avg ~~ 0*S_L_avg
           N_avg ~~ 0*R_avg
           S_L_avg ~~ 0*R_avg
            '

fit1 <- sem(model1, data=dat, group = "Channel")
summary(fit1)

# Customize Layout
sem_layout <- get_layout("LAeq", "", "",
                         "N_avg", "", "",
                         "", "", "Distance",
                         "S_L_avg", "", "",
                         "R_avg", "", "",
                         rows = 5)
# Graphic with customization
graph_sem(model = fit1, layout = sem_layout, digits = 5)

