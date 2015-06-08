# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com


sir <- function(S0, I0, R0,
                beta, r, simtime){
  S <- I <- R <- numeric(simtime)
  S[1] <- S0
  I[1] <- I0
  R[1] <- R0
  for(t in 2:simtime){
    dSdt <- -beta*S[t-1]*I[t-1]
    dIdt <- beta*S[t-1]*I[t-1] - r*I[t-1]
    dRdt <- r*I[t-1]
    
    S[t] <- S[t-1] + dSdt
    I[t] <- I[t-1] + dIdt
    R[t] <- R[t-1] + dRdt
  }
  outs <- cbind(S,I,R)
  return(outs)
}

shinyServer(function(input, output, session) {
  output$SIR <- renderPlot({
    S0 <- input$S0
    I0 <- input$I0
    R0 <- input$R0
    transmission <- input$tau
    infectiousness <- input$eta
    beta <- transmission*infectiousness
    r <- input$r
    
    simtime <- input$time
    
    model <- sir(So, Io, Ro,
                 beta, r, simtime)
    
    mod.df <- as.data.frame(model)
    mod.df$Time <- seq(1,time,1)
    colnames(mod.df) <- c("Susceptible", "Infected", "Recovered", "Time")
    mod.df <- subset(mod.df)
    require(reshape2)
    df.m <- melt (mod.df, id.vars="Time")
    
    theplot <- ggplot(data=df.m, aes(x=Time, y=(value/500*100), linetype=variable)) +
      geom_line(size=1.5) +
      xlab("Time Since Initial Infection (years)") +
      ylab("Percent of Population (%)") +
      theme_bw() +
      theme(legend.position = c(0.75,0.75))
    print(theplot)
  })
})

