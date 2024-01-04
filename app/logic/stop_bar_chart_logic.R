# -------------------------------------------------------------------------
# ---------------------------- Libraries/Packages -------------------------
# -------------------------------------------------------------------------

box::use(
  dplyr[`%>%`, arrange, desc, filter],
  echarts4r[e_axis_labels, e_bar_, e_charts, e_flip_coords, e_grid, e_labels, e_legend, 
            e_tooltip, e_x_axis],
  htmlwidgets[JS],
  utils[head, tail]
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
clean_data <- function(data, year, sort_order) {
  # 2018 or 2019 data?
  if (year == "2018") {
    if (sort_order == "Bottom 10") {
      stop_bar_10 <- data %>%
        filter(avg_2018 > 0) %>% 
        arrange(desc(avg_2018)) %>% 
        tail(10)
    } else {
      stop_bar_10 <- data %>%
        arrange(avg_2018) %>% 
        tail(10)
    }
  } else if (year == "2019") {
    if (sort_order == "Bottom 10") {
      stop_bar_10 <- data %>%
        filter(avg_2019 > 0) %>% 
        arrange(desc(avg_2019)) %>% 
        tail(10)
    } else {
      stop_bar_10 <- data %>%
        arrange(avg_2019) %>% 
        tail(10)
    }
  }
  
  return(stop_bar_10)
}

# -------------------------------------------
# ----- Function to Build the Bar Chart -----
# -------------------------------------------
#' @export
build_bar_chart <- function(data, year) {
  chart <- data %>% 
    e_charts(bar_name) %>% 
    e_bar_(serie = paste0("avg_", year), name = "Average Weekday Boardings",
          bind = paste0("avg_", year, "_percent"),
          itemStyle = list(color =  constants$colors$base_bar_color),
          emphasis = list(itemStyle = list(color = constants$colors$highlight)),
          showBackground = TRUE) %>% 
    e_labels(position = "right",
             formatter = JS("App.labelFormat")) %>%
    e_flip_coords() %>% 
    e_tooltip(formatter = JS("App.barTooltip"),
              borderColor = constants$colors$highlight,
              borderWidth = 3
    ) %>% 
    e_axis_labels(y = 'Stop', x = '') %>% 
    e_legend(show = FALSE) %>% 
    e_grid(left = "20%") %>% 
    e_x_axis(name = "Avg. Weekday Boardings",
             nameLocation = "center",
             nameGap = 35)
  
  return(chart)
}


