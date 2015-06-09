
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(shiny)
library(markdown)

shinyUI(navbarPage("Lotka-Volterra",tabPanel("Species Competition Model",
                 sidebarLayout(
                   sidebarPanel(
                     sliderInput("a21",
                                 label="Effect of species 2 on species 1",
                                 min = 0,
                                 max = 2,
                                 value = 1, step=0.1),
                     sliderInput("a12",
                                 label="Effect of species 1 on species 2",
                                 min = 0,
                                 max = 2,
                                 value = 1, step=0.1),
                     sliderInput("r1",
                                 label="Species' 1 growth rate",
                                 min = 0,
                                 max = 3,
                                 value = 1.2, step=0.1),
                     sliderInput("r2",
                                 label="Species' 2 growth rate",
                                 min = 0,
                                 max = 3,
                                 value = 1.2, step=0.1),
                     sliderInput("K1",
                                 label="Species' 1 carrying capacity",
                                 min = 0,
                                 max = 1000,
                                 value = 500, step=1),
                     sliderInput("K2",
                                 label="Species' 2 carrying capacity",
                                 min = 0,
                                 max = 1000,
                                 value = 500, step=1),
                     sliderInput("timesim",
                                 label="Length of simulation (years or generations)",
                                 min = 1,
                                 max = 200,
                                 value = 40, step=1),
                     sliderInput("N10",
                                 label="Initial number of susceptible individuals",
                                 min = 0,
                                 max = 1000,
                                 value = 100, step=1),
                     sliderInput("N20",
                                 label="Initial number of susceptible individuals",
                                 min = 0,
                                 max = 1000,
                                 value = 100, step=1)),
                   mainPanel(
                     plotOutput("LV"))
                   ))))
