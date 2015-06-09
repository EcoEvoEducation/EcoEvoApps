# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com

## Continuous model
updateLV <- function(t, N, parms){
  with(as.list(c(N, parms)), {
    dN1dt <- r[1]*N1*((K[1]-N1-a[1]*N2)/K[1])
    dN2dt <- r[2]*N2*((K[2]-N2-a[2]*N1)/K[2])
    list(c(dN1dt, dN2dt)) #output
  })
}

shinyServer(function(input, output, session) {
  output$LV <- renderPlot({
    parms <- list(
      r = c(input$r1, input$r2),
      K = c(input$K1, input$K2),
      a = c(input$a21, input$a12)
    )
    N <- c(N1=input$N10,N2=input$N20)
    simtime <- input$timesim
    odetime <- seq(1,simtime,by=0.1)
    model <- as.data.frame(ode(y = N, times = odetime,
                               func = updateLV, parms = parms))
    
    mod.df <- as.data.frame(model)
    colnames(mod.df) <- c("Time", "N1", "N2")
    df.m <- melt (mod.df, id.vars="Time")
    myCols <- c("#277BA8", "#7ABBBD")
    theplot <- ggplot(data=df.m, aes(x=Time, y=value, color=variable)) +
      geom_line(size=1.5) +
      xlab("Time") +
      ylab("Population size (abundance)") +
      theme_bw() +
      theme(legend.position = c(0.75,0.85))+
      scale_color_manual(values=myCols, name="")
    
    statespace <- ggplot(data=mod.df, aes(x=log(N1), y=log(N2), color=Time))+
      geom_point(size=3, alpha=0.5)+
      theme_bw()+
      scale_colour_gradientn(colours = rainbow(7))
    
    comb <- grid.arrange(theplot, statespace, ncol=1, nrow=2)
    print(comb)
  })
})

