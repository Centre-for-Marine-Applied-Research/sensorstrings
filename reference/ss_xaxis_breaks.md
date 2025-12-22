# Returns nice major and minor breaks and label format based on timespan of the data

Returns nice major and minor breaks and label format based on timespan
of the data

## Usage

``` r
ss_xaxis_breaks(dat)
```

## Arguments

- dat:

  Data frame with at least one column: `timestamp_utc` (POSIXct).

## Value

Returns a dataframe with 1 observation of 3 variables
`date_breaks_major`, `date_breaks_minor`, `date_labels_format`.
