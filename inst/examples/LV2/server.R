# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
# library(ggthemes)
my_theme <- theme_bw()+
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_line(color="white"),
        panel.background   = element_rect(fill = "#EFEFEF"),
        axis.text          = element_text(size=14, color="grey35", family = "Arial Narrow"),
        axis.title         = element_text(size=16, family = "Arial Narrow", face = "bold"),
        panel.border       = element_blank(),
        axis.line.x        = element_line(color="black"),
        axis.line.y        = element_line(color="black"),
        strip.background   = element_blank(),
        strip.text         = element_text(size=14, color="grey35", family = "Arial Narrow"),
        legend.title       = element_text(size=14, family = "Arial Narrow"),
        legend.text        = element_text(size=14, color="grey35", family = "Arial Narrow"))


## Continuous model
run_lv_chesson <- function(initial_pop_size = 1,
                           growth_rates = rep(0.1,2),
                           competition_matrix,
                           generations = 500){
  N     <- matrix(nrow = generations, ncol = 2)
  N[1,] <- initial_pop_size
  r     <- growth_rates
  A     <- competition_matrix
  
  for(t in 2:generations){
    N[t,1] <- N[t-1,1] + (r[1]*N[t-1,1])*(1 - A[1,1]*N[t-1,1] - A[1,2]*N[t-1,2])
    N[t,2] <- N[t-1,2] + (r[2]*N[t-1,2])*(1 - A[2,1]*N[t-1,1] - A[2,2]*N[t-1,2])
  }
  return(N)
}

shinyServer(function(input, output, session) {
  A <- eventReactive(input$go, {
    matrix(as.numeric(c(0.1,input$a12,
                        input$a21,0.2)), nrow = 2, ncol = 2, byrow = TRUE)
  })
  
  output$LV <- renderPlot({
    #A <- matrix(as.numeric(c(0.1, input$a12, input$a21, 0.2)), ncol=2, nrow=2)
    model <- run_lv_chesson(competition_matrix=A()) * 10
    mod.df <- as.data.frame(model)
    mod.df$Time <- 1:nrow(mod.df)
    colnames(mod.df) <- c("N1", "N2", "Time")
    df.m <- melt (mod.df, id.vars="Time")
    myCols <- c("#277BA8", "#7ABBBD")
    ymax <- max(df.m$value)+2
    theplot <- ggplot(data=df.m, aes(x=Time, y=value, color=variable)) +
      geom_line(size=2) +
      xlab("Time") +
      ylab("Population size (abundance)") +
      scale_color_viridis(discrete=TRUE, end=0.6) +
      scale_y_continuous(limits=c(0,ymax)) +
      ggtitle("Population Time Series")+
      my_theme
      
      model <- run_lv_chesson(competition_matrix=A(), initial_pop_size = c(1e-1,10)) * 10
      mod.df <- as.data.frame(model)
      mod.df$Time <- 1:nrow(mod.df)
      colnames(mod.df) <- c("N1", "N2", "Time")
      df.m <- melt (mod.df, id.vars="Time")
      myCols <- c("#277BA8", "#7ABBBD")
      ymax <- max(df.m$value)+2
      theplot2 <- ggplot(data=df.m, aes(x=Time, y=value, color=variable)) +
        geom_line(size=2) +
        xlab("Time") +
        ylab("Population size") +
        scale_color_viridis(discrete=TRUE, end=0.6) +
        scale_y_continuous(limits=c(0,ymax)) +
        ggtitle("Species N1 Invasion")+
        guides(color=FALSE)+
      my_theme
      
      model <- run_lv_chesson(competition_matrix=A(), initial_pop_size = c(10,1e-1)) * 10
      mod.df <- as.data.frame(model)
      mod.df$Time <- 1:nrow(mod.df)
      colnames(mod.df) <- c("N1", "N2", "Time")
      df.m <- melt (mod.df, id.vars="Time")
      myCols <- c("#277BA8", "#7ABBBD")
      ymax <- max(df.m$value)+2
      theplot3 <- ggplot(data=df.m, aes(x=Time, y=value, color=variable)) +
        geom_line(size=2) +
        xlab("Time") +
        ylab("Population size") +
        scale_color_viridis(discrete=TRUE, end=0.6) +
        scale_y_continuous(limits=c(0,ymax)) +
        ggtitle("Species N2 Invasion")+
        guides(color=FALSE)+
        my_theme
    mylayout <- rbind(c(1,1),
                      c(2,3))
    print(grid.arrange(theplot, theplot2, theplot3, layout_matrix=mylayout))
  })
})