library("vcr") # *Required* as vcr is set up on loading
if (!nzchar(Sys.getenv("WPP_API_KEY"))) {
  Sys.setenv("WPP_API_KEY" = "foobar")
}
invisible(vcr::vcr_configure(
  dir = vcr::vcr_test_path("fixtures")
))
vcr::check_cassette_names()
