# Brazil Governance and Conflicts Trends Explorer

## Overview

This Shiny application offers an interactive and insightful exploration of governance trends and conflict events in Brazil. The app leverages datasets from the V-Dem Dataset and the Uppsala Conflict Data Program (UCDP) to provide a comprehensive view of Brazil's political landscape.

## Live Demo

Try the application here: [Brazil Governance and Conflicts Trends Explorer](https://raysayshi.shinyapps.io/project-assignment-3-RaySaysHi/)

## Features

The application has two primary components:

### Interactive Map
- Displays conflict events in Brazil
- Each event is represented by a marker showing location, date, and number of deaths
- Uses "OpenTopoMap" basemap for clear geographical context
- Hover over markers for brief descriptions or click for detailed information

### Dynamic Line Chart
- Visualizes various governance indicators over time
- Select different indicators from a dropdown menu:
  - Polyarchy (democracy scores)
  - Corruption Index
  - Freedom of Expression
  - GDP Per Capita
- Chart updates dynamically based on selected date range or chosen indicator

Both components are controlled by a single date range slider, allowing users to synchronize the temporal scope of the visualized data.

## Data Sources

- **V-Dem Dataset**: Provides governance indicators for Brazil spanning from 1921 to 2021, offering a 100-year historical perspective
- **UCDP Data**: Details conflict events in Brazil, including fatalities, location, and date of each event

## Insights and Patterns

The application reveals several patterns that might not be immediately apparent without interactive visualizations:

- **Correlation between governance and conflict**: Periods of lower democracy scores tend to coincide with increased conflict intensity or frequency
- **Regional variations**: The map component highlights regions with higher conflict concentration, prompting questions about regional disparities
- **Historical context**: The extensive date range allows users to place current issues within a historical context, understanding long-term trends and cyclic patterns
- **Impact of economic indicators**: Users can explore potential relationships between economic factors (GDP) and political stability

## Purpose

This application serves as an interactive platform for exploring the complex interplay between governance and conflict in Brazil. It offers a unique tool for educators, students, researchers, and anyone interested in Brazilian politics, providing insights that can serve as a foundation for further research and discussion on the factors driving political stability and conflict in Brazil.