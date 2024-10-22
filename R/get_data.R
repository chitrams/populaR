#' Get WPP data on an indicator from a specific location
#'
#' Get data for a specific indicator, for a specific location from the WPP API
#' You will need to get the ID of indicators and locations from [get_id] to pass
#' into this.
#' 
#' Note: This function looks for your WPP API key in the environment variable
#' `WPP_API_KEY`. You can set this using [set_wpp_api_key] or in your `.Renviron`
#' file.
#' 
#' @param indicator_id Numeric ID for the indicator. Common choices include:
#' \itemize{
#'   \item 46: Age by sex in 5 year age groups
#'   \item 47: Age by sex in 1 year age groups
#' }
#' 
#' @param location_id Numeric ID for the location (country)
#' @param start_year Numeric. Year to start estimates. Minimum 1950, maximum 2100. Default 1950.
#' @param end_year Numeric. Year to end estimates. Minimum 1951, maximum 2100. Default 2100.
#' @param .progress Boolean. Whether to show progress bars for query. Default TRUE.
#' 
#' @return `tibble` with the following columns:
#' \itemize{
#'   \item `locationId`: Numeric ID of location
#'   \item `location`: Description of location
#'   \item `iso3`: 3-character country code of location
#'   \item `iso2`: 2-character country code of location
#'   \item `locationTypeId`:
#'   \item `indicatorId`: Numeric ID of indicator
#'   \item `indicator`: Description of indicator
#'   \item `indicatorDisplayName`: Publishable display name of indicator
#' }
#' 
#' 
#' @examples
#' aus_id <- get_id("Australia", type = "locations", search = FALSE, .progress = FALSE)
#' age_id <- get_id("Population by 5-year age groups and sex", type = "Indicators", search = FALSE, .progress = FALSE)
#' get_indicator_data(indicator_id = age_id$id, location_id = aus_id$id)
#' 
#' @export
get_indicator_data <- function(indicator_id, location_id, start_year = 1950, end_year = 2100, .progress = TRUE) {

  assertthat::is.number(start_year)
  assertthat::is.number(end_year)

  if (end_year < start_year) {
    cli::cli_abort("`end_year` {end_year} is less than `start_year` {start_year}")
  }

  check_wpp_api_key()

  base_url <- "https://population.un.org/dataportalapi/api/v1/data" 

  response <- httr2::request(base_url) |> 
    httr2::req_url_path_append(
      "indicators", indicator_id,
      "locations", location_id,
      "start", start_year,
      "end", end_year
    ) |>
    httr2::req_url_query(
      pagingInHeader = "false",
      format = "json"
    ) |>
    httr2::req_auth_bearer_token(Sys.getenv("WPP_API_KEY")) |>
    httr2::req_cache(path = tempfile()) |>
    httr2::req_perform_iterative(
      next_req = httr2::iterate_with_offset(
        "pageNumber", 
        resp_pages = function(resp) { 
          httr2::resp_body_json(resp, simplifyVector = TRUE)$pages 
          }
      ),
      max_reqs = Inf,
      progress = .progress
    )
  
  response_data <- lapply(response, function(r) {
      body <- httr2::resp_body_json(r, simplifyVector = TRUE)
      
      tibble::as_tibble(body$data)
    }) |>
    dplyr::bind_rows()
}
