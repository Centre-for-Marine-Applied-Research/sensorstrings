
test_that("ss_check_station_radius() returns correct result", {

  skip_if_offline()

  expect_true(
    ss_check_station_radius(
      log_coords = data.frame(
        station = "Birchy Head",
        latitude = 44.56975, longitude = -64.03448
      ),
      log_crs = 4617,
      station_coords = NULL,
      station_radius = 500
    )
  )

  expect_warning(
    ss_check_station_radius(
      log_coords = data.frame(
        station = "Birchy Head",
        latitude = 45, longitude = -64.03
      ),
      log_crs = 4617,
      station_coords = NULL,
      station_radius = 500
    )
  )

})

test_that("ss_check_station_station_drift() returns correct result", {

  expect_true(
    ss_check_station_drift(
      log_coords = data.frame(
        station = "Birchy Head",
        latitude = 44.56, longitude = -64.03,
        retrieval_latitude = 44.56,
        retrieval_longitude = -64.03
      ),
      log_crs = 4617)
  )

  expect_warning(
    ss_check_station_drift(
      log_coords = data.frame(
        station = "Birchy Head",
        latitude = 44.55, longitude = -64.03,
        retrieval_latitude = 44.55,
        retrieval_longitude = -63.96
      ),
      log_crs = 4617)
  )

})

# written with Claude Opus 5.5
# Offline tests for ss_check_station_radius() and ss_check_station_in_ocean();
# can be appended to test-ss_check_station_location.R

official <- data.frame(latitude = 44.56975, longitude = -64.03448)
near <- data.frame(station = "Birchy Head", latitude = 44.5700, longitude = -64.0344)

test_that("ss_check_station_radius() works with supplied station_coords", {
  skip_if_not_installed("sf")

  expect_true(ss_check_station_radius(near, station_coords = official))
  expect_warning(
    expect_false(ss_check_station_radius(near, station_coords = official, station_radius = 10)),
    "outside"
  )
  expect_error(
    ss_check_station_radius(near, station_coords = rbind(official, official)),
    "More than one"
  )
})

test_that("ss_check_station_in_ocean() flags coordinates on land", {
  skip_if_not_installed("sf")

  # a small square of "land" stands in for the coastline shapefile
  land <- sf::st_sf(geometry = sf::st_sfc(sf::st_polygon(list(rbind(
    c(-64.05, 44.54), c(-64.00, 44.54), c(-64.00, 44.555),
    c(-64.05, 44.555), c(-64.05, 44.54)
  ))), crs = 4617))

  expect_true(ss_check_station_in_ocean(
    data.frame(station = "A", latitude = 44.57, longitude = -64.03), coast_shp = land
  ))
  expect_warning(
    expect_false(ss_check_station_in_ocean(
      data.frame(station = "A", latitude = 44.55, longitude = -64.03), coast_shp = land
    )),
    "may be on land"
  )
})

