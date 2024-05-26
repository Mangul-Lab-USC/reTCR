#' Class "Motif"
#'
#' A class to represent motif data.
#'
#' @slot aa_count A numeric value representing the amino acid count.
#' @slot nucl_count A numeric value representing the nucleotide count.
#' @slot spectratype A data frame containing spectratype data.
#' @exportClass Motif
setClass("Motif",
  slots = c(
    aa_count = "numeric",
    nucl_count = "numeric",
    spectratype = "data.frame"
  )
)

#' Class "Diversity"
#'
#' A class to represent diversity data.
#'
#' @slot shannon_index A numeric value representing the Shannon index.
#' @slot gini_index A numeric value representing the Gini index.
#' @exportClass Diversity
setClass("Diversity",
  slots = c(
    shannon_index = "numeric",
    gini_index = "numeric"
  )
)

#' Class "reTCRProj"
#'
#' A class to represent a reTCR project
#'
#' @slot data contains the main data for the project.
#' @slot motif contains motif information.
#' @slot diversity contains diversity information.
#' @exportClass reTCRProj
setClass("reTCRProj",
  slots = c(
    data = "data.frame",
    motif = "Motif",
    diversity = "Diversity"
  )
)