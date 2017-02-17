
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
                                 value = 1, step=0.1)),
                   mainPanel(
                     plotOutput("LV"))
                   ))))
