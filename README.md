# MBTA Ridership Dashboard
This is an interactive R/Shiny dashboard that displays an interactive ridership summary of the Massachusetts Bay Transportation Authority transit system in Boston, Massachusetts. 

## Ridership Data
The dashboard uses publicly available data, found on the MBTA open data portal, [Blue Book](https://mbta-massdot.opendata.arcgis.com/). 
Average weekday ridership data for bus routes, rapid transit routes, and ferry routes, as well as all of the stops along these routes are available for 
the Fall 2018 and Fall 2019 season across the three modes of transportation. 

Data for some modes of transportation is available for an additional number of years,
either before or after the 2018-2019 range, but the data availability was not consistent, so only data from 2018-2019 was included. 

This repository contains a cleaned, aggregated version of the data, but the original raw form is available at the [Ridership directory](https://mbta-massdot.opendata.arcgis.com/search?tags=ridership)
of the above link. 

## Geographic Data Shape Files
In addition to ridership data, shapefiles for the geography of each route and stop are also available at the data portal, 
specifically in the [GTFS directory](https://mbta-massdot.opendata.arcgis.com/maps/MassDOT::mbta-systemwide-gtfs-map/explore).

These files were used to generate customized shape files, with the aid of the `sf` R package. Many routes had the same ids in the original shape files, since portions of each route 
were separated as per the MBTA file convention. These custom files differ from the original shape files only in that portions of each route were **attached** such that every route
had a unique id, and each route comprised of each of its respective sections to form a continuous line on a map. 

An exception to this is the case of the MBTA's Green Line, which is actually comprised of the B, C, D, and E routes of the Green Line. These are in fact separate routes, however, data
from the Ridership link above generalized ridership to the sum of its parts (B, C, D, and E). Therefore, the choice was made to connect each of these subroutes to form one, continuous line

This repository contains the R code, SASS and CSS files, javascript files, and data necessary to create the interactive dashboard. 
