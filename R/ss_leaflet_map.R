#' Interactive map of station location
#'
#' @param dat Data frame with columns \code{longitude}, \code{latitude},
#'   \code{station}.
#'
#' @returns A leaflet object.
#'
#' @importFrom leaflet leaflet addProviderTiles addCircleMarkers addScaleBar
#'   scaleBarOptions
#'
#' @export
#'

ss_leaflet_station_map <- function(dat) {

  leaflet(dat) %>%
    addProviderTiles("CartoDB.Positron") %>%
    addCircleMarkers(
      data = dat,
      lng = ~longitude, lat = ~latitude, label = ~station,
      weight = 1, fillOpacity = 0.75, radius = 5
    ) %>%
    addScaleBar(
      position = "bottomleft",
      options = scaleBarOptions(imperial = FALSE)
    )
}
