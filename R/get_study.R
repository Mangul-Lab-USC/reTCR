source("R/utils-basic.R")
source("R/utils-diversity.R")
source("R/utils-clonality.R")
source("R/utils-hill.R")

#' Get pyTCR data of a project
#'
#' Retrieve the pyTCR data of a project by its ID.
#'
#' @param id Character. Project ID.
#' @param attr_col Character. Attribute column name.
#' @return An object of class `reTCRProj`.
#' @export
#'
#' @examples
#' \dontrun{
#' proj <- reTCR::get_study(id="PRJNA473147", attr_col="cmv_status")
#' }

get_study <- function(id, attr_col) {
  stopifnot(is.character(id) && nchar(id) > 0)
  filename <- paste0(id, "_mixcr_metadata_file.csv")
  filepath <- system.file("extdata", filename, package = "reTCR")
  data <- utils::read.csv(filepath)

  basic <- .get_basic(data = data, attr_col = attr_col)
  diversity <- .get_diversity(data = data, attr_col = attr_col)
  clonality <- .get_clonality(data = data, attr_col = attr_col)
  hill <- .get_hill_numbers(df = data)

  return(methods::new(
    "reTCRProj",
    data = data,
    basic = basic,
    diversity = diversity,
    clonality = clonality,
    hill = hill
  ))
}
