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

#' @import methods
#' @import utils
#' @import dplyr

get_study <- function(id) {
  stopifnot(is.character(id) && nchar(id) > 0)

  data <- utils::read.csv(
    base::system.file(
      "extdata",
      paste0(id, "_mixcr_metadata_file.csv"),
      package = "reTCR"
    )
  )

  motif <- .get_motif(data)
  diversity <- .get_diversity(data)

  return(methods::new("reTCRProj",
    data = data,
    motif = motif,
    diversity = diversity
  ))
}

.get_motif <- function(data) {
  spectratype <- data %>%
    dplyr::mutate(aa_length = nchar(cdr3aa)) %>%
    dplyr::group_by(sample, cmv_status, aa_length) %>%
    dplyr::summarise(
      spectratype = sum(freq, na.rm = TRUE),
      .groups = "drop"
    )

  return(methods::new("Motif",
    aa_count = 10,
    nucl_count = 20,
    spectratype = utils::head(spectratype)
  ))
}

.get_diversity <- function(data) {
  return(methods::new("Diversity",
    shannon_index = 1.5,
    gini_index = 0.3
  ))
}
