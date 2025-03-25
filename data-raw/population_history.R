# Data from the API that has total population by
# * age
# * sex
# * age + sex
# from as early as possible
# 
# Projections are separate

world_id <- get_id("World", type = "locations")

age_id <- get_id("Population by 5-year age groups and sex", type = "Indicators", search = FALSE, .progress = FALSE)

# population_age_sex_fiveyr <- get_indicator_data(indicator_id = age_id$id, location_id = world_id$id, start_year = 1950, end_year = 2024)

all_countries <- get_id("", type = "locations") |>
  dplyr::filter(!name %in% "Holy See") |>
  filter(!is.na(longitude))

### WARNING
### This chunk takes upwards of five hours to run
### Use with extreme caution
ii <- 0
all_country_age_sex_fiveyr <- lapply(cli::cli_progress_along(1:nrow(all_countries)), function(i) {
  if (file.exists(paste0("data-raw/age_sex_fiveyr/age_sex_fiveyr_", all_countries$name[i], ".csv")))
    return (NA)
    ii <<- i
  population_age_sex_fiveyr <- get_age_data(location_id = all_countries$id[i], age_bracket = 5, by_sex = TRUE, start_year = 1950, end_year = 2023) 
  readr::write_csv(
    x = population_age_sex_fiveyr,
    file = paste0("data-raw/age_sex_fiveyr/age_sex_fiveyr_", all_countries$name[i], ".csv")
  )

  population_age_sex_fiveyr
})

csvs_to_load <- list.files("data-raw/age_sex_fiveyr/", full.names = TRUE)

wpp_age_sex_fiveyr <- lapply(csvs_to_load, function(s) {
  readr::read_csv(s) |>
    dplyr::mutate(
      sexId = factor(sexId)
    )
}) |> dplyr::bind_rows()

usethis::use_data(wpp_age_sex_fiveyr, overwrite = TRUE)

wpp_age_fiveyr <- wpp_age_sex_fiveyr |>
  dplyr::group_by(locationId, location, year, ageStart, ageEnd) |>
  dplyr::summarise(population = sum(population))

usethis::use_data(wpp_age_fiveyr, overwrite = TRUE)

wpp_sex_fiveyr <- wpp_age_sex_fiveyr |>
  dplyr::group_by(locationId, location, year, sexId) |>
  dplyr::summarise(population = sum(population))

usethis::use_data(wpp_sex_fiveyr, overwrite = TRUE)
