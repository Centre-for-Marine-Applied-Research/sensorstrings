#' @title Writes deployment table for county report

#' @param dat Data frame of sensor string data in wide format.

#' @param keep_waterbody Logical value indicating whether to keep the
#'   \code{Waterbody} column.
#'
#' @param var_sep Separator between variables. Default will add a new line
#'   between variables for Word and pdf outputs.
#'
#' @importFrom tidyr separate unite
#' @importFrom lubridate as_date
#' @importFrom dplyr any_of arrange distinct left_join mutate select
#'
#' @export
#' @examples
#' dat <- ss_compile_deployment_data(system.file("extdata", package = "sensorstrings"))
#'
#' ss_write_report_table(dat)
#'
#' # keep the waterbody column, and separate variables with a comma
#' ss_write_report_table(dat, keep_waterbody = TRUE, var_sep = ", ")

ss_write_report_table <- function(dat, keep_waterbody = FALSE, var_sep = "\n"){

  table_out <- dat |>
    select(
      Waterbody = waterbody,
      Station = station,
      deployment_range,
      Latitude = latitude,
      Longitude = longitude,
      any_of(ss_vars$variable),
      Configuration = string_configuration
    ) |>
    ss_pivot_longer() |>
    select(-value) |>
    distinct() |>
    separate(
      col = deployment_range,
      into = c("Deployment Date", "Retrieval Date"), sep = " to "
    ) |>
    left_join(select(ss_vars, variable, report_entry), by = "variable") |>
    select(-variable) |>
    rename(variable = report_entry) |>
    mutate(
      `Deployment Date` = format(as_date(`Deployment Date`), "%Y-%m-%d"),
      `Retrieval Date` = format(as_date(`Retrieval Date`), "%Y-%m-%d"),
      Latitude = round(Latitude, digits = 4),
      Longitude = round(Longitude, digits = 4)
    ) |>
    pivot_wider(
      values_from = "variable", names_from = "variable",
      names_sort = TRUE) |>
    unite("Variables Measured", any_of(ss_vars$report_entry), sep = var_sep, na.rm = TRUE)

  if(isTRUE(keep_waterbody)) {
    table_out <- table_out |>
      arrange(Waterbody, Station, `Deployment Date`)
  } else {
    table_out <- table_out |>
      arrange(Station, `Deployment Date`) |>
      select(-Waterbody)
  }

  table_out

}
