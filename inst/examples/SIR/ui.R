
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
                     sliderInput("timesim",
                                 label="Length of simulation (years or generations)",
                                 min = 1,
                                 max = 1000,
                                 value = 200, step=1),
                     sliderInput("S0",
                                 label="Initial number of susceptible individuals",
                                 min = 0,
                                 max = 200,
                                 value = 100, step=1),
                     sliderInput("I0",
                                 label="Initial number of infected individuals",
                                 min = 0,
                                 max = 200,
                                 value = 1, step=1),
                     sliderInput("R0",
                                 label="Initial number of recovered individuals",
                                 min = 0,
                                 max = 200,
                                 value = 0, step=1),
                     sliderInput("beta",
                                 label="Contact rate",
                                 min = 0,
                                 max = 0.1,
                                 value = 0.001, step=0.0001),
                     sliderInput("r",
                                 label="Recovery rate of infected individuals",
                                 min = 0,
                                 max = 0.5,
                                 value = 0.01, step=0.001)),
                   mainPanel(
                     helpText("Some legend"),
                     plotOutput("SIR"),
                     helpText("Here is some text."))
                   ))))
