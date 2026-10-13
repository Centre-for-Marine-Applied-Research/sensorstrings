# Writes deployment table for county report

Writes deployment table for county report

## Usage

``` r
ss_write_report_table(dat, keep_waterbody = FALSE, var_sep = "\n")
```

## Arguments

- dat:

  Data frame of sensor string data in wide format.

- keep_waterbody:

  Logical value indicating whether to keep the `Waterbody` column.

- var_sep:

  Separator between variables. Default will add a new line between
  variables for Word and pdf outputs.

## Examples

``` r
dat <- ss_compile_deployment_data(system.file("extdata", package = "sensorstrings"))
#> aquameasure data compiled
#> hobo data compiled
#> vemco data from sensor <<  547109  >> compiled: Temperature & Seawater depth

ss_write_report_table(dat)
#> # A tibble: 1 × 7
#>   Station    `Deployment Date` `Retrieval Date` Latitude Longitude Configuration
#>   <chr>      <chr>             <chr>               <dbl>     <dbl> <chr>        
#> 1 Borgles I… 2019-05-30        2019-10-19           44.8     -62.7 sub-surface …
#> # ℹ 1 more variable: `Variables Measured` <chr>

# keep the waterbody column, and separate variables with a comma
ss_write_report_table(dat, keep_waterbody = TRUE, var_sep = ", ")
#> # A tibble: 1 × 8
#>   Waterbody Station        `Deployment Date` `Retrieval Date` Latitude Longitude
#>   <chr>     <chr>          <chr>             <chr>               <dbl>     <dbl>
#> 1 Shoal Bay Borgles Island 2019-05-30        2019-10-19           44.8     -62.7
#> # ℹ 2 more variables: Configuration <chr>, `Variables Measured` <chr>
```
