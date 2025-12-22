# Generate file path and name to export compiled sensor string data

Generate file path and name to export compiled sensor string data

## Usage

``` r
ss_export_path(dat, prov = "ns", sub_folder = NULL, ext = "rds")
```

## Arguments

- dat:

  Data frame of sensor string data in wide or long format. Must include
  columns `county`, `station`, and `deployment_range`.

- prov:

  Character string indicating which province the deployment is from.
  Options are "ns" (the default) and "nb". This dicates the file path
  for where the data will be exported on the CMAR R drive.

- sub_folder:

  Character string of the sub-folder name (inside county folder) where
  `dat` should be exported. Default is `sub-folder = "new"`.

- ext:

  File extension. Default is `ext = "rds"`.

## Value

A file path for exporting deployment data, including file name and
extension.
