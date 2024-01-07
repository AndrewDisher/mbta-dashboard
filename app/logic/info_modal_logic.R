# -------------------------------------------------------------------------
# ---------------------------- Libraries/Packages -------------------------
# -------------------------------------------------------------------------

box::use(
  shiny[a, br, div, h4, p, span, tagList],
)

# --------------------------------------------
# ----- Function to Build the Info Modal -----
# --------------------------------------------
#' @export
build_modal <- function() {
  modal_content <- tagList(
    # ---------------------------------
    # ----- About the Application -----
    # ---------------------------------
    h4(class = "modal-description-header", "About the Project"),
    
    div(class = "modal-paragraph", 
      "This application displays the public ridership data for the MBTA transit system
      available at their", 
      a(href = "https://mbta-massdot.opendata.arcgis.com/",
        target = "_blank",
        span(class = "link-span", "OPMI Pata Portal")), 
      ". It is an interactive dashboard that allows the user
      to browse the the stops and routes in the system and determine the average level of passenger
      boardings that each experiences in the specified time frames."),
    br(),
    div(class = "modal-paragraph",
      "Data is available for the Fall seasons in each of the years provided. Try searching 
      for a station you're interested in by clicking on the search icon within the map!"),
    br(),
    
    # ------------------------------------------
    # ----- Tech Stack Used in Application -----
    # ------------------------------------------
    h4(class = "modal-description-header", "Technologies Used"),
    div(class = "technology-grid",
        div(class = "left-description", span(style = "font-weight: bold;", "Technology Stack:")),
        div(class = "right-tech-used",
            a(href = "https://www.r-project.org/",
              target = "_blank",
              span(class = "tech-span", "R")), 
            a(href = "https://www.rstudio.com/products/shiny/",
              target = "_blank",
              span(class = "tech-span", "R/Shiny")),
            a(href = "https://developer.mozilla.org/en-US/docs/Web/HTML", 
              target = "_blank",
              span(class = "tech-span", "HTML")),
            a(href = "https://sass-lang.com/", 
              target = "_blank",
              span(class = "tech-span", "SASS")),
            a(href = "https://www.shinyapps.io/", 
              target = "_blank",
              span(class = "tech-span", "shinyapps.io"))
        )
    ),
    br(),
    
    # ------------------------------
    # ----- Notable R Packages -----
    # ------------------------------
    div(class = "technology-grid",
        div(class = "left-description",
            span(style = "font-weight: bold;", "Notable R Packages:")),
        div(class = "right-tech-used",
            a(href = "https://echarts4r.john-coene.com/",
              target = "_blank",
              span(class = "tech-span", "echarts4r")),
            a(href = "https://rstudio.github.io/renv/articles/renv.html",
              target = "_blank", 
              span(class = "tech-span", "renv")),
            a(href = "https://klmr.me/box/",
              target = "_blank",
              span(class = "tech-span", "box")),
            a(href = "https://dplyr.tidyverse.org/",
              target = "_blank", 
              span(class = "tech-span", "dplyr")),
            a(href = "https://appsilon.github.io/rhino/",
              target = "_blank", 
              span(class = "tech-span", "rhino")),
            a(href = "https://rstudio.github.io/leaflet/",
              target = "_blank", 
              span(class = "tech-span", "leaflet"))
        )
    ),
    br(),
    
    # ----------------------------
    # ----- About the Author -----
    # ----------------------------
    h4(class = "author-header", "About the Author"),
    div(class = "author-description",
        "My name is Andrew Disher and I am a Data Science Master's student at the
          University of Massachusetts Dartmouth. Among other things, I delight in building 
          R Shiny applications that showcase the collective power of R, Shiny, HTML, CSS, and
          a suite of other readily available web technologies, all to better communicate data. You can reach me
          via ", 
        a(href = "https://www.linkedin.com/in/andrew-disher-8b091b212/",
          target = "_blank",
          span(class = "author-span", "LinkedIn")), 
        "and browse some of my other work available on ", 
        a(href = "https://github.com/AndrewDisher",
          target = "_blank",
          span(class = "author-span", "GitHub")), 
        "and", 
        a(href = "https://andrew-disher.netlify.app/project/",
          target = "_blank",
          span(class = "author-span", "my website.")),
        "Cheers!")
  )
  
  return(modal_content)
}
