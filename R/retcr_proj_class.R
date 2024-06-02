#' Class "Basic"
#'
#' A class to represent basic analysis data.
#'
#' @slot summary_data summary data
#' @slot reads_count read counts
#' @slot clonotype_count clonotype count
#' @slot mean_freq mean frequency
#' @slot geomean_freq geometric mean of clonotype frequency
#' @slot mean_cdr3nt_len mean CDR3 nucleotide length
#' @slot convergence mean of the unique CDR3 count in each sample
#' @slot spectratype spectratype data
#' @exportClass Basic
setClass("Basic",
  slots = c(
    summary_data = "data.frame",
    reads_count = "data.frame",
    clonotype_count = "data.frame",
    mean_freq = "data.frame",
    geomean_freq = "data.frame",
    mean_cdr3nt_len = "data.frame",
    convergence = "data.frame",
    spectratype = "data.frame"
  )
)

#' Class "Motif"
#'
#' A class to represent motif data.
#'
#' @slot aa_spectratype aa spectratype data.
#' @slot aa_max_spectratype aa max spectratype data.
#' @slot aa_motif_count aa motif count data.
#' @exportClass Motif
setClass("Motif",
  slots = c(
    aa_spectratype = "data.frame",
    aa_max_spectratype = "data.frame",
    aa_motif_count = "data.frame"
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
#' @slot basic contains basic analysis information.
#' @exportClass reTCRProj
setClass("reTCRProj",
  slots = c(
    data = "data.frame",
    basic = "Basic"
  )
)