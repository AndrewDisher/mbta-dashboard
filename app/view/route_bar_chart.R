# -------------------------------------------------------------------------
# ---------------------------- Libraries/Packages -------------------------
# -------------------------------------------------------------------------

box::use(
  dplyr[`%>%`],
  echarts4r[echarts4rOutput, renderEcharts4r],
  shiny[moduleServer, NS, reactive, selectInput, tagList, tags],
  shinycssloaders[withSpinner]
)

# -------------------------------------------------------------------------
# ---------------------------------- Modules ------------------------------
# -------------------------------------------------------------------------

box::use(
  app/logic[constants, route_bar_chart_logic]
)

# -------------------------------------------------------------------------
# ------------------------------ UI Function ------------------------------
# -------------------------------------------------------------------------

init_ui <- function(id) {
  ns <- NS(id)
  tagList(
    tags$div(
      class = "panel-header",
      selectInput(
        ns("sort"), 
        "Sort by ascending or descending?",
        choices = c("Most Popular Routes" = "Top 10", "Least Popular Routes" = "Bottom 10"),
        width = NULL,
        selectize = TRUE,
        selected = "Top 10"
      )
    ),
    tags$div(class = "chart-bar-route-container",
      echarts4rOutput(outputId = ns("route_bar_chart"), height = "300px", width = "100%") %>% 
        withSpinner(type = 4,  color = constants$colors$highlight)
      )
  )
}

# -------------------------------------------------------------------------
# ----------------------------- Server Function ---------------------------
# -------------------------------------------------------------------------

init_server <- function(id, route_data, year) {
  moduleServer(
    id,
    function(input, output, session) {
      # -------------------------------------------------------------
      # ----- Reactive Choice for Ascending or Descending Order -----
      # -------------------------------------------------------------
      sort_order_choice <- reactive({ input$sort })
      
      # ----------------------------------
      # ----- Reactive Data Cleaning -----
      # ----------------------------------
      cleaned_route_data <- reactive({
        route_bar_chart_logic$clean_data(data = route_data(), year = year(),
                                         sort_order = sort_order_choice())
      })
      
      # -------------------------------
      # ----- Build The Bar Chart -----
      # -------------------------------
      output$route_bar_chart <- renderEcharts4r({
        route_bar_chart_logic$build_bar_chart(data = cleaned_route_data(), year = year())
      })
    }
  )
}
