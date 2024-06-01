source("R/utils-basic.R")

#' Get pyTCR data of a project
#'
#' Retrieve the pyTCR data of a project by its ID.
#'
#' @param id Character. Project ID.
#' @return An object of class `reTCRProj`.
#' @export
#'
#' @examples
#' \dontrun{
#' proj <- reTCR::get_study(id = "PRJNA473147")
#' }
get_study <- function(id) {
  stopifnot(is.character(id) && nchar(id) > 0)
  filename <- paste0(id, "_mixcr_metadata_file.csv")
  filepath <- system.file("extdata", filename, package = "reTCR")
  data <- utils::read.csv(filepath)
  basic <- .get_basic(data)
  return(methods::new(
    "reTCRProj",
    data = data,
    basic = basic
  ))
}
