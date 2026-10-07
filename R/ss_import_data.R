#' @title Import Water Quality data from rds files
#'
#' @param path Path to the *.rds files to be assembled. Default is the
#'   assembled_data folder on the CMAR R drive (user must be connected to the
#'   Perennia VPN).
#'
#' @param county Vector of character string(s) indicating which county or
#'   counties for which to import data. For efficiency, the filter is applied to
#'   the file path, so the county name MUST be part of the file path. Defaults
#'   to all counties.
#'
#' @importFrom purrr map_dfr
#' @importFrom stringr str_subset
#' @export

ss_import_data <- function(path = NULL, county = "all") {

  county <- tolower(county)
  county <- gsub(" ", "_", county)

  message("importing ", paste(county, collapse = " and "), " data...")

  # path --------------------------------------------------------------

  if(is.null(path)){
    path <- file.path(
      "R:/data_branches/water_quality/processed_data/assembled_data")
  }

  # list rds files on the path and import -----------------------------------

  dat <- list.files(path, full.names = TRUE, pattern = ".rds")

  # filter for specified county(ies)
  # format county argument as a regular expression for use in str_subset
  if(!("all" %in% county)) dat <- dat |> str_subset(paste(county, collapse = "|"))

  # read and bind the rds files
  dat |>
    purrr::map_dfr(readRDS)

}




