# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com

my_theme <- theme_bw()+
  theme(panel.grid.major.x = element_blank(), 
        panel.grid.minor.x = element_blank(),
        panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_line(color="white"),
        panel.background   = element_rect(fill = "#EFEFEF"),
        axis.text          = element_text(size=10, color="grey35", family = "Arial Narrow"),
        axis.title         = element_text(size=12, family = "Arial Narrow", face = "bold"),
        panel.border       = element_blank(),
        axis.line.x        = element_line(color="black"),
        axis.line.y        = element_line(color="black"),
        strip.background   = element_blank(),
        strip.text         = element_text(size=10, color="grey35", family = "Arial Narrow"),
        legend.title       = element_text(size=10, family = "Arial Narrow"),
        legend.text        = element_text(size=8, color="grey35", family = "Arial Narrow"))


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
    ymax <- max(df.m$value)+20
    theplot <- ggplot(data=df.m, aes(x=Time, y=value, color=variable)) +
      geom_line(size=2) +
      xlab("Time") +
      ylab("Population size (abundance)") +
      scale_color_viridis(discrete=TRUE, end=0.6) +
      scale_y_continuous(limits=c(0,ymax)) +
      my_theme 

    print(theplot)
  })
})

