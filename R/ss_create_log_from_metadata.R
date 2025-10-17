#' @title Writes a deployment log from the metadata tracking sheet
#'
#' @details Imports the water quality metadata tracking sheet, filters for the
#'   station and date of interest, re-formats into the deployment log format,
#'   and exports to the Log folder.
#'
#' @param path_metadata Path to the metadata tracking sheet (including the file
#'   name and extension). This must be a .xlsx file.
#'
#' @param sheet Name of the tab with the deployment information.
#'
#' @param google_sheet Logical argument indicating whether metadata is stored in
#'   a google sheet. If \code{TRUE}, \code{path_metadata} is not required.
#'
#' @param google_sheet_link Link the to metadata sheet on google drive. If
#'   \code{NULL}, the New Brunswick metadata sheet will be imported.
#'
#' @param path_export Path to the station deployment folder.
#'
#' @param station Station name.
#'
#' @param deployment_date Date of deployment as a character string in the format
#'   "YYYY-mm-dd"
#'
#' @param to_title Logical argument indicating whether to convert the station
#'   name to title case. Default is \code{TRUE}. Set to \code{FALSE} for
#'   stations with capital letters within a word, e.g., McNabs Island.
#'
#' @return Returns deployment log in .csv format.
#'
#' @importFrom dplyr %>% if_else filter mutate transmute
#' @importFrom lubridate as_date
#' @importFrom googlesheets4 read_sheet gs4_deauth
#' @importFrom readxl read_excel
#' @importFrom stringr str_to_title
#' @importFrom utils write.csv
#'
#' @export

ss_create_log_from_metadata <- function(
    path_metadata = NULL,
    sheet = "tracker",
    google_sheet = FALSE,
    google_sheet_link = NULL,
    path_export,
    station,
    deployment_date,
    to_title = TRUE
){

  if(isFALSE(google_sheet)) {
    if(is.null(path_metadata)) {
      path_metadata <- file.path(
        "R:/tracking_sheets/metadata_tracking/water_quality_deployment_tracking.xlsx"
      )
    }

    dat_raw <- read_excel(
      path_metadata,
      sheet = sheet,
      na = ""
    )
  }

  if(isTRUE(google_sheet)) {
    gs4_deauth()

    if(is.null(google_sheet_link)) {
      google_sheet_link <- "https://docs.google.com/spreadsheets/d/1KDM8a-PkP30NNJNQMbK3SPt0tAAr3R2MeqHgIBYSVg8/edit?gid=149994636#gid=149994636"
    }

    dat_raw <- read_sheet(google_sheet_link, sheet = sheet)
  }

  if(isTRUE(to_title)) {
    station_title <- str_to_title(station)
  } else station_title <- station

  if(!(station_title %in% dat_raw$station)) {
    stop(paste0(station_title, " not found in metatdata tracking sheet"))
  }

  # remove _dd from NB metadata sheet
  colnames(dat_raw) <- gsub("tude_dd", "tude", colnames(dat_raw))

  dat <- dat_raw %>%
    mutate(
      deployment_latitude = if_else(
        is.na(deployment_latitude),
        ss_coords_from_ddm_to_dd(deployment_latitude_n_ddm),
        deployment_latitude
      ),
      deployment_longitude = if_else(
        is.na(deployment_longitude),
        -ss_coords_from_ddm_to_dd(deployment_longitude_w_ddm),
        deployment_longitude
      ),
      retrieval_latitude = if_else(
        is.na(retrieval_latitude),
        ss_coords_from_ddm_to_dd(retrieval_latitude_n_ddm),
        retrieval_latitude
      ),
      retrieval_longitude = if_else(
        is.na(retrieval_longitude),
        -ss_coords_from_ddm_to_dd(retrieval_longitude_w_ddm),
        retrieval_longitude
      )
    )

  #are_out <- any_of(c("county", "region"))

  # make log
  log <- dat %>%
    filter(
      station == !!station_title,
      deployment_date == !!as_date(deployment_date)
    ) %>%
    select(
      any_of(c("county", "region")),
      waterbody, station, lease,

      deployment_date, retrieval_date,

      deployment_latitude, deployment_longitude,
      retrieval_latitude, retrieval_longitude,
      sensor_type, sensor_serial_number, sensor_depth_m,
      string_configuration
    ) %>%
    dplyr::mutate(
      #Location_Description = str_to_title(Location_Description),
      sensor_serial_number = as.numeric(sensor_serial_number),
      sensor_depth_m = as.numeric(sensor_depth_m),
      deployment_date = format(as_date(deployment_date), "%Y-%m-%d"),
      retrieval_date = format(as_date(retrieval_date), "%Y-%m-%d"),
    )

  if (nrow(log) == 0) {
    warning(
      paste("No rows found in metatdata for << ", station, deployment_date, " >>")
    )
  }

  # Format & Export ---------------------------------------------------------
  file_name <- paste(
    station, format(as_date(deployment_date), "%Y-%m-%d"),
    "log.csv", sep = "_"
  )

  path_export <- file.path(paste0(path_export, "/log"))

  if (!dir.exists(path_export)) dir.create(path_export)

  write.csv(
    log,
    file = paste(path_export, file_name, sep = "/"),
    row.names = FALSE
  )

  message(file_name, " exported to ", path_export)
}


