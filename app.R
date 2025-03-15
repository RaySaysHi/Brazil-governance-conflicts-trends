# Load packages
library(shiny)
library(shinyWidgets)
library(readr)
library(dplyr)
library(ggplot2)
library(lubridate)
library(sf)
library(leaflet)
library(vdemdata)

# Load V-Dem data for Brazil
vdem_data <- read_csv("data/brazil_data.csv")

# Load conflict event data for Brazil
ged_brazil <- read_csv("data/GEDEvent_v23_1.csv") %>% 
  filter(country_id == 140) %>% 
  mutate(deaths = deaths_a + deaths_b + deaths_civilians + deaths_unknown,
         date = as.Date(date_start, format = "%Y-%m-%d")) %>%
  select(event_id = id,
         country_id,
         date = date_start,
         gov_deaths = deaths_a, 
         rebel_deaths = deaths_b, 
         civilian_deaths = deaths_civilians, 
         deaths, 
         place = where_coordinates,
         latitude, 
         longitude) %>% 
  st_as_sf(coords = c("longitude", "latitude"), crs = 4326)

vars <- c(
  "Polyarchy" = "polyarchy",
  "Democracy" = "electoral_democracy_index",
  "Corruption" = "corruption_index",
  "Freedom of Expression" = "freedom_expression",
  "Democracy" = "liberal_democracy",
  "Participation" = "participation",
  "GDP Per Capita" = "gdp_pc",
  "Mortality" = "inf_mort",
  "Life Expectancy" = "life_exp",
  "Education" = "education"
)


# Define UI
ui <- fluidPage(
  titlePanel("Brazil: Conflict Events and Governance Trends"),
  selectInput("indicator", "Indicator:", vars),
  sliderInput("dateRange", "Select Date Range:", 
              min = as.Date("1921-01-01"), 
              max = as.Date("2021-12-31"),
              value = c(as.Date("1921-01-01"), as.Date("2021-12-31")),
              timeFormat = "%Y-%m-%d"),
  leafletOutput("map"),
  plotOutput("trendPlot")
)

# Define server logic
server <- function(input, output, session) {
  # Reactive data for conflict events based on date range
  filtered_ged <- reactive({
    ged_brazil %>% 
      filter(date >= input$dateRange[1] & date <= input$dateRange[2])
  })
  
  # Render the Leaflet map
  output$map <- renderLeaflet({
    icon <- awesomeIcons(
      icon = "ios-close",
      iconColor = "black",
      markerColor = "red", 
      library = "ion" 
    )
    
    leaflet(data = filtered_ged()) %>%
      addProviderTiles("OpenTopoMap") %>%
      setView(lng = -51.9253, lat = -14.2350, zoom = 4) %>%
      addAwesomeMarkers(
        icon = icon, 
        popup = ~paste("Date:", as.character(date), "<br>Deaths:", deaths),
        label = ~place
      )
  })
  
  # Reactive data for V-Dem trends based on date range
  filtered_vdem <- reactive({
    vdem_data %>% 
      filter(year >= as.numeric(format(input$dateRange[1], "%Y")) & 
               year <= as.numeric(format(input$dateRange[2], "%Y")))
  })
  
  # Render the trend plot
  output$trendPlot <- renderPlot({
    ggplot(filtered_vdem(), aes(x = year, y = get(input$indicator))) +
      geom_line(color = "navyblue", linewidth = .75) +
      labs(
        x = "Year", 
        y = names(vars[which(vars == input$indicator)])) +
      theme_minimal()
  })
}

# Create the Shiny app
shinyApp(ui = ui, server = server)