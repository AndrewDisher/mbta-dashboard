# -------------------------------------------------------------------------
# ---------------------------- Libraries/Packages -------------------------
# -------------------------------------------------------------------------

box::use(
  sf[`st_crs<-`, st_read, st_transform],
  shiny[moduleServer, NS, reactive, tagList, tags],
  shiny.semantic[semanticPage],
  utils[read.csv]
)

# -------------------------------------------------------------------------
# ---------------------------------- Modules ------------------------------
# -------------------------------------------------------------------------

box::use(
  app/view[mbta_map, route_bar_chart, stop_bar_chart],
  # app/logic[]
)

# -------------------------------------------------------------------------
# ----------------------------- Helper Functions --------------------------
# -------------------------------------------------------------------------

card <- function(class, ...) {tags$div(class = class, ...)}

custom_grid <- function(class, ...) {tags$div(class = class, ...)}

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
    semanticPage(
      # -------------------------------
      # ----- Layout for App Body -----
      # -------------------------------
      tags$main(class = "dashboard",
                tags$section(class = "dashboard-panels",
                             tags$div(class = "panel panel-chart chart-map",
                                      mbta_map$init_ui(id = ns("mbta_map"))),
                             tags$div(class = "panel panel-chart chart-bar-route",
                                      route_bar_chart$init_ui(id = ns("route_bar_chart"))),
                             tags$div(class = "panel panel-chart chart-bar-stop",
                                      stop_bar_chart$init_ui(id = ns("stop_bar_chart"))
                                      )
                             )
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
      
      # ----------------------------------------------
      # ----- Initialize Module Server Functions -----
      # ----------------------------------------------
      mbta_map$init_server(id = "mbta_map", map_data = shape_list)
      route_bar_chart$init_server(id = "route_bar_chart", route_data = route_data)
      stop_bar_chart$init_server(id = "stop_bar_chart", stop_data = stop_data)
    }
  )
}
