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

#' @importFrom methods new
#' @importFrom utils read.csv

get_study <- function(id) {
  stopifnot(is.character(id) && nchar(id) > 0)

  data <- read.csv(
    system.file(
      "extdata",
      paste0(id, "_mixcr_metadata_file.csv"),
      package = "reTCR"
    )
  )

  motif <- new("Motif", aa_count = 10, nucl_count = 20)
  diversity <- new("Diversity", shannon_index = 1.5, gini_index = 0.3)

  return(new("reTCRProj",
    data = data,
    motif = motif,
    diversity = diversity
  ))
}
