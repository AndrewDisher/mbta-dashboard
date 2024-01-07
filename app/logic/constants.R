# Constants to be used throughout the app. Use sparingly.

box::use(
  htmltools[HTML]
)

# Color pallete
#' @export
colors <- list(
  mbta = "#165c96",
  blue_line = "#003DA5",
  green_line = "#00843D",
  orange_line = "#ED8B00",
  red_line = "#DA291C",
  bus = "#FFC72C",
  silver_line = "#7C878E",
  ferry = "#008EAA",
  highlight = "#28bf46",
  base_bar_color = "#1a7e2e",
  waiter_background = "#e3e7e9"
)

#' @export
mbta_svg <- HTML("
  <svg class='logo-svg' viewBox='0 0 70 70'>
    <use href='static/css/assets/icons/mbta-sprite-map.svg#mbta'></use>
  </svg>
")
