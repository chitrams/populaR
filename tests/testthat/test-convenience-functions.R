test_that("Filter Country", {
  expect_equal(
    wpp_age_sex_fiveyr |> filter_country("Australia"),
    wpp_age_sex_fiveyr |> dplyr::filter(location == "Australia")
  )

  expect_error(
    wpp_age_fiveyr |> filter_country("Australia", location_column = default_column)
  )

  expect_equal(
    wpp_age_sex_fiveyr |> filter_country("not-a-country") |> nrow(),
    0
  )
})

test_that("Filter Year", {
  expect_equal(
    wpp_age_sex_fiveyr |> dplyr::filter(year == 2023),
    wpp_age_sex_fiveyr |> filter_year(2023)
  )
})