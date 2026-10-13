# Check station deployment and retrieval locations are within acceptable distance

Check station deployment and retrieval locations are within acceptable
distance

## Usage

``` r
ss_check_station_drift(
  log_coords,
  log_crs = 4617,
  max_drift = 100,
  return_drift = FALSE
)
```

## Arguments

- log_coords:

  Data frame with five columns: `station`, `latitude` and `longitude`
  (the coordinates recorded at deployment) and retrieval_latitude and
  retrieval_longitude (the coordinates recorded during retrieval).

- log_crs:

  The crs of the coordinates in `log_coords`.

- max_drift:

  The maximum acceptable distance between the deployment and retrieval
  coordinates in metres.

- return_drift:

  Logical argument indicating whether to return the drift distance.

## Value

Logical value. Returns `TRUE` if the distance between deployment and
retrieval coordinates is less than `max_drift`. Returns `FALSE` and a
Warning if the distance is greater.

## Examples

``` r
if (requireNamespace("sf", quietly = TRUE)) {
 # deployment and retrieval coordinates are the same
 log_coords <- data.frame(
 station = "Birchy Head",
 latitude = 44.56, longitude = -64.03,
 retrieval_latitude = 44.56, retrieval_longitude = -64.03
 )
 print(ss_check_station_drift(log_coords))
 # retrieval coordinates about 5.5 km east: returns FALSE with a warning
 log_coords$retrieval_longitude <- -63.96
 print(ss_check_station_drift(log_coords))

 # return the drift distance (m) instead of TRUE/FALSE
 print(ss_check_station_drift(log_coords, return_drift = TRUE))
 }
#> [1] TRUE
#> Warning: The deployment and retrieval coordinates for station << Birchy Head >> are << 5545.98 >> m apart.
#> Maximum acceptable distance is 100m
#> [1] FALSE
#> Warning: The deployment and retrieval coordinates for station << Birchy Head >> are << 5545.98 >> m apart.
#> Maximum acceptable distance is 100m
#> [1] 5545.98
```
