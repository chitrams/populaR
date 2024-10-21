library(jsonlite)
library(httr2)
library(purrr)
library(tidyverse)

get_base_levels <- function(target) {
  # eg. target:
  # - "locations"
  # - "data", "indicators", "44", "locations", "428", "start", "1995", "end", "2000" (requires key)

  base_url <- "https://population.un.org/dataportalapi/api/v1" 
  response <- request(base_url) |> 
    req_url_path_append(target) |>
    req_perform() |>
    resp_body_json(simplifyVector = TRUE)

  response$data |>
    # james - i think simplifyVector = TRUE is probably sufficient, but ymmv
    list_rbind(\(x) tibble::as_tibble(x))

  # Get the first page of data
  df <- response$data

  # Loop until there are new pages with data
  while (!is.null(response$nextPage)){

    #call the API for the next page
    response <- fromJSON(response$nextPage)

    #add the data of the new page to the data.frame 
    # with the data of the precious pages
    df <- rbind(df, response$data)

  }
  return(df)
}

# get_indicators <- function() {
#   base_url <- "https://population.un.org/dataportalapi/api/v1/data/indicators/ /locations/Australia"
# }

