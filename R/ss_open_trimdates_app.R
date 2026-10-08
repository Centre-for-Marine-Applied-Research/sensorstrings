#' Open interactive plot
#'
#' @param dat Data frame of sensor string data in wide format, as exported from
#'   \code{ss_compile_deployment_data()}. Must include columns timestamp_,
#'   sensor_depth_at_low_tide_m, sensor_type, sensor-serial number, and the
#'   variables to plot (e.g., temperature_degree_c).
#'
#' @param filter_to Shortcut for specifying where to filter \code{dat} before
#'   plotting. Options are "start", "end", or "custom". Default is "start".
#'
#' @param period Character string that can be converted to a \code{lubridate}
#'   period. Default is \code{"2 days"}.
#'
#' @param custom_start Only required if \code{filter_to = "custom"}. POSIXct
#'   object indicating where the filtered data will begin.
#'
#' @param custom_end Only required if \code{filter_to = "custom"}. POSIXct
#'   object indicating where the filtered data will end.
#'
#' @param point_size Size of points in the plot.
#'
#' @return Opens a shiny app displaying an interactive plot of variables in
#'   \code{dat}, coloured by depth.
#'
#' @importFrom lubridate as_datetime
#'
#' @export
#' @examples
#' if (requireNamespace("shiny", quietly = TRUE) &&
#'     requireNamespace("plotly", quietly = TRUE)) {
#'   dat <- ss_compile_deployment_data(
#'     system.file("extdata", package = "sensorstrings"), trim = FALSE
#'   )
#'
#'   # the app object is created here, and opens when printed or run
#'   app <- ss_open_trimdates_app(dat, filter_to = "end", period = "1 day")
#'
#'   # the app is interactive, so only open it in an interactive session
#'   if (interactive()) shiny::runApp(app)
#'
#'   # zoom in on a custom time window
#'   app2 <- ss_open_trimdates_app(
#'     dat,
#'     filter_to = "custom",
#'     custom_start = as.POSIXct("2019-05-30 12:00", tz = "UTC"),
#'     custom_end = as.POSIXct("2019-06-01 00:00", tz = "UTC")
#'   )
#'   if (interactive()) shiny::runApp(app2)
#' }


ss_open_trimdates_app <- function(
    dat,
    filter_to = c("start", "end", "custom"),
    period = "2 days",
    custom_start = NULL,
    custom_end = NULL,
    point_size = 2) {

  ui <- shiny::fluidPage(
    plotly::plotlyOutput("vars_plot", height = "600px"),
    shiny::tableOutput("info")
  )

  ts_save <- data.frame(ts = NA_character_)

  server <- function(input, output) {
    output$vars_plot <- plotly::renderPlotly({
      dat <- dat |>
        filter_dat_to_plot(
          filter_to = filter_to,
          period = period,
          custom_start = custom_start,
          custom_end = custom_end
        )

      p <- ss_ggplot_variables(dat, point_size = point_size)

      plotly::ggplotly(p, source = "plot1", tooltip = "text")
    })

    output$info <- shiny::renderTable({
      ts_info <- plotly::event_data("plotly_click", source = "plot1")

      if (is.null(ts_info)) {
        "Click events appear here (double-click chart to clear)"
      } else {
        ts_new <- data.frame(ts = as_datetime(ts_info$x))
        ts_new$ts <- paste0("'", format(ts_new$ts, "%Y-%m-%d %H:%M:%S"), "'")

        ts_save <<- bind_rows(ts_save, ts_new)

        na.omit(ts_save)
      }
    })
  }

  # Run the application
  shiny::shinyApp(ui = ui, server = server)
}
