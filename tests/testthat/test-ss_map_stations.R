# written with Claude Opus 5.5

test_that("ss_map_stations() returns a leaflet map with one marker per station", {
  skip_if_not_installed("leaflet")

  stations <- data.frame(
    station = c("Borgles Island", "Birchy Head"),
    latitude = c(44.77241, 44.5701),
    longitude = c(-62.72608, -64.034383)
  )
  m <- ss_map_stations(stations)

  expect_s3_class(m, "leaflet")
  markers <- Filter(function(x) x$method == "addCircleMarkers", m$x$calls)[[1]]
  expect_equal(markers$args[[1]], stations$latitude)
  expect_equal(markers$args[[2]], stations$longitude)
})
