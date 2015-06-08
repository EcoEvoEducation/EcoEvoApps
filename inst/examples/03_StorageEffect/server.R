# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com


library(shiny)
library(ggplot2)
library(mvtnorm)
# source("annualPlantStorage_Functions.R")

annPlantStorage <- function(params, N1, N2){
  s1 <- params$s1
  s2 <- params$s2
  g1 <- params$g1
  g2 <- params$g2
  lambda1 <- params$lambda1
  lambda2 <- params$lambda2
  alpha11 <- params$alpha11
  alpha12 <- params$alpha12
  alpha22 <- params$alpha22
  alpha21 <- params$alpha21
  
  newN1 <- s1*(1-g1)*N1 + ((lambda1*g1*N1) / (1 + alpha11*g1*N1 + alpha12*g2*N2))
  newN2 <- s2*(1-g2)*N2 + ((lambda2*g2*N2) / (1 + alpha21*g1*N1 + alpha22*g2*N2))
  
  newNs <- c(newN1, newN2)
  return(newNs)
}

####
#### Germination rate time series function
####
getG <- function(sigE, rho, nTime){
  varcov <- matrix(c(sigE, rho*sigE, rho*sigE, sigE), 2, 2)
  e <- rmvnorm(n = nTime, mean = c(0,0), sigma = varcov)
  g <- exp(e) / (1+exp(e))
  return(g)
}


shinyServer(function(input, output, session) {
  output$StorageEffect <- renderPlot({
    s1 <- input$s1
    s2 <- input$s2
    lambda1 <- input$lambda1
    lambda2 <- input$lambda2
    alpha11 <- input$alpha11
    alpha12 <- input$alpha12
    alpha21 <- input$alpha21
    alpha22 <- input$alpha22
    sigE <- input$sigE
    rho <- input$rho
    timeSim <- input$timeSim
    initialN <- 100
    
    ####
    #### Get germination vectors
    ####
    gVec <- getG(sigE = sigE, rho = rho, nTime = timeSim)
    gVec1 <- gVec[,1]
    gVec2 <- gVec[,2]
    
    
    ####
    #### Run model
    ####
    Nsave <- matrix(nrow=timeSim, ncol=2)
    Nsave[1,] <- initialN
    
    for(t in 2:timeSim){
      N1 <- Nsave[t-1,1]
      N2 <- Nsave[t-1,2]
      params <- list(s1 = s1,
                     s2 = s2,
                     lambda1 = lambda1,
                     lambda2 = lambda2,
                     alpha11 = alpha11,
                     alpha12 = alpha12,
                     alpha21 = alpha21,
                     alpha22 = alpha22,
                     g1 = gVec1[t],
                     g2 = gVec2[t])
      
      newN <- annPlantStorage(params = params, N1 = N1, N2 = N2)
      Nsave[t,1] <- newN[1]
      Nsave[t,2] <- newN[2]
    }
    
    ####
    #### Plot results
    ####
#     matplot(seq(1,timeSim,1), Nsave, type="l")
    plotD <- data.frame(Abundance = c(Nsave[,1], Nsave[,2]),
                        Species = c(rep("A",timeSim), rep("B", timeSim)),
                        Time = seq(1,timeSim,1))
    
    theplot <- ggplot(plotD, aes(x=Time, y=Abundance, color=Species))+
      geom_line(size=2)+
      scale_color_manual(values=c("grey25", "darkorange"))+
      ylab("Seed Abundance")+
      theme_bw()

    print(theplot)
  })
})