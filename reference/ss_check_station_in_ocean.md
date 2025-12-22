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
