# DATE: x_date
# NAME: x_initials
# sensorstrings VERSION: x_version

# Template for compiling & formatting data extracted from a sensor string deployment
# Exports compiled data as an rds file in the specified folder

# Must be connected to Perennia vpn

# SECTION 1: Generate File Path
# Update station and depl_date with the station name and deployment date of interest

# SECTION 2: Compile & View

# SECTION 3: Check station location Check station coordinates are within 500 m
# of official coordinates and are in the ocean.

# SECTION 4: Identify Trim Dates
# use the trimdates app to zoom in on the start and end of the deployment
# record the timestamp of the first and last observations

# SECTION 5: Trim Data
# if all sensors start recording good data around the same time, use this code

# SECTION 6: Export Data
# export compiled data as an rds file in the county/new folder


library(dplyr)
library(lubridate)
library(sensorstrings)

# SECTION 1: **Generate File Path** -------------------------------------------------------------

station <- x_station
depl_date <- x_depl_date

path <- ss_import_path(station, depl_date)

# SECTION 2: Compile & View -----------------------------------------------------------------

# create log from metadata
ss_create_log_from_metadata(
  station = station,
  deployment_date = depl_date,
  path_export = path
)

dat_raw <- ss_compile_deployment_data(path)

ss_ggplot_variables(dat_raw)


# SECTION 3: Check Station Location ---------------------------------------

log <- read.csv(
  list.files(paste0(path, "/log"), pattern = "csv", full.names = TRUE)
)

st_location <- data.frame(
  station = tools::toTitleCase(gsub("_", " ", station)),
  latitude = unique(log$deployment_latitude),
  longitude = unique(log$deployment_longitude),
  retrieval_latitude = unique(log$retrieval_latitude),
  retrieval_longitude = unique(log$retrieval_longitude)
)


ss_leaflet_station_map(st_location)

ss_check_station_radius(st_location)
ss_check_station_in_ocean(st_location) # slow because reads in shape file
ss_check_station_drift(st_location, return_drift = TRUE) # need retrieval coords

# SECTION 4: Identify Trim Dates --------------------------------------------------------------
# if the app viewer is blank, click "Open in Browser"
# close the app between deployment start and deployment end

# deployment start
ss_open_trimdates_app(dat_raw, filter_to = "start", period = "2 days")

# enter timestamp for first GOOD observation:
depl_start <- as_datetime("2024-09-19 15:35:05")

# deployment end
ss_open_trimdates_app(dat_raw, filter_to = "end", period = "2 days")

# enter timestamp for last GOOD observation:
depl_end <- as_datetime('2025-04-23 17:43:06')


# SECTION 5: Trim Data --------------------------------------------------------------

dat <- dat_raw %>%
  filter(timestamp_utc >= depl_start, timestamp_utc <= depl_end)

# review and adjust if necessary
ss_open_trimdates_app(dat, filter_to = "start", period = "2 days")
ss_open_trimdates_app(dat, filter_to = "end", period = "2 days")

ss_ggplot_variables(dat)


# SECTION 6: Export Data ------------------------------------------------------------------

export_path <- ss_export_path(dat, ext = "rds")

saveRDS(dat, export_path)

