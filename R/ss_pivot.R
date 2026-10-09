#' Pivot sensor string data from wide to long format
#'
#' @param dat_wide Data frame of sensor string data in a wide format, as
#'   returned by \code{ss_compile_*()} functions.
#'
#' @return Returns \code{dat_wide} in long format. Variables (e.g., temperature,
#'   dissolved oxygen, salinity, and depth measured by sensor) are in a column
#'   named \code{variable} and the associated measurement in a column named
#'   \code{value}.
#'
#' @importFrom dplyr arrange contains
#' @importFrom tidyr pivot_longer
#' @importFrom stringr str_remove
#'
#' @export
#' @examples
#' dat <- ss_compile_deployment_data(system.file("extdata", package = "sensorstrings"))
#'
#' dat_long <- ss_pivot_longer(dat)
#'
#' head(dat_long)
#' unique(dat_long$variable)

ss_pivot_longer <- function(dat_wide) {
  dat_wide |>
    pivot_longer(
      any_of(ss_vars$variable), names_to = "variable", values_to = "value",
      values_drop_na = TRUE
    )
}


#' Pivot sensor string data from long to wide format
#'
#' @param dat_long Data frame of sensor string data in long format, as returned
#'   by \code{ss_pivot_longer()}.
#'
#' @return Returns \code{dat_long} in wide format, with a separate column for
#'   each \code{variable}.
#'
#' @importFrom tidyr pivot_wider
#'
#' @export
#' @examples
#' dat <- ss_compile_deployment_data(system.file("extdata", package = "sensorstrings"))
#'
#' dat_long <- ss_pivot_longer(dat)
#'
#' dat_wide <- ss_pivot_wider(dat_long)
#' head(dat_wide)

ss_pivot_wider <- function(dat_long) {
  dat_long |>
    pivot_wider(
      names_from = variable, values_from = value, names_sort = TRUE
    )
}
