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
    SIR <- c(S=input$S0,I=input$I0,R=input$R0)
    simtime <- input$timesim
    odetime <- seq(1,simtime,by=1)
    totpop <- sum(SIR)
    model <- as.data.frame(ode(y = SIR, times = odetime,
                               func = updateSIR, parms = parms))
    
    mod.df <- as.data.frame(model)
    colnames(mod.df) <- c("Time", "Susceptible", "Infected", "Recovered")
    df.m <- melt (mod.df, id.vars="Time")
    df.m$value <- df.m$value/totpop*100
    myCols <- c("#277BA8", "#7ABBBD", "#AED77A")
    theplot <- ggplot(data=df.m, aes(x=Time, y=value, color=variable)) +
      geom_line(size=1.5) +
      xlab("Time Since Initial Infection (years)") +
      ylab("Percent of Population (%)") +
      theme_bw() +
      theme(legend.position = c(0.75,0.85))+
      scale_color_manual(values=myCols, name="")
    print(theplot)
  })
})

