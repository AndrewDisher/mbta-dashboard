# -------------------------------------------------------------------------
# ---------------------------- Libraries/Packages -------------------------
# -------------------------------------------------------------------------

box::use(
  dplyr[`%>%`],
  leaflet[leafletOutput, renderLeaflet],
  shiny[moduleServer, NS, selectInput, tagList, tags],
  shinycssloaders[withSpinner]
)

# -------------------------------------------------------------------------
# ---------------------------------- Modules ------------------------------
# -------------------------------------------------------------------------

box::use(
  app/logic[constants, mbta_map_logic]
)

# -------------------------------------------------------------------------
# ------------------------------ UI Function ------------------------------
# -------------------------------------------------------------------------
#' @export
init_ui <- function(id) {
  ns <- NS(id)
  tagList(
    tags$div(
      class = "panel-header static-header",
      tags$div(class = "item",
               "Map of the MBTA Transit System"),
    ),
    leafletOutput(outputId = ns("mbta_leaflet_map"), height = "100%") %>% 
      withSpinner(type = 4, color = constants$colors$highlight)
  )
}

# -------------------------------------------------------------------------
# ----------------------------- Server Function ---------------------------
# -------------------------------------------------------------------------
#' @export
init_server <- function(id, map_data, year) {
  moduleServer(
    id,
    function(input, output, session) {
      # ----------------------------------
      # ----- Reactive Map Creation ------
      # ----------------------------------
      output$mbta_leaflet_map <- renderLeaflet({
        mbta_map_logic$build_mbta_map(map_data = map_data(), year = year())
      })
    }
  )
}
