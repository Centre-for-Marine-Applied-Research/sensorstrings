#' Interactive map of station location(s)
#'
#' @param dat Data frame with columns \code{longitude}, \code{latitude},
#'   \code{station}.
#'
#' @returns A leaflet object.
#'
#' @export
#'
#' @examples
#' if (requireNamespace("leaflet", quietly = TRUE)) {
#'   stations <- data.frame(
#'     station = c("Borgles Island", "Birchy Head"),
#'     latitude = c(44.77241, 44.5701),
#'     longitude = c(-62.72608, -64.034383)
#'   )
#'
#'   # the map tiles load when the map is viewed (needs internet)
#'   ss_map_stations(stations)
#' }


ss_map_stations <- function(dat) {
  rlang::check_installed("leaflet", reason = "to use `ss_map_stations()`.")

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
