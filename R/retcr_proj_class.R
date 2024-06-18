#' Class "Basic"
#'
#' A class to represent basic metrics
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

#' Class "Diversity"
#'
#' A class to represent diversity metrics
#'
#' @slot shannon Shannon-Wiener indexes
#' @slot simpson Simpson indexes
#' @slot d50 D50 index
#' @slot chao1 Chao1 estimate
#' @slot gini_coeff Gini coefficient
#' @exportClass Diversity
setClass("Diversity",
  slots = c(
    shannon = "data.frame",
    simpson = "data.frame",
    d50 = "data.frame",
    chao1 = "data.frame",
    gini_coeff = "data.frame"
  )
)

#' Class "Clonality"
#'
#' A class to represent clonality metrics
#'
#' @slot most_clonotype most frequent clonotype
#' @slot least_clonotype least frequent clonotype
#' @slot pielou 1-Pielou index
#' @slot clonal_prop clonal proportion
#' @slot abundance relative abundance (in all clonotypes)
#' @slot abundance_top relative abundance (in top 100 clonotypes)
#' @slot abundance_rare relative abundance (in rare clonotypes)
#' @exportClass Clonality
setClass("Clonality",
  slots = c(
    most_clonotype = "data.frame",
    least_clonotype = "data.frame",
    pielou = "data.frame",
    clonal_prop = "data.frame",
    abundance = "data.frame",
    abundance_top = "data.frame",
    abundance_rare = "data.frame"
  )
)

#' Class "Motif"
#'
#' A class to represent motif metrics
#'
#' @slot aa_spectra Amino acid spectratype
#' @slot aa_max_spectra Amino acid max spectratype
#' @slot aa_motif_count Amino acid motif count table
#' @slot aa_most_motif Most abundant amino acid motif per sample
#' @exportClass Motif
setClass("Motif",
  slots = c(
    aa_spectra = "data.frame",
    aa_max_spectra = "data.frame",
    aa_motif_count = "data.frame",
    aa_most_motif = "data.frame"
  )
)

#' Class "reTCRProj"
#'
#' A class to represent a reTCR project
#'
#' @slot data contains the MIXCR data for the project
#' @slot metadata contains the sample metadata
#' @slot basic contains basic metrics
#' @slot diversity contains diversity metrics
#' @slot clonality contains clonality metrics
#' @slot motif contains motif metrics
#' @slot hill contains Hill numbers
#' @exportClass reTCRProj
setClass("reTCRProj",
  slots = c(
    data = "data.frame",
    metadata = "data.frame",
    basic = "Basic",
    diversity = "Diversity",
    clonality = "Clonality",
    motif = "Motif",
    hill = "data.frame"
  )
)
