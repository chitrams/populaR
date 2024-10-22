#' @export
set_wpp_api_key <- function(key) {
  Sys.setenv(WPP_API_KEY = key)
}

check_wpp_api_key <- function() {
  if (Sys.getenv("WPP_API_KEY") == "") {
    cli::cli_abort("No API key detected. Set using {.code set_wpp_key_key()} or inside `.Renviron`")
  }
}

get_wpp_api_key <- function() {
  check_wpp_api_key()
  Sys.getenv("WPP_API_KEY")
}