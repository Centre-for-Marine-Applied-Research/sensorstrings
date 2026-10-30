# Generate file path and name to export compiled sensor string data

Generate file path and name to export compiled sensor string data

## Usage

``` r
ss_export_path(dat, prov = "ns", path = NULL, sub_folder = NULL, ext = "rds")
```

## Arguments

- dat:

  Data frame of sensor string data in wide or long format. Must include
  columns `county`, `station`, and `deployment_range`.

- prov:

  Character string indicating which province the deployment is from.
  Options are "ns" (the default) and "nb". This dictates the file path
  for where the data will be exported on the CMAR R drive.

- path:

  File path where `sub_folder` is created. If `NULL` (the default), this
  is a folder on the CMAR shared drive, dictated by the value of `prov`.

- sub_folder:

  Character string of the sub_folder name (inside county folder) where
  `dat` should be exported. Default is `sub_folder = "new"`.

- ext:

  File extension. Default is `ext = "rds"`.

## Value

A file path for exporting deployment data, including file name and
extension.

## Examples

``` r
dat <- ss_compile_deployment_data(system.file("extdata", package = "sensorstrings"))
#> aquameasure data compiled
#> hobo data compiled
#> vemco data from sensor <<  547109  >> compiled: Temperature & Seawater depth

path <- file.path(tempdir(), "deployment_data")
dir.create(file.path(path, "halifax", "new"), recursive = TRUE, showWarnings = FALSE)

ss_export_path(dat, path = path)
#> [1] "/tmp/RtmpYZ0r32/deployment_data/halifax/new/borgles_island_2019-05-30.rds"
```
