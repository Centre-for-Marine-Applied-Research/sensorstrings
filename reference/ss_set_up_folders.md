# Create folders for the raw sensor string data from a given deployment

Create folders for the raw sensor string data from a given deployment

## Usage

``` r
ss_set_up_folders(
  station,
  depl_date,
  path_output = NULL,
  sensor_folders = FALSE
)
```

## Arguments

- station:

  Station name.

- depl_date:

  Deployment start date as a character string.

- path_output:

  File path to where the station folder should be created.

- sensor_folders:

  Logical argument indicating whether to create the aquameasure, hobo,
  log, and vemco folders in the deployment folder.

## Value

Creates the folder structure for storing raw sensor string data from a
single deployment.

## Examples

``` r
path <- file.path(tempdir(), "station_folders")
dir.create(path, showWarnings = FALSE)

# station folder + deployment folder
ss_set_up_folders(station = "Borgles Island", depl_date = "2019-05-30", path_output = path)
#> Created folder << borgles_island >> in << /tmp/Rtmpt63xIQ/station_folders >>

# also add the log, aquameasure, hobo, and vemco folders
ss_set_up_folders(
  station = "Borgles Island", depl_date = "2020-06-15",
  path_output = path, sensor_folders = TRUE
)

list.dirs(path, full.names = FALSE)
#> [1] ""                                                    
#> [2] "borgles_island"                                      
#> [3] "borgles_island/borgles_island_2019-05-30"            
#> [4] "borgles_island/borgles_island_2020-06-15"            
#> [5] "borgles_island/borgles_island_2020-06-15/aquameasure"
#> [6] "borgles_island/borgles_island_2020-06-15/hobo"       
#> [7] "borgles_island/borgles_island_2020-06-15/log"        
#> [8] "borgles_island/borgles_island_2020-06-15/vemco"      

unlink(path, recursive = TRUE)
```
