# -------------------------------------------------------------------------
# ---------------------------- Libraries/Packages -------------------------
# -------------------------------------------------------------------------

box::use(
  dplyr[`%>%`, arrange],
  echarts4r[e_axis_labels, e_bar, e_charts, e_flip_coords, e_grid, e_labels, e_legend, 
            e_tooltip, e_x_axis],
  htmlwidgets[JS],
  utils[tail]
)

# -------------------------------------------------------------------------
# ---------------------------------- Modules ------------------------------
# -------------------------------------------------------------------------

box::use(
  app/logic[constants]
)

# --------------------------------------------
# ----- Function to Clean Bar Chart Data -----
# --------------------------------------------
#' @export
clean_data <- function(data, year) {
  # 2018 or 2019 data?
  if (year == "2018") {
    route_bar_top_10 <- data %>%
      arrange(avg_2018) %>% 
      tail(10)
  } else if (year == "2019") {
    route_bar_top_10 <- data %>%
      arrange(avg_2019) %>% 
      tail(10)
  }
  
  return(route_bar_top_10)
}

# -------------------------------------------
# ----- Function to Build the Bar Chart -----
# -------------------------------------------
#' @export
build_bar_chart <- function(data) {
  chart <- data %>%
    e_charts(bar_name) %>%
    e_bar(serie = avg_2019, name = "Average Weekday Boardings",
          bind = avg_2019_percent,
          itemStyle = list(color =  constants$colors$base_bar_color),
          emphasis = list(itemStyle = list(color = constants$colors$highlight)),
          showBackground = TRUE) %>%
    e_labels(position = "right",
             formatter = JS("function labelFormat(params) {
                          var myValue = Math.round(+params.value[0]);
                          var formattedValue = `${myValue.toLocaleString('en-US')}`;
                          return (formattedValue);}")) %>%
    e_flip_coords() %>%
    e_tooltip(formatter = JS("function barTooltip(params) {
                           var tooltip = '<strong>' + `${params.value[1]}` + '</strong>' + '<br>' +
                           '<strong>' + `${params.name}%` + '</strong>' + ' of all Average Weekday Boardings';
                           return (tooltip);}")
    ) %>%
    e_axis_labels(y = 'Route', x = '') %>%
    e_legend(show = FALSE) %>% 
    e_grid(left = "20%") %>% 
    e_x_axis(name = "Avg. Weekday Boardings",
             nameLocation = "center",
             nameGap = 35)
  
  return(chart)
}
