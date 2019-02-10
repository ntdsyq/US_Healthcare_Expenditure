# library(shiny)
# library(shinydashboard)
# library(tidyverse)
# library(DT)
# library(leaflet)
# library(googleVis)
# library(maps)
# library(geojsonio)
# library(RColorBrewer)
# library(stats)
# library(shinyWidgets)
# library(shinythemes)

 
shinyUI(
    fluidPage(
    theme = "custom.css",
    dashboardPage(
    #skin = "blue",
    dashboardHeader(title = "US Personal Healthcare Spend"),
    dashboardSidebar(
            sidebarMenu(
                menuItem("Introduction", tabName = "intro", icon = icon("file-alt")),
                menuItem("National Trends", icon = icon("line-chart"), 
                         menuSubItem("By Spend Category", tabName = "nat_spend"), 
                         menuSubItem("By Source of funding", tabName = "nat_fund")),
                menuItem("Across States", tabName = "map", icon = icon("map"))
            )
    ),
    dashboardBody(
        tabItems(
            tabItem( tabName = "intro",
                     fluidRow(
                         column( width = 12, box( title = "Introduction", solidHeader = T , status = "info",
                                                  tags$h4("Some background info"),
                                                  br(),
                                                  tags$p("first paragraph"),
                                                  br(),
                                                  tags$p("second paragraph")) )
                     )
            ),
            tabItem( tabName = "nat_spend",
                     
                     fluidRow(
                         
                         column( width = 4 , 
                                 
                                 box( status = "warning", width = NULL, height = 100,
                                      sliderInput(inputId = "time1", "Select Time Horizon", 
                                                  min = 1960, max = 2017, step = 1, value = c(1960, 2017)) ) 
                                 
                         ) ,
                         column( 
                                 width = 4,
                                 
                                 box( status = "warning", width = NULL, height = 100,
                                      pickerInput(
                                          inputId = "cat1",
                                          label = "Select categories to plot",
                                          choices = nat1_cat,
                                          multiple = TRUE,
                                          selected = nat1_default_cat,
                                          options =  list(
                                              "max-options" = 11,
                                              "max-options-text" = "No more!")
                                      )
                                 ) 
                          ),
                         column(
                             width = 4,
                             
                             box( status = "warning", width = NULL, height = 100,
                                  selectizeInput( inputId = "metric1", 
                                                  label = "Select a metric",
                                                  choices = unique(nat1_df$metric),
                                                  selected = unique(nat1_df$metric)[1])
                                  ) 
                         )
                         
                     ),
                     
                     fluidRow(
                         column( width = 9,
                                 box( title = "National Trends by Spend Category", solidHeader = T, 
                                      status = "info", width = NULL, height = 600, 
                                      htmlOutput("nat1_gvis") 
                                      # plotOutput("nat1_gglot")
                                 ) ),
                         
                         # to add compounded annual growth rate for the selected time period
                         column( width = 3,
                                 box( title = "National Trends by Spend Category", solidHeader = T, 
                                      status = "info", width = NULL, height = 600 
                                    
                                 ) )
                         
                     )
            ),
            tabItem( tabName = "nat_fund",
                     fluidRow(
                         column( width = 12, box( title = "National Trends by Source of Funding", solidHeader = T, status = "info"  ) )
                     )
            ),
            tabItem(tabName = "map",
                    
                    fluidRow(
                        
                        column( width = 4 , 
                                
                                box( status = "warning", width = NULL, height = 100,
                                     selectizeInput(inputId = "year2", "Select Year", 
                                                 choices = sort(unique(st_df$year)), selected = max(unique(st_df$year)) ) 
                                     ) 
                        ),
                        
                        column( 
                            width = 4,
                            
                            box( status = "warning", width = NULL, height = 100,
                                 selectizeInput(
                                     inputId = "cat2",
                                     label = "Select a spend category",
                                     choices = unique(st_df$category),
                                     selected = "Personal_Health_care"
                                    )
                                 )
                        ),
                        
                        column(
                            width = 4,
                            
                            box( status = "warning", width = NULL, height = 100,
                                 selectizeInput( inputId = "metric2", 
                                                 label = "Select a metric",
                                                 choices = c("total_dollars_millions", "percap_dollars", "percap_lq", "population"),
                                                 selected = "percap_dollars")
                            ) 
                        )
                        
                    ),
                    
                    fluidRow(
                        column( width = 9,
                                box( title = "US States Personal Healthcare Spend Map", solidHeader = T, 
                                     status = "info", width = NULL, height = "auto",
                                     leafletOutput("usmap", height = 450)
                                ) ),
                        
                        # to add compounded annual growth rate for the selected time period
                        column( width = 3,
                                box( title = "Top 10 States by Metric", solidHeader = T, 
                                     status = "info", width = NULL, height = 500 
                                     
                                ) )
                        
                    )
                    
                    
                    )
        )
    )
)))