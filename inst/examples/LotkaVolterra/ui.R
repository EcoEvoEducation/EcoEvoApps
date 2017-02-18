
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
                     sliderInput("a11",
                                 label="Effect of species 1 on species 1",
                                 min = 0,
                                 max = 1,
                                 value = 0.01, step=0.01),
                     sliderInput("a12",
                                 label="Effect of species 2 on species 1",
                                 min = 0,
                                 max = 1,
                                 value = 0.01, step=0.01),
                     sliderInput("a21",
                                 label="Effect of species 1 on species 2",
                                 min = 0,
                                 max = 1,
                                 value = 0.01, step=0.01),
                     sliderInput("a22",
                                 label="Effect of species 2 on species 2",
                                 min = 0,
                                 max = 1,
                                 value = 0.01, step=0.01)),
                   mainPanel(
                     plotOutput("LV"))
                   ))))
