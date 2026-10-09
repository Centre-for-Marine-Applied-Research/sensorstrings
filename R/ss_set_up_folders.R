#' Create folders for the raw sensor string data from a given deployment
#'
#' @param path_output File path to where the station folder should be created.
#'
#' @param station Station name.
#'
#' @param depl_date Deployment start date as a character string.
#'
#' @param sensor_folders Logical argument indicating whether to create the
#'   aquameasure, hobo, log, and vemco folders in the deployment folder.
#'
#' @return Creates the folder structure for storing raw sensor string data from
#'   a single deployment.
#'
#' @importFrom lubridate parse_date_time
#' @importFrom stringr str_detect str_to_lower str_replace_all
#'
#' @export
#' @examples
#' path <- file.path(tempdir(), "station_folders")
#' dir.create(path, showWarnings = FALSE)
#'
#' # station folder + deployment folder
#' ss_set_up_folders(station = "Borgles Island", depl_date = "2019-05-30", path_output = path)
#'
#' # also add the log, aquameasure, hobo, and vemco folders
#' ss_set_up_folders(
#'   station = "Borgles Island", depl_date = "2020-06-15",
#'   path_output = path, sensor_folders = TRUE
#' )
#'
#' list.dirs(path, full.names = FALSE)
#'
#' unlink(path, recursive = TRUE)

ss_set_up_folders <- function(
    station,
    depl_date,
    path_output = NULL,
    sensor_folders = FALSE) {
  parse_orders <- c("Ymd", "ymd", "dmY", "dmy", "mdY", "mdy")

  # check date in correct format
  if(!grepl("^\\d{4}-\\d{2}-\\d{2}$", depl_date)) {
    # if (is.na(as.Date(depl_date, format = "%Y-%m-%d"))) {
    stop("'depl_date' in incorrect format. Must be yyyy-mm-dd.")
  }

  station_folders <- list.files(path_output)

  # ensure station is converted to snake case
  station_snake <- tolower(gsub(" ", "_", station))

  # if the station folder does not exist, create it
  if (!(station_snake %in% station_folders)) {
    dir.create(paste0(path_output, "/", station_snake))

    message("Created folder << ", station_snake, " >> in <<", path_output, " >>")
  }

  path_output <- paste0(path_output, "/", station_snake)

  depl_folders <- list.files(path_output)

  new_folder <- paste(station_snake, depl_date, sep = "_")

  # if depl folder already exists, stop
  if (new_folder %in% depl_folders) {
    stop("Deployment folder << ", new_folder, " >> already exists in << ", path_output, " >>")
  }

  path_output <- paste0(path_output, "/", new_folder)

  dir.create(path_output)

  if (isTRUE(sensor_folders)) {
    dir.create(paste0(path_output, "/log"))
    dir.create(paste0(path_output, "/aquameasure"))
    dir.create(paste0(path_output, "/hobo"))
    dir.create(paste0(path_output, "/vemco"))
  }
}
