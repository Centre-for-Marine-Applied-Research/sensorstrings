# Import TempMetaData tab from the NSDFA tracking sheet

Import TempMetaData tab from the NSDFA tracking sheet

## Usage

``` r
ss_read_nsdfa_metadata(path)
```

## Arguments

- path:

  Path to the NSDFA tracking sheet (include file name and extension).

## Value

Returns data frame of NSDFA tracking sheet sensor string metadata.

## Details

Reads in the TempMetaData tab from the NSDFA tracking sheet and corrects
known errors (e.g., standardizes station and waterbody spellings, fixes
deployment dates, etc.).

## Examples

``` r
# A small synthetic version of the NSDFA tracking sheet (TempMetaData tab).
# The function fixes misspelled stations and waterbodies, removes times from
# the dates, and makes positive longitudes negative. tidyr gives an
# "Expected 2 pieces" warning for dates that have no time; this is expected.

nsdfa <- ss_read_nsdfa_metadata(
system.file("extdata/nsdfa_tracking_example.xlsx",  package = "sensorstrings"))

nsdfa[, c("County", "Waterbody", "Station_Name", "Depl_Date", "Recv_Date", "Depl_Lon")]
#> # A tibble: 4 × 6
#>   County      Waterbody         Station_Name      Depl_Date  Recv_Date  Depl_Lon
#>   <chr>       <chr>             <chr>             <date>     <date>        <dbl>
#> 1 Halifax     Piper Lake        Piper Lake        2019-05-30 2019-10-19    -62.7
#> 2 Lunenburg   St. Margarets Bay Owls Head         2020-06-01 2020-11-20    -64.0
#> 3 Digby       St. Marys Bay     Sandy Cove St. M… 2021-07-15 2022-01-10    -66.0
#> 4 Guysborough Whitehead Harbour Bald Rock         2015-09-08 2015-11-01    -61.4
```
