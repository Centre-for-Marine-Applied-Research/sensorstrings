# Trim data to specified start and end dates.

4 hours adde to end_date to account for AST (e.g., in case the sensor
was retrieved after 20:00 AST, which is 00:00 UTC \*\*The next day\*\*)

## Usage

``` r
trim_data(dat, start_date, end_date)
```

## Arguments

- dat:

  Data frame with at least one column. Column name must include the
  string "timestamp".

- start_date:

  POSIXct/POSIXt value of the first good timestamp.

- end_date:

  POSIXct/POSIXt value of the last good timestamp.

## Value

Returns dat trimmed.
