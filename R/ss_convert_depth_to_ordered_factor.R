#' @title Converts values in the depth column to an ordered factor

#' @description This function simplifies converting the
#'   sensor_depth_at_low_tide_m column from class \code{numeric}, \code{factor},
#'   or \code{character} to an ordered factor, which is preferred for using the
#'   function \code{ss_ggplot_variables()}.
#'
#' @param dat Data frame that includes the column
#'   \code{sensor_depth_at_low_tide_m}.
#'
#' @return Returns \code{dat}, with the \code{sensor_depth_at_low_tide_m} column
#'   converted to an ordered factor. The shallowest depth will have a factor
#'   value of 1; the deepest depth will have the largest factor value.
#'
#' @family format
#' @author Danielle Dempsey
#' @importFrom dplyr mutate arrange
#'
#' @export
#'
#' @examples
#' dat <- data.frame(
#'   sensor_depth_at_low_tide_m = c(10, 2, 5, 2),
#'   temperature_degree_c = c(8, 15, 12, 14)
#' )
#'
#' dat_ordered <- ss_convert_depth_to_ordered_factor(dat)
#'
#' dat_ordered
#' levels(dat_ordered$sensor_depth_at_low_tide_m)


ss_convert_depth_to_ordered_factor <- function(dat) {
  dat |>
    mutate(depth = factor(sensor_depth_at_low_tide_m)) |>
    # assign levels to the factor based on the numeric values of DEPTH
    mutate(depth = ordered(
      depth,
      levels = as.numeric(levels(depth))[order(as.numeric(levels(depth)))]
    )) |>
    arrange(depth) |>
    mutate(sensor_depth_at_low_tide_m = depth) |>
    select(-depth)
}
