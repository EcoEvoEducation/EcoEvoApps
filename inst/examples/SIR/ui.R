
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(shiny)
library(markdown)

shinyUI(navbarPage("SIR",tabPanel("Disease Transmission Model",
                 sidebarLayout(
                   sidebarPanel(
                     sliderInput("tau",
                                 label="Contact rate",
                                 min = 0,
                                 max = 0.1,
                                 value = 0.03, step=0.001),
                     sliderInput("eta",
                                 label="Infectiousness",
                                 min = 0,
                                 max = 0.1,
                                 value = 0.06, step=0.001),
                     sliderInput("r",
                                 label="Recovery rate of infected individuals",
                                 min = 0,
                                 max = 0.5,
                                 value = 0.1, step=0.01)),
                   mainPanel(
                     plotOutput("SIR"))
                   ))))
