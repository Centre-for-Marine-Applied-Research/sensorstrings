#' Exports figure of variable(s) at depth over time.
#'
#' Output is not compatible with ggplot2 functions or ggplotly(). Use
#' \code{ss_ggplot_variables()} to work with those functions.
#'
#' @param dat Water Quality data in long or wide format.
#'
#' @param colour_palette  Colour palette of hex colours onto which
#'   \code{sensor_depth_at_low_tide_m} will be mapped. Default is
#'   \code{rev(viridis(6, option = "D"))}.
#'
#' @param date_breaks_major Intervals for major breaks. Default is selected by
#'   \code{get_xaxis_breaks()}.
#'
#' @param date_breaks_minor Intervals for minor breaks. Default selected by
#'   \code{get_xaxis_breaks()}.
#'
#' @param date_labels_format Format for the date labels. Default is YYYY-mm-dd.
#'
#' @param standard_ylims Logical argument indicating whether to use the
#'   standard y-limits from the controlled vocabulary (e.g., c(60, 160) for
#'   dissolved oxygen (\% saturation), c(7.5, 8.5) for pH, and c(25, 34) for
#'   salinity). If \code{FALSE}, the y-limits are set to the \code{ggplot}
#'   default. Variables without standard limits (e.g., temperature) always use
#'   the \code{ggplot} default. Default is \code{TRUE}.
#'
#' @param ylims Optional named list of custom y-limits. Each name must be a
#'   variable name (e.g., \code{"ph_ph"}) and each value a numeric vector of
#'   length 2. Use \code{NA} for one end to let \code{ggplot} choose it
#'   (e.g., \code{c(0, NA)}), or \code{NULL} to use the \code{ggplot}
#'   default for that variable. Custom limits replace the limits chosen by
#'   \code{standard_ylims} for the named variables only. Variables that are
#'   not in \code{dat} are ignored. Default is \code{ylims = NULL}.
#'
#' @param yaxis_newline Logical argument indicating whether the units in the
#'   y-axis label should be on a new line. Default is \code{FALSE}.
#'
#' @param alpha Value indicating the transparency of the points. 0 is most
#'   transparent; 1 is opaque.
#'
#' @param legend_name Name for the legend. Must be a character string. Default
#'   is \code{legend_name = "Depth (m)"}.
#'
#' @param legend_position Position for the legend. Passed to \code{patchwork}.
#'   Default is \code{legend_position = "right"}.
#'
#' @return Returns a patchwork object, a single figure with the plots for each
#'   variable in \code{dat} stacked in a column.
#'
#' @importFrom dplyr any_of filter select
#' @importFrom patchwork wrap_plots
#' @importFrom ggplot2 aes geom_point ggplot guides labs scale_x_datetime scale_y_continuous theme theme_light
#' @importFrom viridis viridis
#'
#' @export
#' @examples
#' dat <- ss_compile_deployment_data(system.file("extdata", package = "sensorstrings"))
#'
#' ss_plot_variables(dat)
#'
#' # the legend on the bottom, units on a second line, and custom DO limits
#' ss_plot_variables(
#'   dat,
#'   legend_position = "bottom",
#'   yaxis_newline = TRUE,
#'   ylims = list("dissolved_oxygen_percent_saturation" = c(100, 250))
#' )

#' # ggplot default y-limits for every variable
#' ss_plot_variables(dat, standard_ylims = FALSE)

ss_plot_variables <- function(
    dat,
    colour_palette = NULL,

    date_breaks_major = NULL,
    date_breaks_minor = NULL,
    date_labels_format = "%Y-%m-%d",

    standard_ylims = TRUE,
    ylims = NULL,

    yaxis_newline = FALSE,

    alpha = 1,

    legend_name = "Depth (m)",
    legend_position = "right"
){

  check_ylims(standard_ylims, ylims)

  dat <- dat |>
    select(-contains("flag"))

  if (!("variable" %in% colnames(dat))) {
    vars_ss <- ss_vars$variable

    dat <- dat |>
      select(
        contains("timestamp_"), sensor_depth_at_low_tide_m, any_of(vars_ss)
      ) |>
      ss_pivot_longer()
  }

  dat <- dat |>
    ss_convert_depth_to_ordered_factor() |>
    create_variable_labels(new_line = yaxis_newline) |>
    rename(timestamp_ = contains("timestamp"))

  # Common plot elements ----------------------------------------------------
  #  x-axis
  axis_breaks <- get_xaxis_breaks(dat)

  if(!is.null(date_breaks_major)) axis_breaks$date_breaks_major <- date_breaks_major
  if(!is.null(date_breaks_minor)) axis_breaks$date_breaks_minor <- date_breaks_minor
  if(!is.null(date_labels_format)) axis_breaks$date_labels_format <- date_labels_format

  x_axis_date <- scale_x_datetime(
    name = "Date",
    date_breaks = axis_breaks$date_breaks_major,          # major breaks
    date_minor_breaks = axis_breaks$date_breaks_minor,     # minor breaks
    date_labels = axis_breaks$date_labels_format,         # format for showing date
    limits = c(min(dat$timestamp_), max(dat$timestamp_))
  )

  # theme
  string_theme <- theme(
    axis.text = element_text(size = 9, colour = "black"),    # axis text size & color
    legend.title = element_text(size = 10) ,                 # legend title size
    legend.text = element_text(size = 10)                   # legend text size

    )

  # colour scale
  if(is.null(colour_palette)){
    colour_palette <- ss_get_colour_palette(dat)
  }
  string_colour_scale <- scale_colour_manual(
    name = legend_name, values = colour_palette, drop = FALSE
  )

  # size of the points in the legend
  legend_size <-  guides(colour = guide_legend(override.aes = list(size = 5)))

  # Loop over unique VARIABLE values --------------------------------------------------

  figs <- list(NULL)              # empty list for storing the figures

  # arrange variable to plot in consistent order
  vars_to_plot <- dat |>
    select(variable) |>
    distinct() |>
    mutate(variable = ordered(variable,levels = ss_vars$variable)) |>
    arrange(variable)
  vars_to_plot <- vars_to_plot$variable

  n_vars <- length(vars_to_plot)  # number of variables to plot

  for(i in seq_along(vars_to_plot)){

    var_i <- vars_to_plot[i]

    # filter data for the variable of interest
    dat_i <- dplyr::filter(dat, variable == var_i)

    y_lab <- unique(dat_i$variable_label)

    # y-limits: standard (controlled vocab), then custom, else ggplot default
    y_limits <- NULL
    if (isTRUE(standard_ylims)) {
      var_vocab <- ss_vars[ss_vars$variable == var_i, ]
      y_limits <- c(var_vocab$ylims_min, var_vocab$ylims_max)
      if (all(is.na(y_limits))) y_limits <- NULL
    }
    if (as.character(var_i) %in% names(ylims)) {
      y_limits <- ylims[[as.character(var_i)]]
    }

    # plot var.i
    plot_i <- ggplot(
      dat_i, aes(x = timestamp_, y = value, colour = sensor_depth_at_low_tide_m)
    ) +
      geom_point(size = 0.25, alpha = alpha, show.legend = TRUE) +
      scale_y_continuous(name = y_lab, limits = y_limits) +
      string_colour_scale +
      x_axis_date +
      theme_light() +
      string_theme +
      legend_size

    figs[[i]] <- plot_i

  } # end of for loop over n_vars


  # RETURN TO GLOBAL ENV ----------------------------------------------------
  patchwork::wrap_plots(
    figs, ncol = 1, guides = "collect", axes = "collect", axis_titles = "collect"
    ) &
    theme(legend.position = legend_position)
}






