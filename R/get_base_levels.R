#' Get parameter inputs for population data API
#' 
#' Gets information about indicators (i.e. dataset) and locations for further
#' querying from the WPP API
#' 
#' @param target String, one of "Indicators" or "locations"
#' @return `tibble` containing a wide range of information about the requested endpoint
#' @export
#' 
#' @examples
#' get_base_levels("Indicators")
#' get_base_levels("locations")
#' 
get_base_levels <- function(target) {

  allowed_targets <- c("Indicators", "locations")
  if (!target %in% c("Indicators", "locations")) {
    cli::cli_abort("Input {.arg {target}} must be one of {.arg {allowed_targets}}")
  }
  
  
  base_url <- "https://population.un.org/dataportalapi/api/v1" 
  response <- httr2::request(base_url) |> 
    httr2::req_url_path_append(target) |>
    httr2::req_cache(path = tempfile()) |>
    httr2::req_perform_iterative(
      next_req = httr2::iterate_with_offset("pageNumber", 
      resp_pages = function(resp) { 
        httr2::resp_body_json(resp, simplifyVector = TRUE)$pages 
      })
    )
  
    if (length(response) != httr2::resp_body_json(response[[1]])$pages) {
      cli::cli_alert_danger(
        "Response has {length(response)} pages but expected {httr2::resp_body_json(response[[1]]$pages}"
      )
    }

  response_data <- lapply(response, function(r) {
    body <- httr2::resp_body_json(r, simplifyVector = TRUE)
    
    tibble::as_tibble(body$data)
  }) |>
  dplyr::bind_rows()

  return(response_data)
}

#' IDs of indicators
#' 
#' Get numeric IDs of indicators and locations for the WPP API
#' 
#' @param name Name of the variable to search for
#' @param type One of "locations" or "Indicators", which dataset to search
#' @param search Whether to perform simple search/matching. Defaults to TRUE
#' 
#' @return `tibble` containing only the matching records. Column `id` is the numeric
#' id which will be needed downstream
#' 
#' @export
#' 
#' @examples
#' get_id("Australia", typ = "locations")
#' 
get_id <- function(name, type, search = TRUE) {
  
  search_dataset <- get_base_levels(type)

  if (type == "Indicators") {
    search_dataset <- search_dataset[, c("id", "name", "shortName", "description")]
  }

  if (!search)
    return (search_dataset[search_dataset$name == name,])
  
  else {
    return(search_dataset[grep(name, search_dataset$name, ignore.case = TRUE),])
  }
}