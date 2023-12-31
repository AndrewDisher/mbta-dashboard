# -------------------------------------------------------------------------
# ---------------------------- Libraries/Packages -------------------------
# -------------------------------------------------------------------------

box::use(
  htmltools[tagAppendAttributes],
  sf[`st_crs<-`, st_read, st_transform],
  shiny[bootstrapPage, moduleServer, NS, reactive, selectInput, tagList, tags],
  utils[read.csv],
  waiter[spin_folding_cube, useWaiter, waiterPreloader]
)

# -------------------------------------------------------------------------
# ---------------------------------- Modules ------------------------------
# -------------------------------------------------------------------------

box::use(
  app/view[info_modal, mbta_map, route_bar_chart, stop_bar_chart],
  app/logic[constants]
)

# -------------------------------------------------------------------------
# ------------------------------ Data Imports -----------------------------
# -------------------------------------------------------------------------

# Ridership Data Sets
route_bar_chart_data <- read.csv(file = "data/ridership_data/route_bar_chart_data.csv")
stop_bar_chart_data <- read.csv(file = "data/ridership_data/stop_bar_chart_data.csv")

# Mapping Data Sets
bus_routes <- st_read("data/shape_data/mbta_bus_routes/bus_route_and_ridership.shp")
bus_stops <- st_read("data/shape_data/mbta_bus_stops/bus_stop_and_ridership.shp")

rapid_routes <- st_read("data/shape_data/mbta_rapid_routes/rapid_route_and_ridership.shp")
rapid_stops <- st_read("data/shape_data/mbta_rapid_stops/rapid_stop_and_ridership.shp")

ferry_routes <- st_read("data/shape_data/mbta_ferry_routes/ferry_route_and_ridership.shp")
ferry_stops <- st_read("data/shape_data/mbta_ferry_stops/ferry_stop_and_ridership.shp")

# Set the CRS code for each sf object
st_crs(bus_routes) <- 4326
st_crs(bus_stops) <- 4326

st_crs(rapid_routes) <- 4326
st_crs(rapid_stops) <- 4326

st_crs(ferry_routes) <- 4326
st_crs(ferry_stops) <- 4326

bus_routes <- st_transform(bus_routes, crs = 4326) 
bus_stops <- st_transform(bus_stops, crs = 4326) 

rapid_routes <- st_transform(rapid_routes, crs = 4326) 
rapid_stops <- st_transform(rapid_stops, crs = 4326) 

ferry_routes <- st_transform(ferry_routes, crs = 4326) 
ferry_stops <- st_transform(ferry_stops, crs = 4326) 

# -------------------------------------------------------------------------
# ------------------------------ UI Function ------------------------------
# -------------------------------------------------------------------------
#' @export
ui <- function(id) {
  ns <- NS(id)
  tagList(
    bootstrapPage(
      tags$link(href = "https://fonts.googleapis.com/css2?family=Maven+Pro:wght@400;500;700&display=swap",
                rel = "stylesheet"),
      # ---------------------------------------------
      # ----- Waiter Loading Screen on App Load -----
      # ---------------------------------------------
      
      useWaiter(),
      waiterPreloader(
        html = tagList(
          spin_folding_cube(),
          tags$div(class = "waiter-message", 
                   tags$span(
                     sample(c("Please wait while we load your data...",
                              "We're loading the dashboard...",
                              "Sit back and relax while we load your data...",
                              "One moment while we load your dashboard..."),
                            1)
                   ))
          )
      ),
      
      
      
      
      # -------------------------------
      # ----- Layout for App Body -----
      # -------------------------------
      tags$main(class = "dashboard",
                # --- Dashboard Header ---
                tags$header(class = "dashboard-header",
                            tags$h2(class = "dashboard-heading",
                                    tags$a(href = "https://mbta-massdot.opendata.arcgis.com/",
                                           class = "logo logo-dashboard",
                                           target = "_blank",
                                           constants$mbta_svg),
                                    tags$span(class = "dashboard-title",
                                              "MBTA Ridership Dashboard"),
                                    # --- Info Modal Button ---
                                    tags$span(class = "info-modal-container",
                                              info_modal$init_ui(id = ns("info_modal")))
                                    ),
                            tags$div(class = "dashboard-filters",
                                     # --- Select Input for Year ---
                                     selectInput(inputId = ns("selectYear"), 
                                                 label = "Year",
                                                 choices = c("2018", "2019"),
                                                 selected = "2018",
                                                 selectize = TRUE)
                                     )), 
                
                # --- Dashboard Panels ---
                tags$section(class = "dashboard-panels",
                             tags$div(class = "panel panel-chart chart-map",
                                      mbta_map$init_ui(id = ns("mbta_map"))),
                             tags$div(class = "panel panel-chart chart-bar-route",
                                      route_bar_chart$init_ui(id = ns("route_bar_chart"))),
                             tags$div(class = "panel panel-chart chart-bar-stop",
                                      stop_bar_chart$init_ui(id = ns("stop_bar_chart"))
                                      ))
                )
    )
  )
}

# -------------------------------------------------------------------------
# ----------------------------- Server Function ---------------------------
# -------------------------------------------------------------------------
#' @export
server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns
      # ------------------------------
      # ----- Reactive Data Sets -----
      # ------------------------------
      
      # Mapping Data Sets
      shape_list <- reactive({
        list(bus_routes = bus_routes, bus_stops = bus_stops,
             rapid_routes = rapid_routes, rapid_stops = rapid_stops,
             ferry_routes = ferry_routes, ferry_stops = ferry_stops)
      })
      
      # Bar Chart Data Sets
      route_data <- reactive({ route_bar_chart_data })
      stop_data <- reactive({ stop_bar_chart_data })
      
      # -------------------------
      # ----- Select Inputs -----
      # -------------------------
      
      selected_year <- reactive({ input$selectYear })
      
      # ----------------------------------------------
      # ----- Initialize Module Server Functions -----
      # ----------------------------------------------
      info_modal$init_server(id = "info_modal")
      route_bar_chart$init_server(id = "route_bar_chart", route_data = route_data, year = selected_year)
      stop_bar_chart$init_server(id = "stop_bar_chart", stop_data = stop_data, year = selected_year)
      mbta_map$init_server(id = "mbta_map", map_data = shape_list, year = selected_year)
      
    }
  )
}
