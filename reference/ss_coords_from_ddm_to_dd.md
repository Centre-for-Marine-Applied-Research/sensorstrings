# Convert coordinates from degree-minute-decimal to decimal degree

To apply to multiple columns using
[`dplyr::across`](https://dplyr.tidyverse.org/reference/across.html):

## Usage

``` r
ss_coords_from_ddm_to_dd(coords_ddm)
```

## Arguments

- coords_ddm:

  Vector of coordinate values in degree decimal minutes (xx xx.xxxx,
  e.g., 45 21.651 or 64 2.063). These will be converted to decimal
  degrees.

## Value

Returns a vector of coordinates in decimal-degree format.

## Details

1\. Define variables to convert:

coords_ddm \<- c("deployment_latitude_n_ddm",
"deployment_longitude_w_ddm", "retrieval_latitude_n_ddm",
"retrieval_longitude_w_ddm")

2\. Use the .names argument to specify new column names so that the
original columns are not over-written:

`dat <- dat_raw ~ss_coords_from_ddm_to_dd(.x), .names = "{str_remove(.col, '_w_ddm|_n_ddm')}" ))`
