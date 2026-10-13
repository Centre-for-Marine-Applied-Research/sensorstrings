# # ss_read_nsdfa_metadata() ------------------------------------------------

nsdfa <- ss_read_nsdfa_metadata(
  system.file("extdata/nsdfa_tracking_example.xlsx",  package = "sensorstrings"))

nsdfa[, c("County", "Waterbody", "Station_Name", "Depl_Date", "Recv_Date", "Depl_Lon")]


test_that("ss_read_nsdfa_metadata() reads in all data", {
  expect_equal(nrow(nsdfa), 4)
  expect_equal(ncol(nsdfa), 30)
})


test_that("ss_read_nsdfa_metadata() reads in correct classes", {
  expect_equal(class(nsdfa$Depl_Date), "Date")
  expect_equal(class(nsdfa$Recv_Date), "Date")

  expect_equal(class(nsdfa$Depl_Lat), "numeric")
  expect_equal(class(nsdfa$Depl_Lon), "numeric")
})

# spot checks
test_that("ss_read_nsdfa_metadata() corrects waterbody names", {
  expect_equal(nrow(filter(nsdfa, Waterbody == "Pipers lake")), 0)
  expect_equal(nrow(filter(nsdfa, Waterbody == "Piper Lake")), 1)

  expect_equal(nrow(filter(nsdfa, Waterbody == "St Marys Bay")), 0)
  expect_equal(nrow(filter(nsdfa, Waterbody == "St. Marys Bay")), 1)

  expect_equal(nrow(filter(nsdfa, Waterbody == "St Margarets Bay")), 0)
  expect_equal(nrow(filter(nsdfa, Waterbody == "St. Margarets Bay")), 1)

  expect_equal(nrow(filter(nsdfa, Station_Name == "Owls head")), 0)
  expect_equal(nrow(filter(nsdfa, Station_Name == "Owls Head")), 1)

  expect_equal(
    nrow(filter(nsdfa, Waterbody == "Tor Bay" & Station_Name == "Bald Rock")), 0
  )

})
