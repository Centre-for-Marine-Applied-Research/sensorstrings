#' Filter data before plotting to zoom in on interesting features
#'
#' Called by \code{ss_open_trimdates_app()}.
#'
#' @inheritParams ss_open_trimdates_app
#'
#' @return Returns \code{dat} filtered to the specified dates.
#'
#' @importFrom lubridate period is.POSIXct  %m+% %m-%
#' @importFrom dplyr filter
#' @importFrom rlang :=
#'
#' @export
#'
#' @examples
#' # one week of hourly temperature data
#' dat <- data.frame(
#'   timestamp_utc = seq(
#'     as.POSIXct("2023-06-01 00:00", tz = "UTC"),
#'     as.POSIXct("2023-06-08 00:00", tz = "UTC"),
#'     by = "1 hour"
#'   ),
#'   sensor_depth_at_low_tide_m = 2,
#'   temperature_degree_c = 10
#' )
#'
#' # the first 2 days (the default)
#' range(ss_filter_dat_to_plot(dat)$timestamp_utc)
#'
#' # the last 12 hours
#' range(ss_filter_dat_to_plot(dat, filter_to = "end", period = "12 hours")$timestamp_utc)
#'
#' # a custom window
#' dat_custom <- ss_filter_dat_to_plot(
#'   dat,
#'   filter_to = "custom",
#'   custom_start = as.POSIXct("2023-06-03 06:00", tz = "UTC"),
#'   custom_end = as.POSIXct("2023-06-03 18:00", tz = "UTC")
#' )
#' range(dat_custom$timestamp_utc)

ss_filter_dat_to_plot <- function(
    dat,
    filter_to = c("start", "end", "custom"),
    period = "2 days",
    custom_start = NULL,
    custom_end = NULL) {

  filter_to <- match.arg(filter_to)

  ts_col <- colnames(dat)[grep("timestamp", colnames(dat))]
  dat <- rename(dat, timestamp_ = contains("timestamp"))

  if (filter_to == "start") {
    dat <- dat |>
      filter(
        timestamp_ <=
          (na.omit(min(dat$timestamp_)) %m+% lubridate::period(period))
      )
  }

  if (filter_to == "end") {
    dat <- dat |>
      filter(
        timestamp_ >=
          (na.omit(max(dat$timestamp_)) %m-% lubridate::period(period))
      )
  }

  if (filter_to == "custom") {
    if(!is.POSIXct(custom_start)) {
      stop("'custom_start' must be of type 'POSIXct', not ", class(custom_start))
    }
    if(!is.POSIXct(custom_end)) {
      stop("'custom_end' must be of type 'POSIXct', not ", class(custom_end))
    }

    dat <- dat |>
      filter(timestamp_ >= custom_start & timestamp_ <= custom_end)
  }

  dat |>
    rename(!!sym(ts_col) := timestamp_)
}
