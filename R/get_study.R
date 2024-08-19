source("R/utils-diversity.R")
source("R/utils-clonality.R")
source("R/utils-basic.R")
source("R/utils-motif.R")
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

  samplefile <- paste0(id, "_metadata_file.csv")
  samplepath <- system.file("extdata", samplefile, package = "reTCR")
  sampledata <- utils::read.csv(samplepath)

  mixfile <- paste0(id, "_mixcr_metadata_file.csv")
  mixpath <- system.file("extdata", mixfile, package = "reTCR")
  mixdata <- utils::read.csv(mixpath)

  basic <- .get_basic(data = mixdata, attr_col = attr_col)
  diversity <- .get_diversity(data = mixdata, attr_col = attr_col)
  clonality <- .get_clonality(data = mixdata, attr_col = attr_col)
  motif <- .get_motif(data = mixdata, attr_col = attr_col)
  hill <- .get_hill_numbers(df = mixdata)

  return(methods::new(
    "reTCRProj",
    data = mixdata,
    metadata = sampledata,
    basic = basic,
    diversity = diversity,
    clonality = clonality,
    motif = motif,
    hill = hill
  ))
}
