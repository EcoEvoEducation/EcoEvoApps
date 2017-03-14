
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
                                  c(0.1,0.3,0.6,0.8),
                                  inline = TRUE),
                     radioButtons("a21",
                                 label="Effect of species 1 on species 2",
                                 c(0.5,0.9,0.4,0.01),
                                 inline = TRUE),
                     actionButton("go", "Run")),
                   mainPanel(
                     plotOutput("LV"))
                   ))))
