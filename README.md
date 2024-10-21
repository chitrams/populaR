
<!-- README.md is generated from README.Rmd. Please edit that file -->

# populaR <a href="http://www.michaellydeamore.com/populaR/"><img src="man/figures/logo.png" align="right" height="134" /></a>

<!-- badges: start -->
<!-- badges: end -->

populaR provides a convenient interface to the UN’s [World Population
Prospects](https://population.un.org/wpp/) API. Several pre-baked
datasets are included, as well as a convenient wrapper for more advanced
API users

## Installation

You can install the development version of populaR from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("chitrams/populaR")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(populaR)

# First you have to get the numeric ID of a location
get_id("Australia", type = "locations")
#> # A tibble: 5 × 6
#>      id name                                                 iso3  iso2  longitude latitude
#>   <int> <chr>                                                <chr> <chr>     <dbl>    <dbl>
#> 1    36 Australia                                            AUS   AU         134.    -25.3
#> 2   927 Australia/New Zealand                                ANZ   ZL          NA      NA  
#> 3  1834 Australia/New Zealand                                ANZ   ZL          NA      NA  
#> 4  1835 Oceania (excluding Australia and New Zealand)        OCA   OZ          NA      NA  
#> 5  5502 Europe, Northern America, Australia, and New Zealand SDG   SD          NA      NA
```
