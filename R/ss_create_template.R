#' Create file to compile and trim sensor string data
#'
#' @param station Character string of the station name. Will be converted to
#'   lower case, and all spaces will be replaced with an underscore.
#'
#' @param depl_date Character string of the deployment data in the order
#'   yyyy-mm-dd.
#'
#' @param initials Initials of Data Analyst. Default is "".
#'
#' @param path Path to folder where file will be created. Default is the CMAR R
#'   drive in folder << station >> / << station_depl_date >>. Must be connected
#'   to the Perennia VPN.
#'
#' @return Creates an R file for compiling and trimming data for the specified
#'   deployment. A message indicates if template file was successfully copied.
#'
#' @importFrom utils packageVersion
#'
#' @export

ss_create_template <- function(
    station = NULL, depl_date = NULL, initials = "", path = NULL
) {

  if(is.null(station)) {
    stop("'station' must be a character string")
  }

  # check date in correct format
  if (is.na(as.Date(depl_date, format = "%Y-%m-%d"))) {
    stop("'depl_date' in incorrect format. Should be yyyy-mm-dd.")
  }

  # TODO compare station to list in metadata tracking or cmpr

  station <- tolower(gsub(" ", "_", station))

  if(is.null(path)) {
    path <- file.path("R:/data_branches/water_quality/station_folders")

    path <- paste(path, station, paste(station, depl_date, sep = "_"), sep = "/")
  }
  # error if path not found
  if(isFALSE(dir.exists(path))) {
    stop("file path does not exist: ", path)
  }

  new_file <- paste0(path, "/compile_", station, "_", depl_date, ".R")

  if (!file.exists(new_file)) {

    file.create(new_file)
    message("Created '.R' file")

    # copy lines to .R file
    r_txt <- readLines(
      system.file("templates/compile_template.R",
                  package = "sensorstrings",
                  mustWork = TRUE)
    )
    # replace placeholder text with variables
    r_txt <- gsub(
      pattern = "x_date",
      replacement = Sys.Date(),
      x = r_txt
    )
    r_txt <- gsub(
      pattern = "x_initials",
      replacement = initials,
      x = r_txt
    )
    r_txt <- gsub(
      pattern = "x_version",
      replacement = packageVersion("sensorstrings"),
      x = r_txt
    )
    r_txt <- gsub(
      pattern = "x_station",
      replacement = paste0("\"", station, "\""),
      x = r_txt
    )
    r_txt <- gsub(
      pattern = "x_depl_date",
      replacement = paste0("\"", depl_date, "\""),
      x = r_txt
    )
    # write to new file
    writeLines(r_txt, con = new_file)
    message("'.R' contents copied")
    message("Template created in ", path)
  } else {
    warning(
      "New template was not generated.\nFile already exists: ", path
    )
  }

}
