#' Age data from the WPP API
#' 
#' Gets age data in either 1- or 5- year age brackets, potentially segregated by sex
#' 
#' @param location_id tibble containing the location id of interest. Typically output from [get_id].
#' @param age_bracket integer. Either 1 or 5, indicating the size of the brackets
#' @param by_sex boolean TRUE to segregate results by sex
#' @param start_year integer Start year for data. Default 1950 (as early as available)
#' @param end_year integer End year for data. Default 2100 (as late as available)
#' @param .progress boolean Whether to show progress bar. Default TRUE.
#' 
#' @return tibble containing location_id, age information, sex, year, in a slightly
#' cleaner format than the raw API call.
#' 
#' @examples
#' aus_id <- get_id("Australia", type = "locations", search = FALSE, .progress = FALSE)
#' get_age_data(aus_id, age_bracket = 5, by_sex = TRUE)
#' 
#' @export
get_age_data <- function(location_id, age_bracket, by_sex, start_year = 1950, end_year = 2100, .progress = TRUE) {

  search_string <- paste0("Population by ", age_bracket, "-year age groups")
  if (by_sex)
    search_string <- paste0(search_string, " and sex")

  indicator_id <- get_id(search_string, type = "Indicators", search = FALSE, .progress = FALSE)

  indicator_data <- get_indicator_data(indicator_id = indicator_id$id, location_id = location_id, start_year = start_year, end_year = end_year) |>
      dplyr::select(locationId, location, year = timeLabel, sexId, ageStart, ageEnd, population = value) |>
      dplyr::mutate(
        locationId = factor(locationId)
      )
  
  if (by_sex)
    indicator_data <- indicator_data |>
      dplyr::mutate(sexId = factor(sexId, levels = 1:3, labels = c("Male", "Female", "Both sexes")))
  
  indicator_data

}

#' Filter WPP age data by country
#' 
#' Filters WPP age data to a country
#' 
#' @param .data A tibble containing WPP age data
#' @param country Name of the country
#' @param location_column Name of the location column, unquoted. Default `location`.
#' 
#' @return A tibble containing WPP age data for the specified country
#' @export
filter_country <- function(.data, country, location_column = location) {
  location_column <- rlang::enquo(location_column)
  if (!rlang::quo_name(location_column) %in% colnames(.data) ) {
  cli::cli_abort("No column named {.field {rlang::quo_name(location_column)}} found in input data")
  }

  dplyr::filter(.data, !!location_column == country)
}