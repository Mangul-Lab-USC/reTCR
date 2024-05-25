#' Get pyTCR data of a project
#'
#' @param id Project ID.
#' @return Data frame with the project data.
#' @export
#'
#' @examples
#' \dontrun{ 
#' # Get data with ID "PRJNA473147"
#' project <- reTCR::get_study(id="PRJNA473147")
#' }
#' @import utils
#' @import methods

get_study <- function(id) {
  stopifnot(is.character(id) && nchar(id) > 0)
  return(invisible(read.csv(
    system.file("extdata", "PRJNA473147_mixcr_metadata_file.csv", package = "reTCR")
  )))
}
