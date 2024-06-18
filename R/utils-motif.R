.get_most_freq_aa_spec <- function(aa_spec) {
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

.get_aa_motif_count <- function(data, aa_max, attr_col) {
  return(aa_motif_count)
}

.get_motif <- function(data, attr_col) {
  aa_spec <- data %>%
    dplyr::mutate(aa_length = nchar(cdr3aa)) %>%
    dplyr::group_by(sample, !!rlang::sym(attr_col), aa_length) %>%
    dplyr::summarise(
      spectratype = sum(freq, na.rm = TRUE),
      .groups = "drop"
    )

  aa_max <- aa_spec %>%
    dplyr::group_by(sample) %>%
    dplyr::slice_max(spectratype, n = 1)

  # aa motif count table
  samples <- unique(data$sample)
  aa_motif_tb <- dplyr::tibble(
    motif = character(),
    count = numeric(),
    sample = character()
  )

  for (sample in samples) {
    data_temp <- data %>% dplyr::filter(data$sample == !!sample)
    motif_list <- .get_aa_motif_list(data_temp$cdr3aa, 6)
    data_temp <- dplyr::tibble(
      motif = names(motif_list),
      count = as.numeric(unlist(motif_list)),
      sample = sample
    )
    aa_motif_tb <- dplyr::bind_rows(aa_motif_tb, data_temp)
  }

  aa_motif_count <- dplyr::left_join(
    aa_motif_tb,
    dplyr::select(aa_max, sample, !!rlang::sym(attr_col)),
    by = "sample"
  )

  # most abundant motif per sample
  aa_most_abundant_motif <- aa_motif_count %>%
    dplyr::group_by(sample) %>%
    dplyr::slice_max(count, n = 1)

  return(
    methods::new(
      "Motif",
      aa_spectra = aa_spec,
      aa_max_spectra = aa_max,
      aa_motif_count = aa_motif_count,
      aa_most_motif = aa_most_abundant_motif
    )
  )
}
