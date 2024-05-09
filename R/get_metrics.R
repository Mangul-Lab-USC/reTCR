#' Get pyTCR metrics of a study
#'
#' Retrieve metrics based on provided ID and type.
#'
#' @param id A character string specifying the ID of the data for which metrics are to be retrieved.
#' @param type An enumeration specifying the type of metrics to retrieve. Possible values are:
#'   \itemize{
#'     \item "basic" - Basic metrics.
#'     \item "metadata" - Metadata.
#'     \item "clonality" - Clonality metrics.
#'     \item "segment" - Segment usage metrics.
#'     \item "diversity" - Diversity metrics.
#'     \item "motif" - Motif metrics.
#'   }
#'
#' @return A data frame containing the requested metrics.
#' @export
#'
#' @examples
#' \dontrun{
#' # Retrieve basic metrics for ID "sample1"
#' basic_metrics <- reTCR::get_metrics(id="PRJNA473147", type="basic")
#' }
#'
#' @importFrom utils read.csv

get_metrics <- function(id, type) {
  # Check if the ID is string and not empty
  if (!is.character(id) || nchar(id) == 0) {
    stop("Invalid ID")
  }

  # Check if the type is valid
  if (!type %in% c("basic", "metadata", "clonality", "segment", "diversity", "motif")) {
    stop("Invalid type")
  }

  # if (type == "metadata") {
  #   return(read.csv(system.file("extdata", "PRJNA473147_metadata_file.csv", package = "reTCR")))
  # } 
  # return (read.csv(system.file("extdata", "PRJNA473147_file.csv", package = "reTCR")))

  return(read.csv(system.file("extdata", "PRJNA473147_metadata_file.csv", package = "reTCR")))
}
