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
#'
#' @examples
#' # The default (path = NULL) reads the assembled_data folder on the CMAR R
#' # drive. Here, two small county files are saved in tempdir() first.
#' dat <- ss_compile_deployment_data(system.file("extdata", package = "sensorstrings"))
#'
#' path <- file.path(tempdir(), "assembled_data")
#' dir.create(path, showWarnings = FALSE)
#'
#' saveRDS(dat[1:10, ], file.path(path, "halifax_2025-01-01.rds"))
#' saveRDS(
#'   transform(dat[11:20, ], county = "Lunenburg"),
#'   file.path(path, "lunenburg_2025-01-01.rds")
#' )
#'
#' # all counties
#' nrow(ss_import_data(path))
#'
#' # one county (the county must be part of the file name)
#' unique(ss_import_data(path, county = "Halifax")$county)
#'
#' unlink(path, recursive = TRUE)

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




