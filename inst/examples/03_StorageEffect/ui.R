
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(shiny)
library(markdown)

shinyUI(navbarPage("Chesson Tutorial",
                   tabPanel("The Storage Effect",
                            sidebarLayout(
                              sidebarPanel(
                                sliderInput("timeSim",
                                            label="Length of simulation (years or generations)",
                                            min = 10,
                                            max = 1000,
                                            value = 100, step=1),
                                sliderInput("s1",
                                            label="Species 1 survival of seeds in seedbank",
                                            min = 0,
                                            max = 1,
                                            value = 0.5, step=0.1),
                                sliderInput("s2",
                                            label="Species 2 survival of seeds in seedbank",
                                            min = 0,
                                            max = 1,
                                            value = 0.5, step=0.1),
                                sliderInput("lambda1",
                                            label="Species 1 per capita fecundity",
                                            min = 10,
                                            max = 100,
                                            value = 50, step=5),
                                sliderInput("lambda2",
                                            label="Species 2 per capita fecundity",
                                            min = 10,
                                            max = 100,
                                            value = 50, step=5),
                                sliderInput("alpha11",
                                            label="Effect of species 1 on itself (intraspecific competition)",
                                            min = 0,
                                            max = 4,
                                            value = 1, step=0.1),
                                sliderInput("alpha12",
                                            label="Effect of species 2 on species 1 (interspecific competition)",
                                            min = 0,
                                            max = 4,
                                            value = 1, step=0.1),
                                sliderInput("alpha22",
                                            label="Effect of species 2 on itself (intraspecific competition)",
                                            min = 0,
                                            max = 4,
                                            value = 1, step=0.1),
                                sliderInput("alpha21",
                                            label="Effect of species 1 on species 2 (interspecific competition)",
                                            min = 0,
                                            max = 4,
                                            value = 1, step=0.1),
                                sliderInput("sigE",
                                            label="Environmental variation",
                                            min = 0,
                                            max = 10,
                                            value = 1, step=0.1),
                                sliderInput("rho",
                                            label="Correlation between species' germination rates",
                                            min = -1,
                                            max = 1,
                                            value = 0, step=0.1)),
                              # Show a plot of the generated distribution
                              mainPanel(
                                helpText("Grey line is Species 1 (A), orange is Species 2 (B)"),
                                plotOutput("StorageEffect"),
                                helpText("Here is some text."))
                   ))))
