# written with Claude Opus 5.5

# ss_ggplot_variables() calls theme_set(); the theme is restored at the end of
# this file
old_theme <- ggplot2::theme_get()

dat_app <- make_wq_wide(n_days = 10)

# The app's server function has no session argument, which
# shiny::testServer() needs, so wrap it
app_server <- function(app) {
  server <- app$serverFuncSource()
  function(input, output, session) server(input, output)
}

test_that("ss_open_trimdates_app() returns a shiny app", {
  expect_s3_class(
    ss_open_trimdates_app(dat_app, filter_to = "start"), "shiny.appobj"
  )
})

test_that("ss_open_trimdates_app() renders the plot and the click table", {
  app <- ss_open_trimdates_app(dat_app, filter_to = "end", period = "2 day")

  shiny::testServer(app_server(app), {
    expect_no_error(output$vars_plot)
    expect_match(output$info, "Click events appear here")
  })
})

test_that("ss_open_trimdates_app() renders with custom dates", {
  app <- ss_open_trimdates_app(
    dat_app,
    filter_to = "custom",
    custom_start = as.POSIXct("2023-06-03", tz = "UTC"),
    custom_end = as.POSIXct("2023-06-05", tz = "UTC")
  )

  shiny::testServer(app_server(app), expect_no_error(output$vars_plot))
})

test_that("ss_open_trimdates_app() renders with the default filter_to", {
  app <- ss_open_trimdates_app(dat_app)
  shiny::testServer(app_server(app), expect_no_error(output$vars_plot))
})

ggplot2::theme_set(old_theme)
