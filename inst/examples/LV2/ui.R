
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
                     radioButtons("a12",
                                  label="Effect of species 2 on species 1",
                                  c(0.02,0.1,0.5,0.3),
                                  inline = TRUE),
                     radioButtons("a21",
                                 label="Effect of species 1 on species 2",
                                 c(0.5,0.22,0.09,0.3),
                                 inline = TRUE),
                     actionButton("go", "Run")),
                   mainPanel(
                     plotOutput("LV"))
                   ))))
