# written with Claude Opus 5.5

# shared objects for the I/O, log, report-table and mooring tests

path_extdata <- system.file("extdata", package = "sensorstrings")

dat_extdata <- suppressMessages(ss_compile_deployment_data(path_extdata))

metadata_xlsx <- system.file(
  "extdata/metadata_tracking_example.xlsx", package = "sensorstrings"
)

# a new, empty folder in tempdir(); call inside test_that() and unlink at the end
new_tmp_dir <- function(prefix = "ss-test-") {
  d <- tempfile(prefix)
  dir.create(d)
  d
}
