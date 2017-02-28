
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
                     radioButtons("a11",
                                 label="Effect of species 1 on species 1",
                                 c(0.1,0.2,0.3,0.4,0.5)),
                     radioButtons("a12",
                                  label="Effect of species 2 on species 1",
                                  c(0.1,0.2,0.3,0.4,0.5)),
                     radioButtons("a22",
                                  label="Effect of species 2 on species 2",
                                  c(0.1,0.2,0.3,0.4,0.5)),
                     radioButtons("a21",
                                 label="Effect of species 1 on species 2",
                                 c(0.1,0.2,0.3,0.4,0.5))),
                   mainPanel(
                     plotOutput("LV"))
                   ))))
