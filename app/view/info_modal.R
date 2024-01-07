# -------------------------------------------------------------------------
# ---------------------------- Libraries/Packages -------------------------
# -------------------------------------------------------------------------

box::use(
  shiny[actionButton, icon, modalButton, modalDialog, moduleServer, NS, showModal, tagList, observeEvent]
)

# -------------------------------------------------------------------------
# ---------------------------------- Modules ------------------------------
# -------------------------------------------------------------------------

box::use(
  app/logic[info_modal_logic]
)

# -------------------------------------------------------------------------
# ------------------------------ UI Function ------------------------------
# -------------------------------------------------------------------------

#' @export
init_ui <- function(id) {
  ns <- NS(id)
  tagList(
    
    # ----- Application Info Modal Button -----
    actionButton(inputId = ns("show"), 
                 label = "", 
                 icon = icon("circle-info"), 
                 class = "header-help-icon")
  )
}

# -------------------------------------------------------------------------
# ----------------------------- Server Function ---------------------------
# -------------------------------------------------------------------------

#' @export
init_server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      # ----------------------------------
      # ----- Application Info Modal -----
      # ----------------------------------
      observeEvent(input$show, {
        showModal(
          modalDialog(
            title = "MBTA Ridership Dashboard",
            footer = modalButton("Dismiss"),
            easyClose = TRUE,
            info_modal_logic$build_modal()
          )
        )
      })
    }
  )
}