% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_data.R
\name{get_indicator_data}
\alias{get_indicator_data}
\title{Get WPP data on an indicator from a specific location}
\usage{
get_indicator_data(
  indicator_id,
  location_id,
  start_year = 1950,
  end_year = 2100,
  .progress = TRUE
)
}
\arguments{
\item{indicator_id}{Numeric ID for the indicator. Common choices include:
\itemize{
\item 46: Age by sex in 5 year age groups
\item 47: Age by sex in 1 year age groups
}}

\item{location_id}{Numeric ID for the location (country)}

\item{start_year}{Numeric. Year to start estimates. Minimum 1950, maximum 2100. Default 1950.}

\item{end_year}{Numeric. Year to end estimates. Minimum 1951, maximum 2100. Default 2100.}

\item{.progress}{Boolean. Whether to show progress bars for query. Default TRUE.}
}
\value{
\code{tibble} with the following columns:
\itemize{
\item \code{locationId}: Numeric ID of location
\item \code{location}: Description of location
\item \code{iso3}: 3-character country code of location
\item \code{iso2}: 2-character country code of location
\item \code{locationTypeId}:
\item \code{indicatorId}: Numeric ID of indicator
\item \code{indicator}: Description of indicator
\item \code{indicatorDisplayName}: Publishable display name of indicator
}
}
\description{
Get data for a specific indicator, for a specific location from the WPP API
You will need to get the ID of indicators and locations from \link{get_id} to pass
into this.
}
\details{
Note: This function looks for your WPP API key in the environment variable
\code{WPP_API_KEY}. You can set this using \link{set_wpp_api_key} or in your \code{.Renviron}
file.
}
\examples{
aus_id <- get_id("Australia", type = "locations", search = FALSE, .progress = FALSE)
age_id <- get_id("Population by 5-year age groups and sex", type = "Indicators", search = FALSE, .progress = FALSE)
get_indicator_data(indicator_id = age_id$id, location_id = aus_id$id, start_year = 2020, end_year = 2024)

}
