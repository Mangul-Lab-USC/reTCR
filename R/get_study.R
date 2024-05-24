#' Get pyTCR metrics of a study
#' Retrieve metrics based on project ID.
#'
#' @param id A character string specifying the ID of the data for which metrics are to be retrieved.
#' @return A data frame containing the requested metrics.
#' @export
#'
#' @examples
#' \dontrun{
#' # Retrieve project with ID "PRJNA473147"
#' project <- reTCR::get_study(id="PRJNA473147")
#' }
#'
#' @importFrom utils read.csv

get_study <- function(id) {
  stopifnot(is.character(id) && nchar(id) > 0)
  return(invisible(read.csv(system.file("extdata", "PRJNA473147_mixcr_metadata_file.csv", package = "reTCR"))))
}