test_that("base levels", {
  vcr::use_cassette("base-locations", {
    base_locations <- get_base_levels("locations", .progress = FALSE)
  })

  vcr::use_cassette("base-Indicators", {
    base_Indicators <- get_base_levels("Indicators", .progress = FALSE)
  })
  # We have to use progress FALSE because differences in loading
  # times cause this test to failçç
  expect_snapshot(base_locations)

  expect_snapshot(base_Indicators)
})
