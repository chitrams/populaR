# Generate pkg skeleton ---------

install.packages("usethis")
library("usethis")

usethis::create_package(path = ".")

usethis::use_package()

# Load data ------

library(jsonlite)
library(httr)

# Declares the base url for calling the API
base_url <- "https://population.un.org/dataportalapi/api/v1"

# Creates the target URL, indicators, in this instance
target <- paste0(base_url, "/indicators/")

# Get the response, which includes data as well as information on pagination and number of records
response <- fromJSON(target)

# Get the first page of data
df <- response$data

# Loop until there are new pages with data
while (!is.null(response$nextPage)){

  #call the API for the next page
  response <- fromJSON(response$nextPage)

  #add the data of the new page to the data.frame with the data of the precious pages
  df <- rbind(df, response$data)

}

status_code(GET(target))

# Update relative path to retrieve records on locations
target <- paste0(base_url, "/locations/")

# Call the API
response <- fromJSON(target)

# Get the first page of data
df <- response$data

# Get the other pages with data
while (!is.null(response$nextPage)){

  response <- fromJSON(response$nextPage)
  df <- rbind(df, response$data)

}

# Returning single indicator for single area -------

# Update the relative path to search for data on a specific indicator, location, and for specific years
target <- paste0(base_url, "/data/indicators/1/locations/4/start/2005/end/2010")

# Call the API
response <- fromJSON(target)

# Get the first page of data
df <- response$data

# Get the other pages with data
while (!is.null(response$nextPage)){

  response <- fromJSON(response$nextPage)
  df <- rbind(df, response$data)

}
