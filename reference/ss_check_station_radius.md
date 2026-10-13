# Check station location is within buffer of official coordinates

Check station location is within buffer of official coordinates

## Usage

``` r
ss_check_station_radius(
  log_coords,
  log_crs = 4617,
  station_coords = NULL,
  station_radius = 500
)
```

## Arguments

- log_coords:

  Data frame with three columns: `station`, `latitude` and `longitude`,
  i.e., with the station coordinates as recorded in the deployment log.

- log_crs:

  The crs of the coordinates in `log_coords`.

- station_coords:

  Data frame with two columns: `latitude` and `longitude`, the
  "official" station coordinates. If `NULL`, the station coordinates
  will be looked up in the AREA INFO tracking sheet.

- station_radius:

  Acceptable radius around the official station coordinates (in metres).
  Stations outside of this radius should be renamed. Default is 500 m.

## Value

Logical value. Returns `TRUE` if the log coordinates are within the
buffer radius. Returns `FALSE` and a Warning if the coordinates are
outside the buffer.

## Examples

``` r
if (requireNamespace("sf", quietly = TRUE)) {
# The default (station_coords = NULL) looks up the official coordinates in
# the STRING TRACKING Google Sheet. Supply them directly to work offline.

official <- data.frame(latitude = 44.56975, longitude = -64.03448)

# within 500 m: TRUE
print(ss_check_station_radius(
log_coords = data.frame(station = "Birchy Head", latitude = 44.5700, longitude = -64.0344),
station_coords = official
))

# about 50 km away: FALSE with a warning
print(ss_check_station_radius(
log_coords = data.frame(station = "Birchy Head", latitude = 45, longitude = -64.03),
station_coords = official
))

# a tighter radius (about 30 m away): FALSE with a warning
print(ss_check_station_radius(
log_coords = data.frame(station = "Birchy Head", latitude = 44.5700, longitude = -64.0344),
station_coords = official,
station_radius = 10
))
}
#> [1] TRUE
#> Warning: The coordinates for station << Birchy Head >> are outside of the << 500 m >> buffer from the official station location.
#> [1] FALSE
#> Warning: The coordinates for station << Birchy Head >> are outside of the << 10 m >> buffer from the official station location.
#> [1] FALSE
```
