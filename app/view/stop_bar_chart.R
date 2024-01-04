# -------------------------------------------------------------------------
# ---------------------------- Libraries/Packages -------------------------
# -------------------------------------------------------------------------

box::use(
  echarts4r[echarts4rOutput, renderEcharts4r],
  shiny[moduleServer, NS, reactive, selectInput, tagList, tags]
)

# -------------------------------------------------------------------------
# ---------------------------------- Modules ------------------------------
# -------------------------------------------------------------------------

box::use(
  app/logic[stop_bar_chart_logic]
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
        choices = c("Most Popular Stops" = "Top 10", "Least Popular Stops" = "Bottom 10"),
        width = NULL,
        selectize = TRUE,
        selected = "Top 10"
      )
    ),
    tags$div(
      class = "chart-bar-stop-container",
      echarts4rOutput(outputId = ns("stop_bar_chart"), height = "300px")
    )
  )
}

# -------------------------------------------------------------------------
# ----------------------------- Server Function ---------------------------
# -------------------------------------------------------------------------

init_server <- function(id, stop_data, year) {
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
      cleaned_stop_data <- reactive({
        stop_bar_chart_logic$clean_data(data = stop_data(), year = year(), 
                                        sort_order = sort_order_choice())
      })
      
      # -------------------------------
      # ----- Build The Bar Chart -----
      # -------------------------------
      output$stop_bar_chart <- renderEcharts4r({
        stop_bar_chart_logic$build_bar_chart(data = cleaned_stop_data(), year = year())
      })
    }
  )
}
