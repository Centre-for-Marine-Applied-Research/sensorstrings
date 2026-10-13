# Convert coordinate columns from degree decimal minutes to decimal degrees

Finds every column in `dat` whose name ends in `_n_ddm`, `_s_ddm`,
`_e_ddm` or `_w_ddm` (e.g., `deployment_latitude_n_ddm`,
`retrieval_longitude_w_ddm`) and converts it to decimal degrees.

The sign comes from the hemisphere letter in the column name: `_s_` and
`_w_` columns are returned as negative values; `_n_` and `_e_` columns
as positive values.

The result goes in a column with the hemisphere and `_ddm` removed
(`deployment_latitude_n_ddm` becomes `deployment_latitude`). If that
column already exists, only its `NA` values are filled in, so
coordinates already recorded in decimal degrees are kept.

## Usage

``` r
ss_convert_coords_from_ddm_to_dd(dat, keep_ddm = TRUE)
```

## Arguments

- dat:

  Data frame with at least one `*_n_ddm`, `*_s_ddm`, `*_e_ddm` or
  `*_w_ddm` column. Values must be in the form "degrees
  decimal-minutes", e.g., "45 21.651" or "64 2.063".

- keep_ddm:

  Logical argument indicating whether to keep the `*_ddm` columns.
  Default is `TRUE`.

## Value

Returns `dat` with the decimal-degree columns added or filled in.

## Examples

``` r
dat <- data.frame(
  station = c("Borgles Island", "Birchy Head"),
  deployment_latitude_n_ddm = c("44 46.345", "44 34.206"),
  deployment_longitude_w_ddm = c("62 43.565", "64 2.063")
)

ss_convert_coords_from_ddm_to_dd(dat)
#>          station deployment_latitude_n_ddm deployment_longitude_w_ddm
#> 1 Borgles Island                 44 46.345                  62 43.565
#> 2    Birchy Head                 44 34.206                   64 2.063
#>   deployment_latitude deployment_longitude
#> 1            44.77242            -62.72608
#> 2            44.57010            -64.03438

# existing decimal-degree values are kept; only the NA values are filled in
dat$deployment_latitude <- c(44.77241, NA)
ss_convert_coords_from_ddm_to_dd(dat, keep_ddm = FALSE)
#>          station deployment_latitude deployment_longitude
#> 1 Borgles Island            44.77241            -62.72608
#> 2    Birchy Head            44.57010            -64.03438
```
