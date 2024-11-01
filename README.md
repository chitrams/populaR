
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

First you have to get the numeric ID of a location. You can do this
through the `get_id` function with `type = "locations"`. If you know the
exact wording, set `search = FALSE` to speed up the query.

``` r
library(populaR)
get_id("Australia", type = "locations", .progress = FALSE)
#> # A tibble: 5 × 6
#>      id name                                      iso3  iso2  longitude latitude
#>   <int> <chr>                                     <chr> <chr>     <dbl>    <dbl>
#> 1    36 Australia                                 AUS   AU         134.    -25.3
#> 2   927 Australia/New Zealand                     ANZ   ZL          NA      NA  
#> 3  1834 Australia/New Zealand                     ANZ   ZL          NA      NA  
#> 4  1835 Oceania (excluding Australia and New Zea… OCA   OZ          NA      NA  
#> 5  5502 Europe, Northern America, Australia, and… SDG   SD          NA      NA
```

Then, you need the numeric ID of the indicator. You can search for this
in the same way

``` r
get_id("Population by 5-year age groups and sex", type = "Indicators", .progress = FALSE)
#> # A tibble: 1 × 4
#>      id name                                    shortName       description     
#>   <int> <chr>                                   <chr>           <chr>           
#> 1    46 Population by 5-year age groups and sex PopByAge5AndSex Annual populati…
```

Common indicators include:

| Indicator ID | Description                             |
|-------------:|:----------------------------------------|
|           46 | Population by 5-year age groups and sex |

By default, the package does not clean API columns, and so will return
quite a lot of information.
