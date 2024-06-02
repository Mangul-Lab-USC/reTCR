source("R/utils-basic.R")

#' Get pyTCR data of a project
#'
#' Retrieve the pyTCR data of a project by its ID.
#'
#' @param id Character. Project ID.
#' @param attribute_col Character. Attribute column name.
#' @return An object of class `reTCRProj`.
#' @export
#'
#' @examples
#' \dontrun{
#' proj <- reTCR::get_study(id="PRJNA473147", attribute_col="cmv_status")
#' }
get_study <- function(id, attribute_col) {
  stopifnot(is.character(id) && nchar(id) > 0)
  filename <- paste0(id, "_mixcr_metadata_file.csv")
  filepath <- system.file("extdata", filename, package = "reTCR")
  data <- utils::read.csv(filepath)
  basic <- .get_basic(data = data, attribute_col = attribute_col)
  return(methods::new(
    "reTCRProj",
    data = data,
    basic = basic
  ))
}
