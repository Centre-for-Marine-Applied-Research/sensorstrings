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
