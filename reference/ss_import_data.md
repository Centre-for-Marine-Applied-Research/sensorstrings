# Import Water Quality data from rds files

Import Water Quality data from rds files

## Usage

``` r
ss_import_data(path = NULL, county = "all")
```

## Arguments

- path:

  Path to the \*.rds files to be assembled. Default is the
  assembled_data folder on the CMAR R drive (user must be connected to
  the Perennia VPN).

- county:

  Vector of character string(s) indicating which county or counties for
  which to import data. For efficiency, the filter is applied to the
  file path, so the county name MUST be part of the file path. Defaults
  to all counties.

## Examples

``` r
# The default (path = NULL) reads the assembled_data folder on the CMAR R
# drive. Here, two small county files are saved in tempdir() first.
dat <- ss_compile_deployment_data(system.file("extdata", package = "sensorstrings"))
#> aquameasure data compiled
#> hobo data compiled
#> vemco data from sensor <<  547109  >> compiled: Temperature & Seawater depth

path <- file.path(tempdir(), "assembled_data")
dir.create(path, showWarnings = FALSE)

saveRDS(dat[1:10, ], file.path(path, "halifax_2025-01-01.rds"))
saveRDS(
  transform(dat[11:20, ], county = "Lunenburg"),
  file.path(path, "lunenburg_2025-01-01.rds")
)

# all counties
nrow(ss_import_data(path))
#> importing all data...
#> [1] 20

# one county (the county must be part of the file name)
unique(ss_import_data(path, county = "Halifax")$county)
#> importing halifax data...
#> [1] "Halifax"

unlink(path, recursive = TRUE)
```
