# Convert timestamp to datetime

Convert timestamp to datetime

## Usage

``` r
convert_timestamp_to_datetime(dat, parse_orders = NULL)
```

## Arguments

- dat:

  Data frame with at least one column, `timestamp_` that has datetimes
  as character values.

- parse_orders:

  A character vector of date-time formats. If `NULL` (the default), a
  vector of several year-month-day hour-minute-second and day-month-year
  hour-minute-second orders are provided. The order must be explicitly
  specified if the month is provided first. Passed to
  `lubridate::paste_date_time()`.

## Details

Converts the timestamp\_ column to a POSIXct object. Every datetime
entry must be in the same order.
