#' Interactive map of station location(s)
#'
#' @param dat Data frame with columns \code{longitude}, \code{latitude},
#'   \code{station}.
#'
#' @returns A leaflet object.
#'
#' @export
#'

ss_map_stations <- function(dat) {

  leaflet::leaflet(dat) |>
    leaflet::addProviderTiles("Esri.OceanBasemap") |>
    leaflet::addCircleMarkers(
      data = dat,
      lng = ~longitude, lat = ~latitude, label = ~station,
      weight = 1, fillOpacity = 0.75, radius = 5
    ) |>
    leaflet::addScaleBar(
      position = "bottomleft",
      options = leaflet::scaleBarOptions(imperial = FALSE)
    )
}
