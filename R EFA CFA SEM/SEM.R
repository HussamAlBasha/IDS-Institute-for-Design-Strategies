
install.packages("semPlot") 

library(lavaan)
library(semPlot)
dat <- read.csv("https://stats.idre.ucla.edu/wp-content/uploads/2021/02/worland5.csv")


#model6c (manual specification) 
m6cc <- '
  # measurement model
    adjust =~ motiv + harm + stabi
    risk =~ verbal + ses + ppsych
  #single indicator factor
    readf =~ 1*read
  #variance of observed variable to 0
    read ~~ 0*read
  # regressions
    adjust ~ risk 
    readf ~ adjust + risk
'
fit6cc <- sem(m6cc, data=dat)
summary(fit6cc)

lavaanPlot(model = fit6cc, node_options = list(shape = "box", fontname = "Helvetica"), edge_options = list(color = "grey"),
           coefs = T, stand=T, covs = T)

# Plot the model with coefficients
plot_model <- lavaanPlot(model = fit6cc, 
                         node_options = list(shape = "box", fontname = "Helvetica"), 
                         edge_options = list(color = "grey"), 
                         coefs = TRUE, 
                         stand = TRUE,
                         covs  = TRUE)

plot_model


