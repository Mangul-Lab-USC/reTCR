.get_clonality <- function(data, attr_col) {
  df_div <- data %>%
    dplyr::group_by(sample) %>%
    dplyr::summarise(clonotype_count = dplyr::n()) %>%
    dplyr::ungroup()

  pielou <- data %>%
    dplyr::left_join(df_div, by = "sample") %>%
    dplyr::mutate(clonality = freq * log(freq) / log(clonotype_count)) %>%
    dplyr::group_by(sample, !!rlang::sym(attr_col)) %>%
    dplyr::summarise(clonality = sum(clonality, na.rm = TRUE)) %>%
    dplyr::mutate(pielou = clonality + 1) %>%
    dplyr::select(sample, !!rlang::sym(attr_col), pielou) %>%
    dplyr::ungroup()

  df_clonality_portion <- data.frame()
  samples <- unique(data$sample)
  for (sample in samples) {
    df_temp <- data %>%
      dplyr::filter(sample == !!sample) %>%
      dplyr::arrange(dplyr::desc(freq)) %>%
      dplyr::mutate(clonotype_number = dplyr::row_number()) %>%
      dplyr::mutate(accum_freq = cumsum(freq)) %>%
      dplyr::filter(accum_freq >= 0 & accum_freq <= 0.1) %>%
      dplyr::arrange(dplyr::desc(accum_freq)) %>%
      dplyr::slice(1)
    df_clonality_portion <- dplyr::bind_rows(df_clonality_portion, df_temp)
  }

  return(
    methods::new(
      "Clonality",
      most_clonotype = data %>%
        dplyr::group_by(sample) %>%
        dplyr::slice_max(freq, with_ties = FALSE) %>%
        dplyr::ungroup() %>%
        dplyr::select(sample, !!rlang::sym(attr_col), cdr3aa, count),
      least_clonotype = data %>%
        dplyr::group_by(sample) %>%
        dplyr::slice_min(freq, with_ties = FALSE) %>%
        dplyr::ungroup() %>%
        dplyr::select(sample, !!rlang::sym(attr_col), cdr3aa, count),
      pielou = pielou,
      clonal_prop = df_clonality_portion %>%
        dplyr::select(sample, !!rlang::sym(attr_col), clonotype_number) %>%
        dplyr::rename(clonality_portion = clonotype_number),
      abundance = data.frame(),
      abundance_top = data.frame(),
      abundance_rare = data.frame()
    )
  )
}
