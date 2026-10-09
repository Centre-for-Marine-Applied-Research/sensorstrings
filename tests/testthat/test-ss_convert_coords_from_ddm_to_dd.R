# ss_convert_coords_from_ddm_to_dd() ---------------------------------------


test_that("sign comes from the hemisphere in the column name", {
  out <- ss_convert_coords_from_ddm_to_dd(dat_ddm)

  expect_equal(round(out$deployment_latitude, 5), c(45.36085, 44.43730, NA))
  expect_equal(round(out$deployment_longitude, 5), c(-61.40678, -64.25063, -63))
  expect_equal(round(out$retrieval_latitude, 5), c(-33.86667, NA, NA))
  expect_equal(round(out$retrieval_longitude, 5), c(151.20833, NA, NA))
})

test_that("works with one row", {
  out <- ss_convert_coords_from_ddm_to_dd(dat_ddm[1, ])
  expect_equal(round(out$deployment_longitude, 5), -61.40678)
})

test_that("existing decimal-degree values are kept and NAs filled", {
  dat <- dat_ddm
  dat$deployment_latitude <- c(45, NA, 46)
  out <- ss_convert_coords_from_ddm_to_dd(dat)
  expect_equal(round(out$deployment_latitude, 5), c(45, 44.43730, 46))
})

test_that("keep_ddm = FALSE drops the ddm columns", {
  out <- ss_convert_coords_from_ddm_to_dd(dat_ddm, keep_ddm = FALSE)
  expect_false(any(grepl("_ddm$", colnames(out))))
  expect_true("station" %in% colnames(out))
})

test_that("bad values warn and return NA; no ddm columns errors", {
  dat <- data.frame(deployment_latitude_n_ddm = c("45 21.651", "45.36"))
  expect_warning(out <- ss_convert_coords_from_ddm_to_dd(dat), "Can't convert")
  expect_true(is.na(out$deployment_latitude[2]))

  expect_warning(
    ss_convert_coords_from_ddm_to_dd(data.frame(x_n_ddm = "45 61")),
    "less than 60"
  )
  expect_error(ss_convert_coords_from_ddm_to_dd(data.frame(latitude = 45)))
})
