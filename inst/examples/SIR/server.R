# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com

## Continuous model
updateSIR <- function(t, SIR, parms){
  with(as.list(c(SIR, parms)), {
    dSdt <- -beta*S*I
    dIdt <- beta*S*I - r*I
    dRdt <- r*I
    list(c(dSdt, dIdt, dRdt)) #output
  })
}

shinyServer(function(input, output, session) {
  output$SIR <- renderPlot({
    beta <- input$tau*input$eta
    parms <- list(
      beta = beta,
      r = input$r
    )
    SIR <- c(S=100,I=1,R=0)
    simtime <- 100
    odetime <- seq(1,simtime,by=1)
    totpop <- sum(SIR)
    model <- as.data.frame(ode(y = SIR, times = odetime,
                               func = updateSIR, parms = parms))
    
    mod.df <- as.data.frame(model)
    colnames(mod.df) <- c("Time", "Susceptible", "Infected", "Recovered")
    df.m <- melt (mod.df, id.vars="Time")
    df.m$value <- df.m$value/totpop*100
    myCols <- c("#0A4D5B", "#139AB8", "#39B181")
    
    my_theme <- theme_bw()+
      theme(panel.grid.major.x = element_blank(), 
            panel.grid.minor.x = element_blank(),
            panel.grid.minor.y = element_blank(),
            panel.grid.major.y = element_line(linetype=1, color="white"),
            panel.background = element_rect(fill = "#EFEFEF"),
            axis.text=element_text(size=16, color="grey35", family = "Arial Narrow"),
            axis.title=element_text(size=18, family = "Arial Narrow", face = "bold"),
            legend.text=element_text(size=16, color="grey35", family = "Arial Narrow"),
            panel.border = element_blank(),
            axis.line.x = element_line(color="black"),
            axis.line.y = element_line(color="black"))
    
    theplot <- ggplot(data=df.m, aes(x=Time, y=value, color=variable)) +
      geom_line(size=1.5) +
      xlab("Time Since Initial Infection (years)") +
      ylab("Percent of Population (%)") +
      scale_color_manual(values=myCols, name="")+
      scale_y_continuous(limits=c(0,100))+
      my_theme
    print(theplot)
  })
})

