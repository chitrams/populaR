## code to prepare `population_projections` dataset goes here

devtools::load_all()

world_id <- get_id("World", type = "locations")

age_id <- get_id("Population by 5-year age groups and sex", type = "Indicators", search = FALSE, .progress = FALSE)

population_age_sex_fiveyr <- get_indicator_data(indicator_id = age_id$id, location_id = world_id$id, start_year = 1950, end_year = 2024)

all_countries <- get_id("", type = "locations")

all_country_age_sex_fiveyr <- lapply(cli::cli_progress_along(1:nrow(all_countries)), function(i) {
  if (file.exists(paste0("data-raw/projections/age_sex_fiveyr/age_sex_fiveyr_", all_countries$name[i])))
    return (NA)
  
  population_age_sex_fiveyr <- get_indicator_data(indicator_id = age_id$id, location_id = all_countries$id[i], start_year = 2025, end_year = 2100) |>
    dplyr::select(locationId, location, year = timeLabel, sexId, ageStart, ageEnd) |>
    dplyr::mutate(
      locationId = factor(locationId),
      sexId = factor(sexId, levels = 1:3, labels = c("Male", "Female", "Both sexes"))
    )
  
  readr::write_csv(
    x = population_age_sex_fiveyr,
    file = paste0("data-raw/projections/age_sex_fiveyr/age_sex_fiveyr_", all_countries$name[i])
  )

  population_age_sex_fiveyr
})

usethis::use_data(population_projections, overwrite = TRUE)
