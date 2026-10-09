#' Read in deployment log
#'
#' The log must be saved in .csv, .xlsx or .xls format. Value checks are applied
#' in \code{ss_parse_log()}.
#'
#' @inheritParams ss_parse_log
#'
#' @param path File path to the log folder, or full path to the log file,
#'   include file name and extension. The function will stop with an Error if
#'   there is more than one eligible file (csv, .xlsx or .xls) in the log
#'   folder.
#'
#' @param parse Logical argument indicating whether to parse log into a list
#'   used by \code{ss_compile_*} functions.
#'
#' @return If \code{parse = TRUE} (the default), returns a list of deployment
#'   metadata from \code{ss_parse_log()}. Otherwise returns a data frame of the
#'   metadata.
#'
#' @importFrom data.table fread
#' @importFrom readxl read_excel
#' @importFrom stringr str_extract
#' @importFrom utils file_test
#'
#' @export
#' @examples
#' # path to the deployment folder (which holds the Log folder)
#' path <- system.file("extdata", package = "sensorstrings")
#'
#' # parsed into the list used by the ss_compile_*() functions
#' log <- ss_read_log(path)
#' log$sn_table
#'
#' # the log as a data frame
#' ss_read_log(path, parse = FALSE)
#'
#' # or the full path to the log file
#' ss_read_log(
#'   file.path(path, "Log", "borgles_island_2019-05-30_log.csv"),
#'   parse = FALSE
#' )

ss_read_log <- function(
    path,
    parse = TRUE,
    verbose = TRUE,
    deployment_dates = TRUE,
    area_info = TRUE,
    sn_table = TRUE,
    config = TRUE
) {
  # Read in log -----------------------------------------------------------

  if (length(path) > 1) {
    stop("More than one file path detected")
  }

  # if path goes to the deployment folder, finish with log folder + file name + extension
  if (isFALSE(utils::file_test("-f", path))) {

    folder <- list.files(path) |>
      str_extract(regex("log", ignore_case = TRUE)) |>
      na.omit()

    path <- paste0(path, "/", folder)

    dat_files <- list.files(path, all.files = FALSE, pattern = "\\.xlsx$|\\.xls$|\\.csv$")

    # remove files that start with "~"
    if (any(substring(dat_files, 1, 1) == "~")) {
      dat_files <- dat_files[-which(substring(dat_files, 1, 1) == "~")]
    }
    if (length(dat_files) > 1) {
      stop("More than one file found in the log folder")
    }
    path <- paste(path, dat_files, sep = "/")
  }

  # file extension
  file_type <- extract_file_extension(path)

  if (file_type == "xls" | file_type == "xlsx") {
    log <- read_excel(path, na = c("", "n/a", "N/A", "NA"))
  }

  if (file_type == "csv") {
    log <- fread(
      path,
      data.table = FALSE,
      na.strings = c("", "n/a", "N/A", "NA")
    )
  }

  if(isTRUE(parse)) {
    log <- ss_parse_log(
      log,
      deployment_dates = deployment_dates,
      area_info = area_info,
      sn_table = sn_table,
      config = config,
      verbose = verbose)
  }

  log
}


#' Extract information from deployment log
#'
#' The function will attempt to parse the following columns: \code{county},
#' \code{waterbody},\code{station}, \code{lease}, \code{deployment_date},
#' \code{retrieval_date}, \code{deployment_latitude},
#' \code{deployment_longitude}, \code{sensor_type}, \code{sensor_serial_number},
#' \code{sensor_depth_m}. Missing information will be filled in with \code{NA}.
#'
#'
#' If \code{verbose = TRUE}, a message will be printed if there is more than one
#' unique entry in \code{waterbody}, \code{station}, \code{deployment_date},
#' \code{retrieval_date}, \code{deployment_latitude}, or
#' \code{deployment_longitude}.
#'
#' Entries in the \code{sensor_type} column must include the string
#' "aquameasure", "hobo", "tidbit", or "vr2ar" (not case sensitive).
#'
#' A Warning message is printed when the function does not recognize a sensor in
#' the log.
#'
#' Code will stop with an error if \code{deployment_longitude} is a positive
#' value.
#'
#'
#' @param log Log data frame, e.g., as exported from \code{ss_read_log()}.
#'
#' @param deployment_dates Logical argument indicating whether to parse and
#'   return the deployment and retrieval dates.
#'
#' @param area_info Logical argument indicating whether to parse and return the
#'   location details.
#'
#' @param sn_table Logical argument indicating whether to parse and return the
#'   serial numbers and sensor depth.
#'
#' @param config Logical argument indicating whether to parse and return the
#'   string configuration.
#'
#' @param verbose Logical argument indicating whether to print messages when
#'   values are missing. Warnings will still be printed.
#'
#' @return Returns a list with up to 4 elements. \code{deployment_dates} is a
#'   data frame with two columns: \code{start_date} and \code{end_date}.
#'   \code{area_info} is a data frame with six columns: \code{region} or
#'   \code{county}, \code{waterbody}, \code{latitude}, \code{longitude},
#'   \code{station}, and \code{lease}. \code{sn_table} is a data frame with
#'   three columns: \code{log_sensor} (sensor name as recorded in the log),
#'   \code{sensor_serial_number}, and \code{depth}. \code{string_configuration}
#'   is a character string indicating how the sensor string was moored.
#'
#' @importFrom dplyr contains filter mutate select
#' @importFrom lubridate is.Date ymd
#' @importFrom stringr str_replace str_detect
#' @importFrom tidyr separate
#'
#' @export
#' @examples
#' path <- system.file("extdata", package = "sensorstrings")
#'
#' log_raw <- ss_read_log(path, parse = FALSE)
#'
#' log <- ss_parse_log(log_raw)
#'
#' log$deployment_dates
#' log$area_info
#' log$sn_table
#' log$string_configuration
#'
#' # only return the serial number table
#' ss_parse_log(log_raw, deployment_dates = FALSE, area_info = FALSE, config = FALSE)

ss_parse_log <- function(
    log,
    deployment_dates = TRUE,
    area_info = TRUE,
    sn_table = TRUE,
    config = TRUE,
    verbose = TRUE
) {

  cols <- tolower(colnames(log))

  # deployment dates ------------------------------------------------------------

  if(isTRUE(deployment_dates)) {

    if("deployment_date" %in% cols) {
      depl_start <- unique(log$deployment_date)
    } else {
      if(isTRUE(verbose)) {
        message("Column deployment_date not found in log. Deployment date will be recorded as NA.")
      }
      depl_start <- NA
    }

    if("retrieval_date" %in% cols) {
      depl_end <- unique(log$retrieval_date)
    } else {
      if(isTRUE(verbose)) {
        message("Column retrieval_date not found in log. Retrieval date will be recorded as NA.")
      }
      depl_end <- NA
    }

    # warning if there is more than one Deployment or Retrieval date
    if (length(depl_start) > 1) {
      warning("Multiple Deployment dates in log")
    }

    if (length(depl_end) > 1) {
      warning("Multiple Retrieval dates in log")
    }

    # WARNING if the dates are not in the proper format
    if (is.na(suppressWarnings(lubridate::ymd(depl_start[1]))) & !is.na(depl_start[1])) {
      warning("Deployment date must be in the order year, month, day")
    }
    if (is.na(suppressWarnings(lubridate::ymd(depl_end[1]))) & !is.na(depl_end[1])) {
      warning("Retrieval date must be in the order year, month, day")
    }

    # convert to date
    if (!is.na(suppressWarnings(lubridate::ymd(depl_start[1]))) & !is.na(depl_start[1])) {
      depl_start <- lubridate::ymd(depl_start)
    }
    if (!is.na(suppressWarnings(lubridate::ymd(depl_end[1]))) & !is.na(depl_end[1])) {
      depl_end <- lubridate::ymd(depl_end)
    }

    # stop with Error if deployment date is after retrieval date
    if (is.Date(depl_start) & is.Date(depl_end)) {
      if (depl_start[1] > depl_end[1]) {
        stop("The deployment date is after the retrieval date")
      }
    }

    # deployment date info to export
    deployment_dates <- data.frame(
      start_date = depl_start,
      end_date = depl_end
    )

  } else deployment_dates <- NULL

  # area info ---------------------------------------------------------------

  if(isTRUE(area_info)) {

    if("county" %in% cols) {
      county <- unique(log$county)
    } else {
      if(isTRUE(verbose)) {
        message("Column county not found in log. county will be recorded as NA.")
      }
      county <- NA
    }

    if("region" %in% cols) {
      region <- unique(log$region)
    } else {
      region <- NA
    }

    if("waterbody" %in% cols) {
      wb <- unique(log$waterbody)
      if (length(wb) > 1) warning("Multiple waterbodies in log")
    } else {
      if(isTRUE(verbose)) {
        message("Column waterbody not found in log. waterbody will be recorded as NA.")
      }
      wb <- NA
    }

    if("deployment_latitude" %in% cols) {
      lat <- unique(log$deployment_latitude)
      if (length(lat) > 1) warning("Multiple latitudes recorded in log")
      if (!is.numeric(lat)) warning("Latitude is not numeric")
    } else {
      if(isTRUE(verbose)) {
        message("Column deployment_latitude not found in log. latitude will be recorded as NA.")
      }
      lat <- NA
    }

    if("deployment_longitude" %in% cols) {
      long <- unique(log$deployment_longitude)
      if (any(long > 0)) stop("Longitude must be a negative value")
      if (length(long) > 1) warning("Multiple longitudes recorded in log")
      if (!is.numeric(long)) warning("Longitude is not numeric")
    } else {
      if(isTRUE(verbose)) {
        message("Column deployment_longitude not found in log. longitude will be recorded as NA.")
      }
      long <- NA
    }

    if("station" %in% cols) {
      station <- as.character(unique(log$station))
      if (length(station) > 1) warning("Multiple stations recorded in log")
    } else {
      if(isTRUE(verbose)) {
        message("Column station not found in log. station will be recorded as NA.")
      }
      station <- NA
    }

    if("lease" %in% cols) {
      lease <- unique(log$lease)
      if (length(lease) > 1) warning("Multiple leases recorded in log")
    } else {
      if(isTRUE(verbose)) {
        message("Column lease not found in log. lease will be recorded as NA.")
      }
      lease <- NA
    }

    area_info <- data.frame(
      region = region,
      county = county,
      waterbody = wb,
      latitude = lat,
      longitude = long,
      station = station,
      lease = lease
    )

  } else area_info <- NULL

  # depth -------------------------------------------------------------------

  if(isTRUE(sn_table)) {
    # so that validation log doesn't need depth
    if(!("sensor_depth_m" %in% cols)) {
      log <- mutate(log, sensor_depth_m = NA_real_)
    }
    depth <- log |>
      select(sensor_type, sensor_serial_number, sensor_depth_m) |>
      mutate(numeric_depth = suppressWarnings(as.numeric(sensor_depth_m)))

    if (any(is.na((depth$numeric_depth)))) {
      depth_char <- depth |>
        filter(is.na(numeric_depth)) |>
        select(-numeric_depth) |>
        mutate(
          depth_print = paste(
            sensor_type, sensor_serial_number, sensor_depth_m)
        )

      warning(
        paste0("Depth can't be converted to numeric: ", depth_char$depth_print, "\n")
      )
    }

    # serial number table -----------------------------------------------------
    sn_table <- log |>
      select(
        log_sensor = sensor_type,
        sensor_serial_number,
        depth = sensor_depth_m
      )

    sensors <- sn_table |>
      mutate(
        log_sensor = str_replace(log_sensor, "_", " "),
        log_sensor = tolower(log_sensor),
        detect_hobo = str_detect(log_sensor, "hobo"),
        detect_tidbit = str_detect(log_sensor, "tidbit"),
        detect_am = str_detect(log_sensor, "aquameasure"),
        detect_vemco = str_detect(log_sensor, "vr2ar|vemco")
      )

    # warning if there are any sensors in the log that are NOT recognized by package
    n_sensors <- sensors |>
      select(contains("detect")) |>
      apply(1, sum)

    if (any(n_sensors == 0)) {
      extra_sensor <- sensors[which(n_sensors == 0), "log_sensor"]

      warning(
        paste0(extra_sensor, " found in the sensor_type column of the log.
            This sensor is not recognized by the sensorstrings package")
      )
    }
  } else sn_table <- NULL

  # configuration ------------------------------------------------------------

  if(isTRUE(config)) {
    config_options <- c(
      "sub-surface buoy", "surface buoy", "attached to gear",
      "attached to fixed structure", "floating dock", "unknown", "calval", NA
    )

    if ("string_configuration" %in% cols) {
      config <- unique(log$string_configuration)
    } else if ("configuration" %in% cols) {
      config <- unique(log$configuration)
    } else config <- NA

    if (length(config) > 1) {
      config <- config[!is.na(config)] # remove NAs from config
    }

    if (length(config) > 1) { # if length is still > 1, pick the first
      warning(
        "More than one configuration type entered in the Log. ",
        paste(config, collapse = ", "), " >>. Using << ", config[1], " >>."
      )
      config <- config[1]
    }

    if (!(config %in% config_options)) {
      warning("<< ", config, " >> is not an accepted sensor string configuration")
    }

    if (is.na(config)) {
      if(isTRUE(verbose)) {
        message("Configuration will be converted from NA to << unknown >>")
      }
      config <- "unknown"
    }

  } else config <- NULL

  # return list of deployment info -------------------------------------------
  list(
    deployment_dates = deployment_dates,
    area_info = area_info,
    sn_table = sn_table,
    string_configuration = config
  )
}
