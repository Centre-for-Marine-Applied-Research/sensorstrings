# written with Claude Opus 5.5

test_that("ss_create_template() writes the template with the placeholders filled in", {
  out <- new_tmp_dir()
  on.exit(unlink(out, recursive = TRUE))

  template <- suppressMessages(ss_create_template(
    station = "Borgles Island", depl_date = "2019-05-30", initials = "DD",
    path = out
  ))

  expect_equal(template, file.path(out, "compile_borgles_island_2019-05-30.R"))
  txt <- readLines(template)
  expect_false(any(grepl("x_station|x_depl_date|x_initials|x_version|x_date", txt)))
  expect_true(any(grepl('"borgles_island"', txt, fixed = TRUE)))
  expect_true(any(grepl('"2019-05-30"', txt, fixed = TRUE)))
  expect_true(any(grepl("NAME: DD", txt, fixed = TRUE)))

  # a second call warns and leaves the file unchanged
  writeLines("edited", template)
  expect_warning(
    ss_create_template(station = "Borgles Island", depl_date = "2019-05-30", path = out),
    "already exists"
  )
  expect_equal(readLines(template), "edited")
})

test_that("ss_create_template() gives Errors", {
  expect_error(ss_create_template(depl_date = "2019-05-30", path = tempdir()), "station")
  expect_error(ss_create_template("A", "not a date", path = tempdir()), "incorrect format")
  expect_error(
    ss_create_template("A", "2019-05-30", path = file.path(tempdir(), "no_such_folder")),
    "does not exist"
  )
})

test_that("ss_create_template() rejects dates in day-month-year order", {
  expect_error(ss_create_template("A", "30-05-2019", path = tempdir()), "incorrect format")
})
