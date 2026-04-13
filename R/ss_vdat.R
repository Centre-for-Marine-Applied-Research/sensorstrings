#' @title Import data from VR2AR csv files exported from Fathom
#'
#' @details For VR2AR data offloaded in the new .vdat format and exported with
#'   Fathom software. The data must be saved in csv format.
#'
#' @inheritParams ss_read_hobo_data
#'
#' @param path File path to the vdat folder, or full path to the data file
#'   including file name and extension.
#'
#' @return Returns a data frame of vr2ar data, with the same columns as in the
#'   original file.
#'
#' @author Danielle Dempsey
#'
#' @importFrom data.table fread
#'
#' @export

# path <- "C:/Users/Danielle Dempsey/Desktop/RProjects/packages/sensorstrings/inst/testdata/vr2ar"
# file_name <- "VR2AR-69_555438.csv"

ss_read_vdat_data <- function(path, file_name) {

  # finish path if needed
  if (isFALSE(utils::file_test("-f", path))) {
    path <- file.path(paste0(path, "/", file_name))
  }

  if (extract_file_extension(path) != "csv")  {
    stop("file must have extension '.csv'.\nLooked in ", path)
  }

  data.table::fread(
    path,
    fill = TRUE,
    header = FALSE,
    data.table = FALSE,
    # encoding = "Latin-1",
    na.strings = ""
  )
}


#' Format temperature data from VR2AR deployment
#'
#' @description Compiles and formats temperature and depth data from VR2AR data
#'   offloaded in the new .vdat format and exported with Fathom software.
#'
#' @details The raw VR2AR data must be saved in a folder named vdat in csv
#'   format. Folder name is not case-sensitive.
#'
#'   The device timestamp is used here. This may drift over time. Corrected time
#'   stamp is included in the .vdat file, but the date is not always appended.
#'
#' @inheritParams ss_compile_hobo_data
#'
#' @param path File path to the vdat folder. This folder should have one csv
#'   file that was extracted using Fathom software. Other file types in the
#'   folder will be ignored.
#'
#' @return Returns a tibble with the data compiled from the file in path/vdat.
#'
#' @family compile
#' @author Danielle Dempsey
#'
#' @importFrom dplyr %>% case_when filter group_by mutate select summarise
#'   tibble
#' @importFrom lubridate as_datetime
#' @importFrom purrr list_rbind
#'
#' @export

ss_compile_vdat_data <- function(
    path, sn_table, deployment_dates, trim = TRUE
) {

  # set up & check for errors
  setup <- set_up_compile(
    path = path,
    sn_table = sn_table,
    deployment_dates = deployment_dates,
    sensor_make = "VR2AR-69"
  )

  path <- setup$path
  dat_files <- setup$dat_files
  sn_table <- setup$sn_table

  start_date <- setup$dates$start
  end_date <- setup$dates$end

  # initialize list for storing the output
  vem_dat <- list(NULL)

  # Import data -------------------------------------------------------------

  # loop over each file
  for (i in seq_along(dat_files)) {

    file_i <- dat_files[i]
    file_name <- sub(".csv", "", sub(".*/", "", file_i, perl = TRUE))

    # Extract metadata --------------------------------------------------------
    dat_i <- ss_read_vdat_data(file_i)

    colnames(dat_i) <- dat_i[2, ]
    dat_i <- dat_i[!is.na(colnames(dat_i))]

    dat_i <- dat_i %>%
      dplyr::filter(
        `RECORD TYPE` %in% c("DEPTH_DESC", "DEPTH", "TEMP_DESC", "TEMP")
      )

    depth_units_i <-  dat_i %>%
      dplyr::filter(`RECORD TYPE` == "DEPTH_DESC") %>%
      dplyr::pull(FIELD.6)

    # depth and temperature units
    if (!(depth_units_i %in% "Depth (m)")) {
      stop(paste0("Sensor ", file_name, " has depth units of << ", depth_units_i, " >>"))
    }

    temp_units_i <-  dat_i %>%
      dplyr::filter(`RECORD TYPE` == "TEMP_DESC") %>%
      dplyr::pull(FIELD.6)

    if (!(temp_units_i %in% "Ambient (deg C)")) {
      stop(paste0("Sensor ", file_name, " has temperature units of << ", temp_units_i, " >>"))
    }


    # format data -------------------------------------------------------------

    # column names
    colnames(dat_i) <- dat_i[1, ]
    dat_i <- dat_i[!is.na(colnames(dat_i))]

    dat_i <- dat_i %>%
      slice(-c(1:2)) %>%
      select(
        timestamp_ = `Device Time (UTC)`,
        sensor_type = Model,
        sensor_serial_number = `Serial Number`,
        variable = DEPTH_DESC,
        value = `Depth (m)`
      ) %>%
      convert_timestamp_to_datetime() %>%
      mutate(
        timestamp_utc = timestamp_,
        # time_correction_s = as.numeric(time_correction_s),
        # timestamp_utc = timestamp_utc_uncorrected + lubridate::seconds(time_correction_s))

        sensor_serial_number = as.numeric(sensor_serial_number),
        value = as.numeric(value),
        variable = case_when(
          variable == "DEPTH" ~ "sensor_depth_measured_m",
          variable == "TEMP" ~ "temperature_degree_c",
          TRUE ~ NA
        )
      ) %>%
      select(-timestamp_)

    # serial number from data file
    sn_i <- unique(dat_i$sensor_serial_number)

    if (!(sn_i %in% sn_table$sensor_serial_number)) {
      stop(paste0("Serial number ", sn_i, " does not match any serial numbers in sn_table"))
    }

    # use serial number to identify the depth from sn_table
    sensor_info_i <- dplyr::filter(sn_table, sensor_serial_number == sn_i)

    # trim -------------------------------------------------------------

    # check there are more than 0 rows in dat
    check_n_rows(dat_i, file_name = dat_files, trimmed = FALSE)

    # trim to the dates in deployment_dates
    if (isTRUE(trim)) dat_i <- trim_data(dat_i, start_date, end_date)

    check_n_rows(dat_i, file_name = dat_files, trimmed = trim)

    # find any duplicate timestamps
    bad_ts <- dat_i %>%
      group_by(timestamp_utc) %>%
      summarise(n = n()) %>%
      filter(n > 2)

    if (nrow(bad_ts) > 0) {
      message(
        "Duplicate timestamp(s) found and removed from vr2ar ",
        sn_i, ": ",
        paste(bad_ts$timestamp_utc, collapse = ", ")
      )
    }

    # remove duplicate timestamps and pivot wider
    dat_i <- dat_i %>%
      filter(!(timestamp_utc %in% bad_ts$timestamp_utc)) %>%
      pivot_wider(values_from = value, names_from = variable) %>%
      add_deployment_columns(start_date, end_date,  sensor_info_i)

    vem_dat[[i]] <- dat_i

    message(paste("vemco data from sensor << ", sn_i, " >> compiled"))
  }

  vem_out <- vem_dat %>%
    list_rbind()

  tibble(vem_out)
}
