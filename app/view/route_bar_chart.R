# -------------------------------------------------------------------------
# ---------------------------- Libraries/Packages -------------------------
# -------------------------------------------------------------------------

box::use(
  echarts4r[echarts4rOutput, renderEcharts4r],
  shiny[moduleServer, NS, reactive, tagList, tags]
)

# -------------------------------------------------------------------------
# ---------------------------------- Modules ------------------------------
# -------------------------------------------------------------------------

box::use(
  app/logic[route_bar_chart_logic]
)

# -------------------------------------------------------------------------
# ------------------------------ UI Function ------------------------------
# -------------------------------------------------------------------------

init_ui <- function(id) {
  ns <- NS(id)
  tagList(
    tags$div(
      class = "chart-bar-route-container",
      echarts4rOutput(outputId = ns("route_bar_chart"), height = "300px")
      )
  )
}

# -------------------------------------------------------------------------
# ----------------------------- Server Function ---------------------------
# -------------------------------------------------------------------------

init_server <- function(id, route_data) {
  moduleServer(
    id,
    function(input, output, session) {
      # ----------------------------------
      # ----- Reactive Data Cleaning -----
      # ----------------------------------
      cleaned_route_data <- reactive({
        route_bar_chart_logic$clean_data(data = route_data(), year = "2019")
      })
      
      # -------------------------------
      # ----- Build The Bar Chart -----
      # -------------------------------
      output$route_bar_chart <- renderEcharts4r({
        route_bar_chart_logic$build_bar_chart(data = cleaned_route_data())
      })
    }
  )
}
