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

get_study <- function(id) {
  stopifnot(is.character(id) && nchar(id) > 0)
  filename <- paste0(id, "_mixcr_metadata_file.csv")
  filepath <- system.file("extdata", filename, package = "reTCR")
  data <- utils::read.csv(filepath)

  motif <- .get_motif(data)
  diversity <- .get_diversity(data)

  return(methods::new(
    "reTCRProj",
    data = data,
    motif = motif,
    diversity = diversity
  ))
}

.get_aa_spectratype <- function(data) {
  aa_spec <- data %>%
    dplyr::mutate(aa_length = nchar(cdr3aa)) %>%
    dplyr::group_by(sample, cmv_status, aa_length) %>%
    dplyr::summarise(
      spectratype = sum(freq, na.rm = TRUE),
      .groups = "drop"
    )
  return(aa_spec)
}

.get_most_freq_aa_spectratype <- function(aa_spec) {
  aa_max <- aa_spec %>%
    dplyr::group_by(sample) %>%
    dplyr::slice_max(spectratype, n = 1)
  return(aa_max)
}

.get_aa_motif_list <- function(aa_list, k) {
  aa_motif_list <- list()
  for (aa in aa_list) {
    for (i in seq_len(nchar(aa) - k + 1)) {
      aamotif <- substr(aa, i, i + k - 1)
      aa_motif_list[[aamotif]] <- aa_motif_list[[aamotif]] %||% 0 + 1
    }
  }
  return(aa_motif_list)
}

.get_aa_motif_count <- function(data, aa_max) {
  samples <- unique(data$sample)
  aa_motif <- dplyr::tibble(
    motif = character(),
    count = numeric(),
    sample = character()
  )
  for (sample in samples) {
    data_temp <- data %>% dplyr::filter(.data$sample == !!sample)
    motif_counts <- .get_aa_motif_list(data_temp$cdr3aa, 6)
    data_temp <- tibble(
      motif = names(motif_counts),
      count = as.numeric(unlist(motif_counts)),
      sample = sample
    )
    aa_motif <- dplyr::bind_rows(aa_motif, data_temp)
  }
  aa_motif_count <- dplyr::left_join(
    aa_motif,
    dplyr::select(aa_max, sample, cmv_status),
    by = "sample"
  )
  return(aa_motif_count)
}

# .get_most_motif_per_sample <- function(data) {
#   aa_max <- data %>%
#     dplyr::group_by(sample) %>%
#     dplyr::slice_max(freq, n = 1)
#   return(aa_max)
# }

.get_motif <- function(data) {
  aa_spec <- .get_aa_spectratype(data)
  aa_max <- .get_most_freq_aa_spectratype(aa_spec)
  aa_motif_count <- .get_aa_motif_count(data, aa_max)
  # aa_most_abundant_motif <- .get_most_motif_per_sample(aa_motif_count)

  return(
    methods::new(
      "Motif",
      aa_spectratype = aa_spec,
      aa_max_spectratype = aa_max,
      aa_motif_count = aa_motif_count
    )
  )
}

.get_diversity <- function(data) {
  return(methods::new(
    "Diversity",
    shannon_index = 1.5,
    gini_index = 0.3
  ))
}
