test_that("base levels", {
  # We have to use progress FALSE because differences in loading
  # times cause this test to failçç
  expect_snapshot(get_base_levels("locations", .progress = FALSE))

  expect_snapshot(get_base_levels("Indicators", .progress = FALSE))
})
