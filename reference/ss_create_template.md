# Create file to compile and trim sensor string data

Create file to compile and trim sensor string data

## Usage

``` r
ss_create_template(
  station = NULL,
  depl_date = NULL,
  initials = "",
  path = NULL
)
```

## Arguments

- station:

  Character string of the station name. Will be converted to lower case,
  and all spaces will be replaced with an underscore.

- depl_date:

  Character string of the deployment data in the order yyyy-mm-dd.

- initials:

  Initials of Data Analyst. Default is "".

- path:

  Path to folder where file will be created. Default is the CMAR R drive
  in folder \<\< station \>\> / \<\< station_depl_date \>\>. Must be
  connected to the Perennia VPN.

## Value

Creates an R file for compiling and trimming data for the specified
deployment. A message indicates if template file was successfully
copied.
