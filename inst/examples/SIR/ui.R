
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(shiny)
library(markdown)

shinyUI(tabPanel("SIR Disease Transition Model",
                            sidebarLayout(
                              sidebarPanel(
                                sliderInput("timesim",
                                            label="Length of simulation (years or generations)",
                                            min = 10,
                                            max = 1000,
                                            value = 100, step=1),
                                sliderInput("S0",
                                            label="Initial number of susceptible individuals",
                                            min = 0,
                                            max = 1000,
                                            value = 500, step=1),
                                sliderInput("I0",
                                            label="Initial number of infected individuals",
                                            min = 0,
                                            max = 1000,
                                            value = 0, step=1),
                                sliderInput("R0",
                                            label="Initial number of recovered individuals",
                                            min = 0,
                                            max = 1000,
                                            value = 0, step=1),
                                sliderInput("tau",
                                            label="Transmission rate",
                                            min = 0,
                                            max = 1,
                                            value = 0.5, step=0.01),
                                sliderInput("eta",
                                            label="Infectiousness",
                                            min = 0,
                                            max = 1,
                                            value = 0.5, step=0.01),
                                sliderInput("r",
                                            label="Recovery rate of infected individuals",
                                            min = 0,
                                            max = 1,
                                            value = 0.5, step=0.01),
                              # Show a plot of the outcome
                              mainPanel(
                                helpText("Some legend"),
                                plotOutput("SIR"),
                                helpText("Here is some text."))
                   )))
