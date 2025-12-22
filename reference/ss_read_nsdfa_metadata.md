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

\*\*Might want to add 2021-08-27 1042 deployment
