# Create file to compile and trim sensor string data

Create file to compile and trim sensor string data

## Usage

``` r
ss_create_template(station, depl_date, initials = "", path = NULL)
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

Invisibly returns the path to the template file. Creates the file if it
doesn't already exist. Otherwise, returns a Warning and leaves the file
unchanged.

## Examples

``` r
# The default (path = NULL) writes to the station folder on the CMAR R drive.
# Here the template is written to tempdir().
template <- ss_create_template(
  station = "Borgles Island",
  depl_date = "2019-05-30",
  initials = "DD",
  path = tempdir()
)
#> Created '.R' file
#> '.R' contents copied
#> Template created in /tmp/RtmpeOK1wy

head(readLines(template), 20)
#>  [1] "# DATE: 2026-10-28"                                                                  
#>  [2] "# NAME: DD"                                                                          
#>  [3] "# sensorstrings VERSION: 2.0.2"                                                      
#>  [4] ""                                                                                    
#>  [5] "# Template for compiling & formatting data extracted from a sensor string deployment"
#>  [6] "# Exports compiled data as an rds file in the specified folder"                      
#>  [7] ""                                                                                    
#>  [8] "# Must be connected to Perennia vpn"                                                 
#>  [9] ""                                                                                    
#> [10] "# SECTION 1: Generate File Path"                                                     
#> [11] "# Update station and depl_date with the station name and deployment date of interest"
#> [12] ""                                                                                    
#> [13] "# SECTION 2: Compile & View"                                                         
#> [14] ""                                                                                    
#> [15] "# SECTION 3: Check station location Check station coordinates are within 500 m"      
#> [16] "# of official coordinates and are in the ocean."                                     
#> [17] ""                                                                                    
#> [18] "# SECTION 4: Identify Trim Dates"                                                    
#> [19] "# use the trimdates app to zoom in on the start and end of the deployment"           
#> [20] "# record the timestamp of the first and last observations"                           

# a second call leaves the existing file alone and gives a warning
ss_create_template(
  station = "Borgles Island", depl_date = "2019-05-30", path = tempdir()
)
#> Warning: New template was not generated.
#> File already exists: /tmp/RtmpeOK1wy/compile_borgles_island_2019-05-30.R

unlink(template)
```
