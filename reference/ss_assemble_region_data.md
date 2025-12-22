# Assemble region data

Assemble region data

## Usage

``` r
ss_assemble_region_data(prov = "ns", folder)
```

## Arguments

- prov:

  Character string indicating which province the data to be assembled is
  from. Options are "ns" (the default) and "nb". This dictates the file
  path for where the data will be exported on the CMAR R drive.

- folder:

  Name of the folder where the rds files are saved.

## Value

Returns a data.frame with data from all deployments in folder.
