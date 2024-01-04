# -------------------------------------------------------------------------
# ---------------------------- Libraries/Packages -------------------------
# -------------------------------------------------------------------------

box::use(
  dplyr[`%>%`],
  glue[glue],
  htmltools[HTML],
  leaflet[addCircleMarkers, addLayersControl, addMarkers, addProviderTiles, 
          addPolylines, colorFactor, highlightOptions, iconList, labelOptions, 
          layersControlOptions, leaflet, leafletOptions, makeIcon, popupOptions, 
          providers, setView],
  leaflet.extras[addFullscreenControl, addSearchFeatures, searchFeaturesOptions],
  leaflegend[addLegendFactor, addLegendImage]
)

# -------------------------------------------------------------------------
# ---------------------------------- Modules ------------------------------
# -------------------------------------------------------------------------

box::use(
  app/logic[constants]
)

# -----------------------------------------------
# ---- Functions to Format Bus Map Elements -----
# -----------------------------------------------
format_bus_route_label <- function(avg_var, makePopup = FALSE) {
  # Create a leaflet on-hover label, or a popup?
  if (makePopup == TRUE) {
    this.text <- paste0(
      "<strong style = 'font-size: 16px; color: #007aff;'>Bus: {map_data$bus_routes$route_id}</strong> <br>
      <strong style = 'font-size: 16px; color: #007aff;'>{map_data$bus_routes$long_name}</strong> <br>
      <span style = 'font-size: 14px;'>{map_data$bus_routes$route_desc}</span> <br>
      <strong style = 'font-size: 16px; color: #007aff;'>{format(round(map_data$bus_routes$",
      avg_var,
      "), big.mark = ',')}</strong> <strong style = 'font-size: 14px;'>Average Weekday Boardings</strong>")
  } else {
    this.text <- paste0(
      "<strong strong style = 'font-size: 16px; color: #007aff;'>Bus: {map_data$bus_routes$route_id}</strong> <br>
      <strong strong style = 'font-size: 16px; color: #007aff;'>{map_data$bus_routes$long_name}</strong> <br>
      <span style = 'font-size: 14px;'>{map_data$bus_routes$route_desc}</span> <br>
      <strong strong style = 'font-size: 16px; color: #007aff;'>{format(round(map_data$bus_routes$",
      avg_var,
      "), big.mark = ',')}</strong> <strong style = 'font-size: 14px;'>Average Weekday Boardings</strong>")
  }
  
  return(this.text)
}

format_bus_stop_label <- function(avg_var, makePopup = FALSE) {
  # Create a leaflet on-hover label, or a popup?
  if (makePopup == TRUE) {
    this.text <- paste0(
      "<strong style = 'font-size: 16px;color: #007aff;'>{map_data$bus_stops$stop_name}</strong> <br>
      <strong style = 'font-size: 16px;color: #007aff;'>{format(round(map_data$bus_stops$",
      avg_var,
      "), big.mark = ',')}</strong> <strong style = 'font-size: 14px;'>Average Weekday Boardings</strong>"
    )
  } else {
    this.text <- paste0(
      "<strong style = 'font-size: 16px; color: #007aff;'>{map_data$bus_stops$stop_name}</strong> <br>
      <strong style = 'font-size: 16px; color: #007aff;'>{format(round(map_data$bus_stops$",
      avg_var,
      "), big.mark = ',')}</strong> <strong style = 'font-size: 14px;'>Average Weekday Boardings</strong>"
    )
  }
  
  return(this.text)
}

# ---------------------------------------------------------
# ---- Functions to Format Rapid Transit Map Elements -----
# ---------------------------------------------------------
format_rapid_route_label <- function(avg_var, makePopup = FALSE) {
  # Create a leaflet on-hover label, or a popup?
  if (makePopup == TRUE) {
    this.text <- paste0(
      "<strong style = 'font-size: 16px;color: #007aff;'>{map_data$rapid_routes$long_name}</strong> <br>
      <span style = 'font-size: 14px;'>{map_data$rapid_routes$route_desc}</span> <br>
      <strong style = 'font-size: 16px;color: #007aff;'>{format(map_data$rapid_routes$",
      avg_var,
      ", big.mark = ',')}</strong> <strong style = 'font-size: 14px;'>Average Weekday Boardings</strong>"
    )
  } else {
    this.text <- paste0(
      "<strong style = 'font-size: 16px; color: #007aff;'>{map_data$rapid_routes$long_name}</strong> <br>
      <span style = 'font-size: 14px;'>{map_data$rapid_routes$route_desc}</span> <br>
      <strong style = 'font-size: 16px; color: #007aff;'>{format(map_data$rapid_routes$",
      avg_var,
      ", big.mark = ',')}</strong> <strong style = 'font-size: 14px;'>Average Weekday Boardings</strong>"
    )
  }
  
  return(this.text)
}

format_rapid_stop_label <- function(avg_var, makePopup = FALSE) {
  # Create a leaflet on-hover label, or a popup?
  if (makePopup == TRUE) {
    this.text <- paste0(
      "<strong style = 'font-size: 16px;color: #007aff;'>{map_data$rapid_stops$stop_name}</strong> <br>
      <strong style = 'font-size: 16px;color: #007aff;'>{format(map_data$rapid_stops$",
      avg_var,
      ", big.mark = ',')}</strong> <strong style = 'font-size: 14px;'>Average Weekday Boardings</strong>"
    )
  } else {
    this.text <- paste0(
      "<strong style = 'font-size: 16px; color: #007aff;'>{map_data$rapid_stops$stop_name}</strong> <br>
      <strong style = 'font-size: 16px; color: #007aff;'>{format(map_data$rapid_stops$",
      avg_var,
      ", big.mark = ',')}</strong> <strong style = 'font-size: 14px;'>Average Weekday Boardings</strong>"
    )
  }
  
  return(this.text)
}

# -------------------------------------------------
# ---- Functions to Format Ferry Map Elements -----
# -------------------------------------------------
format_ferry_route_label <- function(avg_var, makePopup = FALSE) {
  # Create a leaflet on-hover label, or a popup?
  if (makePopup == TRUE) {
    this.text <- paste0(
      "<strong style = 'font-size: 16px; color: #007aff;'>{map_data$ferry_routes$long_name}</strong> <br>
      <span style = 'font-size: 14px;'>{map_data$ferry_routes$route_desc}</span> <br>
      <strong style = 'font-size: 16px; color: #007aff;'>{format(round(map_data$ferry_routes$",
      avg_var,
      "), big.mark = ',')}</strong> <strong style = 'font-size: 14px;'>Average Weekday Boardings</strong>"
    )
  } else {
    this.text <- paste0(
      "<strong style = 'font-size: 16px; color: #007aff;'>{map_data$ferry_routes$long_name}</strong> <br>
      <span style = 'font-size: 14px;'>{map_data$ferry_routes$route_desc}</span> <br>
      <strong style = 'font-size: 16px; color: #007aff;'>{format(round(map_data$ferry_routes$",
      avg_var,
      "), big.mark = ',')}</strong> <strong style = 'font-size: 14px;'>Average Weekday Boardings</strong>"
    )
  }
  
  return(this.text)
}

format_ferry_stop_label <- function(avg_var, makePopup = FALSE) {
  # Create a leaflet on-hover label, or a popup?
  if (makePopup == TRUE) {
    this.text <- paste0(
      "<strong style = 'font-size: 16px;color: #007aff;'>{map_data$ferry_stops$stop_name}</strong> <br>
      <strong style = 'font-size: 16px;color: #007aff;'>{format(round(map_data$ferry_stops$",
      avg_var,
      "), big.mark = ',')}</strong> <strong style = 'font-size: 14px;'> Average Weekday Boardings</strong>"
    )
  } else {
    this.text <- paste0(
      "<strong style = 'font-size: 16px; color: #007aff;'>{map_data$ferry_stops$stop_name}</strong> <br>
      <strong style = 'font-size: 16px; color: #007aff;'>{format(round(map_data$ferry_stops$",
      avg_var,
      "), big.mark = ',')}</strong> <strong style = 'font-size: 14px;'>Average Weekday Boardings</strong>"
    )
  }
  
  return(this.text)
}

# ----------------------------------
# ----- Function To Create Map -----
# ----------------------------------
#' @export
build_mbta_map <- function(map_data, year) {
  # ------------------------
  # --- Helper Variables ---
  # ------------------------
  
  # Icons for map
  mbta_icons <- iconList(
    rapidT = makeIcon(iconUrl = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/64/MBTA.svg/2048px-MBTA.svg.png",
                      iconWidth = 15, iconHeight = 15, 
                      className = "rapid-icon"),
    tiny_icon = makeIcon(iconUrl = "https://png.pngtree.com/png-vector/20210124/ourmid/pngtree-bus-icon-design-template-vector-isolated-png-image_2801320.jpg",
                         iconWidth = 1, iconHeight = 1)
  )
  
  # Generically applied label styling for tooltip
  label_style = list("border-style" = "solid",
                     "border-width" = "3px",
                     "border-radius" = ".5em",
                     "padding" = "15px")
  
  # Line weight for routes
  line_weight <- 4
  
  # Color palettes for legends
  routePalette <- colorFactor(constants$colors[2:8] %>% unlist() %>% unname(),
                              c("Blue Line", "Green Line", "Orange Line", "Red Line", "Bus Route", "Silver Line", "Ferry Route"),
                              ordered = TRUE)
  
  selectStopPalette <- colorFactor(constants$colors[c(6, 8)] %>% unlist() %>% unname(),
                                   c("Bus Stops", "Ferry Stop"),
                                   ordered = TRUE)
  
  # Define which year's data to use (this will be passed to label formatting functions)
  avg_var <- paste0("avg_", year)
  
  # --------------------------
  # --- Build the Base Map ---
  # --------------------------
  
  mbta_map <- leaflet(options = leafletOptions(minZoom = 9, maxZoom = 20)) %>% 
    setView(zoom = 13, lat = 42.35544817958057, lng = -71.06299087861584) %>% 
    # --- Provider Tiles for Base Map ---
    addProviderTiles(providers$CartoDB.VoyagerNoLabels, group = "CartoDBVoayager") %>%
    addProviderTiles(providers$CartoDB.VoyagerOnlyLabels, group = 'CartoDBVoayager'
    ) %>% 
    addProviderTiles(providers$CartoDB.PositronNoLabels, group = "CartoDBPositron") %>% 
    addProviderTiles(providers$CartoDB.PositronOnlyLabels, group = "CartoDBPositron") %>% 
    
    # --- Bus Routes and Stations ---
    addPolylines(data = map_data$bus_routes, weight = line_weight, color = ~paste0("#", route_hex), opacity = 1, group = "Routes",
                 highlightOptions = highlightOptions(color = constants$colors$highlight, bringToFront = TRUE,
                                                     weight = 5, opacity = 1),
                 label = glue(format_bus_route_label(avg_var = avg_var, makePopup = FALSE)) %>% lapply(HTML),
                 popup = glue(format_bus_route_label(avg_var = avg_var, makePopup = TRUE)) %>% lapply(HTML),
                 labelOptions = labelOptions(
                   style = c(label_style,
                             "border-color" = constants$colors$highlight)),
                 popupOptions = popupOptions(className = "custom-popup"),
                 layerId = ~paste(long_name, "(", route_desc, " ", route_id, ")")) %>% 
    addCircleMarkers(data = map_data$bus_stops, group = "Toggle Bus Stops", radius = 3, opacity = 1, fillOpacity = 1, color = constants$colors$bus, fillColor = "black",
                     label = glue(format_bus_stop_label(avg_var = avg_var, makePopup = FALSE)) %>% lapply(HTML),
                     popup = glue(format_bus_stop_label(avg_var = avg_var, makePopup = TRUE)) %>% lapply(HTML),
                     labelOptions = labelOptions(
                       style = c(label_style, 
                                 "border-color" = constants$colors$highlight)), 
                     popupOptions = popupOptions(className = "custom-popup")) %>% 
    
    # --- Ferry Route and Stations ---
    addPolylines(data = map_data$ferry_routes, weight = line_weight, color = constants$colors$ferry, dashArray = "2 6", opacity = 1, group = "Routes",
                 highlightOptions = highlightOptions(color = constants$colors$highlight, bringToFront = TRUE, 
                                                     weight = 5, opacity = 1),
                 label = glue(format_ferry_route_label(avg_var = avg_var, makePopup = FALSE)) %>% lapply(HTML),
                 popup = glue(format_ferry_route_label(avg_var = avg_var, makePopup = TRUE)) %>% lapply(HTML),
                 labelOptions = labelOptions(
                   style = c(label_style, 
                             "border-color" = constants$colors$highlight)), 
                 popupOptions = popupOptions(className = "custom-popup"),
                 layerId = ~paste0(long_name, " (Ferry Route)")) %>% 
    addCircleMarkers(data = map_data$ferry_stops, radius = 3, color = constants$colors$ferry, opacity = 1, fillOpacity = 1, group = "Stops & Stations",
                     label = glue(format_ferry_stop_label(avg_var = avg_var, makePopup = FALSE)) %>% lapply(HTML),
                     popup = glue(format_ferry_stop_label(avg_var = avg_var, makePopup = TRUE)) %>% lapply(HTML),
                     labelOptions = labelOptions(
                       style = c(label_style,
                                 "border-color" = constants$colors$highlight)),
                     popupOptions = popupOptions(className = "custom-popup")) %>% 
    addMarkers(data = map_data$ferry_stops, icon = mbta_icons$tiny_icon, group = "Markers",
               label = glue(format_ferry_stop_label(avg_var = avg_var, makePopup = FALSE)) %>% lapply(HTML),
               popup = glue(format_ferry_stop_label(avg_var = avg_var, makePopup = TRUE)) %>% lapply(HTML),
               labelOptions = labelOptions(
                 style = c(label_style,
                           "border-color" = constants$colors$highlight)),
               layerId = ~paste(stop_name, " (Ferry Stop)"),
               popupOptions = popupOptions(className = "custom-popup")) %>% 
  
    # --- Rapid Transit Routes and Stations ---
    addPolylines(data = map_data$rapid_routes, weight = line_weight, color = ~paste0("#", route_col), opacity = 1, group = "Routes",
                 highlightOptions = highlightOptions(color = constants$colors$highlight, bringToFront = TRUE,
                                                     weight = 5, opacity = 1),
                 label = glue(format_rapid_route_label(avg_var = avg_var, makePopup = FALSE)) %>% lapply(HTML),
                 popup = glue(format_rapid_route_label(avg_var = avg_var, makePopup = TRUE)) %>% lapply(HTML),
                 labelOptions = labelOptions(
                   style = c(label_style,
                             "border-color" = constants$colors$highlight)),
                 layerId = ~paste0(long_name, " (Rapid Transport Route)"),
                 popupOptions = popupOptions(className = "custom-popup")) %>% 
    addMarkers(data = map_data$rapid_stops, icon = mbta_icons$rapidT, group = "Markers",
               label = glue(format_rapid_stop_label(avg_var = avg_var, makePopup = FALSE)) %>% lapply(HTML),
               popup = glue(format_rapid_stop_label(avg_var = avg_var, makePopup = TRUE)) %>% lapply(HTML),
               labelOptions = labelOptions(
                 style = c(label_style,
                           "border-color" = constants$colors$highlight)),
               layerId = ~paste0(stop_name, " (Rapid Transport Station)"),
               popupOptions = popupOptions(className = "custom-popup")) %>% 
    
    # --- Legend & Other Stuff ---
    addLayersControl(baseGroups = c("CartoDBVoayager", "CartoDBPositron"),
                     overlayGroups = c("Toggle Bus Stops"),
                     options = layersControlOptions(collapsed = FALSE)) %>% 
    addLegendFactor(pal = routePalette, shape = "line", 
                    values = c("Blue Line", "Green Line", "Orange Line", "Red Line", "Bus Route", "Silver Line", "Ferry Route"),
                    title = NULL, position = "topright") %>% 
    addLegendFactor(pal = selectStopPalette, shape = "circle",
                    values = c("Bus Stops", "Ferry Stop"),
                    title = NULL, position = "topright",
                    width = 35) %>% 
    addLegendImage(images = mbta_icons$rapidT$iconUrl, labels = c("Rapid Transit Station"),
                   position = "topright", labelStyle = "font-size: 13px;") %>% 
    
    # --- Control Pane for Layers ---
    addFullscreenControl() %>% 
    addSearchFeatures(targetGroups = c("Routes", "Markers"), 
                      options = searchFeaturesOptions(
                        zoom=15, openPopup = TRUE, firstTipSubmit = TRUE,
                        autoCollapse = TRUE, hideMarkerOnCollapse = TRUE,
                        propertyName = "layerId",
                        textPlaceholder = "Search a route/stop..."))
  
  return(mbta_map)
}
