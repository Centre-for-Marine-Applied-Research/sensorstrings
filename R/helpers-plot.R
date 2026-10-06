#' Returns colour palette based on the unique values of
#' sensor_depth_at_low_tide_m
#'
#' @details Returns a discrete colour scale palette from the viridis package
#'   (Option D). If there are 6 or less unique values of
#'   \code{sensor_depth_at_low_tide_m}, the palette will have 6 colours. If
#'   there are more than 6 unique values of \code{sensor_depth_at_low_tide_m},
#'   there will be one colour for each depth.
#'
#' @param dat Data frame with at least one column. The column name must include
#'   the string "low_tide".
#'
#' @return Returns a vector of hex colours from the viridis palette (Option D,
#'   direction = -1).
#'
#' @family plot
#' @author Danielle Dempsey
#'
#' @importFrom viridis viridis
#' @importFrom dplyr %>% contains select
#'
#' @export

ss_get_colour_palette <- function(dat) {
  n_depth <- dat %>%
    select(contains("low_tide"))

  if(ncol(n_depth) > 1) {
    stop("More than one column named with the string low_tide detected in dat.")
  }

  n_depth <- n_depth %>%
    distinct() %>%
    nrow()

  if (n_depth > 6) {
    colour_palette <- viridis(n_depth, option = "D", direction = -1)
  } else {
    colour_palette <- viridis(6, option = "D", direction = -1)
  }

  colour_palette
}

#' Returns nice major and minor breaks and label format based on timespan of the
#' data
#'
#' @param dat Data frame with at least one column: \code{timestamp_utc}
#'   (POSIXct).
#'
#' @importFrom dplyr between
#'
#' @return Returns a dataframe with 1 observation of 3 variables
#'   \code{date_breaks_major}, \code{date_breaks_minor},
#'   \code{date_labels_format}.
#'

ss_get_xaxis_breaks <- function(dat){

  # timespan of the data
  dat <- rename(dat, timestamp_ = contains("timestamp"))
  timespan <- difftime(max(dat$timestamp_), min(dat$timestamp_), units = "days")
  timespan <- round(unclass(timespan)[1])

  if(timespan <= 2){
    date_breaks_major = "12 hour"
    date_breaks_minor = "12 hour"
    date_labels_format = "%Y-%m-%d %H:%M"
  }

  if(between(timespan, 3, 5)){
    date_breaks_major = "1 day"
    date_breaks_minor = "1 day"
    date_labels_format = "%Y-%m-%d"
  }

  if(between(timespan, 6, 10)){
    date_breaks_major = "2 day"
    date_breaks_minor = "1 day"
    date_labels_format = "%Y-%m-%d"
  }

  if(between(timespan, 11, 40)){
    date_breaks_major = "1 week"
    date_breaks_minor = "1 week"
    date_labels_format = "%Y-%m-%d"
  }

  if(between(timespan, 41, 60)){
    date_breaks_major = "2 week"
    date_breaks_minor = "2 week"
    date_labels_format = "%Y-%m-%d"
  }

  if(between(timespan, 61, 240)){
    date_breaks_major = "1 month"
    date_breaks_minor = "1 month"
    date_labels_format = "%Y-%m-%d"
  }

  if(between(timespan, 241, 480)){
    date_breaks_major = "2 month"
    date_breaks_minor = "1 month"
    date_labels_format = "%Y-%m-%d"
  }

  if(between(timespan, 481, 660)){
    date_breaks_major = "3 month"
    date_breaks_minor = "1 month"
    date_labels_format = "%Y-%m-%d"
  }

  if(between(timespan, 661, 840)){
    date_breaks_major = "4 month"
    date_breaks_minor = "1 month"
    date_labels_format = "%Y-%m-%d"
  }

  if(between(timespan, 841, 960)){
    date_breaks_major = "5 month"
    date_breaks_minor = "1 month"
    date_labels_format = "%Y-%m-%d"
  }

  if(between(timespan, 961, 1460)){
    date_breaks_major = "6 month"
    date_breaks_minor = "1 month"
    date_labels_format = "%Y-%m-%d"
  }

  if(between(timespan, 1461, 3100)){
    date_breaks_major = "12 months"
    date_breaks_minor = "2 months"
    date_labels_format = "%Y-%m-%d"
  }

  if(timespan > 3100){
    date_breaks_major = "18 months"
    date_breaks_minor = "3 months"
    date_labels_format = "%Y-%m-%d"
  }

  data.frame(
    date_breaks_major = date_breaks_major,
    date_breaks_minor = date_breaks_minor,
    date_labels_format = date_labels_format
  )
}

#' Create plot labels from variable names
#'
#' @param dat Data frame of Water Quality data with variables in long format.
#'
#' @param new_line Logical argument indicating whether to place the units of the
#'   y-axis on a new line. If \code{FALSE}, the default, the variable name and
#'   units are on the same line.
#'
#' @return Returns \code{dat} with an additional column \code{variable_label}.
#'
#' @importFrom dplyr left_join mutate
#'
#' @export

ss_create_variable_labels <- function(dat, new_line = FALSE) {

 dat <- dat |>
    left_join(ss_vars, by = "variable")

 if(isTRUE(new_line)) {
   dat <- dat |>
     mutate(
       variable_label = ordered(label_new_line, levels = ss_vars$label_new_line)
     )
 } else{
   dat <- dat |>
     mutate(
       variable_label = ordered(label_no_new_line, levels = ss_vars$label_no_new_line)
     )
 }

 dat |>
   select(-c(label_new_line, label_no_new_line))
}

#' Filter data before plotting to zoom in on interesting features
#'
#' Called by \code{ss_open_trimdates_app()}.
#'
#' @inheritParams ss_open_trimdates_app
#'
#' @return Returns \code{dat} filtered to the specified dates.
#'
#' @importFrom lubridate period is.POSIXct  %m+% %m-%
#' @importFrom dplyr %>% filter
#' @importFrom rlang :=
#'

filter_dat_to_plot <- function(
    dat,
    filter_to = c("start", "end", "custom"),
    period = "2 days",
    custom_start = NULL,
    custom_end = NULL) {

  filter_to <- match.arg(filter_to)

  ts_col <- colnames(dat)[grep("timestamp", colnames(dat))]
  dat <- rename(dat, timestamp_ = contains("timestamp"))

  if (filter_to == "start") {
    dat <- dat %>%
      filter(
        timestamp_ <=
          (na.omit(min(dat$timestamp_)) %m+% lubridate::period(period))
      )
  }

  if (filter_to == "end") {
    dat <- dat %>%
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

    dat <- dat %>%
      filter(timestamp_ >= custom_start & timestamp_ <= custom_end)
  }

  dat |>
    rename(!!sym(ts_col) := timestamp_)
}
