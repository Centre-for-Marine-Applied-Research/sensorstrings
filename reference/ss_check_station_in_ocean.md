# Check station location is in the ocean (not on land)

Check station location is in the ocean (not on land)

## Usage

``` r
ss_check_station_in_ocean(log_coords, log_crs = 4617, coast_shp = NULL)
```

## Arguments

- log_coords:

  Data frame with three columns: `station`, `latitude` and `longitude`,
  i.e., with the station coordinates as recorded in the deployment log.

- log_crs:

  The crs of the coordinates in `log_coords`.

- coast_shp:

  Shapefile of the coast for comparison to the station location. The
  resolution of the shapefile can impact the results of this test.
  Coarse resolution may result in false positives for overlapping with
  land. If `NULL`, must be connected to the Perennia R drive.

## Value

Logical value. Returns `TRUE` if the log coordinates are in the ocean.
Returns `FALSE` and a Warning if the coordinates overlap with land.

## Examples

``` r
if (requireNamespace("sf", quietly = TRUE)) {
 # The default (coast_shp = NULL) reads a coastline shapefile from the CMAR
 # R drive. Here, a small square of "land" stands in for the coastline.
 land <- sf::st_sf(
 geometry = sf::st_sfc(
 sf::st_polygon(list(rbind(
   c(-64.05, 44.54), c(-64.00, 44.54), c(-64.00, 44.555),
   c(-64.05, 44.555), c(-64.05, 44.54)
   ))), crs = 4617))

   # in the water: TRUE
   print(ss_check_station_in_ocean(
   log_coords = data.frame(station = "Birchy Head", latitude = 44.57,
   longitude = -64.03), coast_shp = land ))

   # on land: FALSE with a warning
   print(ss_check_station_in_ocean(
   log_coords = data.frame(station = "Birchy Head", latitude = 44.55,
   longitude = -64.03), coast_shp = land)) }
#> [1] TRUE
#> Warning: The coordinates for station << Birchy Head >> may be on land.
#> [1] FALSE
```
