# January 15, 2021

# read in raw data, filter to make the file size smaller, and export to inst/extdata

# library(dplyr)
# library(readr)
# library(lubridate)
# library(stringr)
library(writexl)

#' @importFrom here here
#' @importFrom data.table fwrite
#' @importFrom dplyr row_number

# path <- system.file("data-raw", package = "sensorstrings")
path <- here()

# aquaMeasure -------------------------------------------------------------

aquameasure_raw <- ss_read_aquameasure_data(
  path = paste0(path, "/aquameasure"),
  file_name = "aquaMeasure-670364.csv"
)

aquameasure <- aquameasure_raw %>%
  dplyr::filter(dplyr::row_number() %% 40 == 0)

data.table::fwrite(aquameasure, file = "inst/extdata/aquameasure/aquameasure-670364.csv")


# hobo --------------------------------------------------------------------

hobo_raw <- ss_read_hobo_data(
  path = paste0(path, "/data-raw/hobo"),
  file_name = "10755220.csv"
)

hobo <- hobo_raw %>%
  dplyr::filter(dplyr::row_number() %% 4 == 0)

data.table::fwrite(hobo, file = "inst/extdata/hobo/10755220.csv")


# Vemco -------------------------------------------------------------------

vemco_raw <- ss_read_vemco_data(
  path = paste0(path, "/data-raw/vemco"),
  file_name = "vemco-547109.csv"
)

vemco <- vemco_raw %>%
  dplyr::filter(dplyr::row_number() %% 15 == 0)

data.table::fwrite(vemco, file = "inst/extdata/vemco/vemco-547109.csv")



# example spreadsheets ----------------------------------------------------

# Modified from code Generated with Claude Opus 5.5
#
# Builds the two small, synthetic example spreadsheets used by
# sensorstrings-examples.R. Neither file holds real tracking-sheet data.
#
# metadata_tracking_example.xlsx ------------------------------------------
# Mimics the "tracker" tab of the water quality metadata tracking sheet,
# for the example Borgles Island deployment
# Used by ss_create_log_from_metadata().

tracker <- data.frame(
  county = "Halifax",
  waterbody = "Shoal Bay",
  station = "Borgles Island",
  lease = NA_character_,
  deployment_date = "2019-05-30",
  retrieval_date = "2019-10-19",
  deployment_latitude = 44.77241,
  deployment_longitude = -62.72608,
  retrieval_latitude = 44.77241,
  retrieval_longitude = -62.72608,
  deployment_latitude_n_ddm = "44 46.345",
  deployment_longitude_w_ddm = "62 43.565",
  retrieval_latitude_n_ddm = "44 46.345",
  retrieval_longitude_w_ddm = "62 43.565",
  sensor_type = c("HOBO Pro V2", "aquaMeasure DOT", "VR2AR"),
  sensor_serial_number = c(10755220, 670364, 547109),
  sensor_depth_m = c(2, 5, 15),
  string_configuration = "sub-surface buoy"
)

# a second deployment, so the example shows the filter working
tracker2 <- tracker
tracker2$station <- "Birchy Head"
tracker2$waterbody <- "St. Margarets Bay"
tracker2$deployment_date <- "2024-05-02"
tracker2$retrieval_date <- "2024-11-21"

writexl::write_xlsx(
  list(tracker = rbind(tracker, tracker2)),
  "inst/extdata/metadata_tracking_example.xlsx"
)

# nsdfa_tracking_example.xlsx ---------------------------------------------
# Mimics the "TempMetaData" tab of the NSDFA tracking sheet.
# ss_read_nsdfa_metadata() reads exactly 40 columns: 30 kept, 10 skipped.
# Only the column positions and the names used by the function
# (County, Waterbody, Station_Name, Depl_Date, Recv_Date, Depl_Lon) matter;
# the other names are placeholders.
# Rows include known misspellings that the function corrects.

n <- 4
nsdfa <- data.frame(
  # 1-9: guess
  County = c("Halifax", "Lunenburg", "Digby", "Guysborough"),
  Waterbody = c("Pipers lake", "St Margarets Bay", "St Marys Bay", "Tor Bay"),
  Station_Name = c("Pipers lake", "Owls head", "Sandy cove", "Bald Rock"),
  Lease = NA_character_,
  Status = "retrieved",
  Program = "Coastal Monitoring",
  Depl_Attendant = "AB",
  Recv_Attendant = "CD",
  Sensor_Count = c(3, 2, 4, 3),
  # 10: date, 11: text
  Depl_Date = as.POSIXct(
    c("2019-05-30 10:15:00", "2020-06-01", "2021-07-15", "2015-07-29"),
    tz = "UTC"
  ),
  Depl_Time = "10:15",
  # 12-14: numeric (one positive longitude, which the function fixes)
  Depl_Lat = c(44.772, 44.570, 44.433, 45.180),
  Depl_Lon = c(-62.726, 64.034, -66.050, -61.350),
  Depl_Sounding = c(20, 42, 15, 18),
  # 15: text, 16: date, 17: text
  Depl_Notes = NA_character_,
  Recv_Date = as.POSIXct(
    c("2019-10-19", "2020-11-20 14:00:00", "2022-01-10", "2015-11-01"),
    tz = "UTC"
  ),
  Recv_Time = "14:00",
  # 18-20: numeric
  Recv_Lat = c(44.772, 44.570, 44.433, 45.180),
  Recv_Lon = c(-62.726, -64.034, -66.050, -61.350),
  Recv_Sounding = c(20, 42, 15, 18),
  # 21-30: guess
  Logger_Model = "HOBO Pro V2",
  Serial = c(10755220, 20763553, 21429532, 20308042),
  Sensor_Depth = c(2, 5, 10, 15),
  Config = "sub-surface buoy",
  Anchor = "1 Railway Wheel",
  Float = "14in hard vinyl",
  Rope = "3/8in",
  Photos = "N/A",
  Data_Status = "processed",
  Notes = NA_character_,
  # 31-40: skipped by the function
  Extra_1 = NA, Extra_2 = NA, Extra_3 = NA, Extra_4 = NA, Extra_5 = NA,
  Extra_6 = NA, Extra_7 = NA, Extra_8 = NA, Extra_9 = NA, Extra_10 = NA
)
stopifnot(ncol(nsdfa) == 40, nrow(nsdfa) == n)

writexl::write_xlsx(
  list(TempMetaData = nsdfa),
   "inst/extdata/nsdfa_tracking_example.xlsx"
)




