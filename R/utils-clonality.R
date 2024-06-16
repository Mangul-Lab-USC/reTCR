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

  abundance_df <- data %>%
    dplyr::mutate(clonotype_group = dplyr::case_when(
      freq > 0.01 & freq <= 1 ~ "Hyperexpanded",
      freq > 0.001 & freq <= 0.01 ~ "Large",
      freq > 0.0001 & freq <= 0.001 ~ "Medium",
      freq > 0.00001 & freq <= 0.0001 ~ "Small",
      freq > 0 & freq <= 0.00001 ~ "Rare"
    ))

  .reads_group_top <- function(count) {
    if (count > 1 && count <= 10) {
      return("1-10")
    } else if (count >= 11 && count <= 100) {
      return("11-100")
    } else if (count >= 101 && count <= 1000) {
      return("101-1000")
    } else if (count >= 1001 && count <= 5000) {
      return("1001-5000")
    } else {
      return("None")
    }
  }

  abundance_top <- data %>%
    dplyr::arrange(sample, dplyr::desc(freq)) %>%
    dplyr::group_by(sample) %>%
    dplyr::slice_head(n = 100) %>%
    dplyr::mutate(reads_group = purrr::map_chr(count, .reads_group_top)) %>%
    dplyr::select(sample, !!rlang::sym(attr_col), reads_group)

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
      abundance = abundance_df %>%
        dplyr::group_by(sample, !!rlang::sym(attr_col), clonotype_group) %>%
        dplyr::summarize(relative_abundance = sum(freq)) %>%
        dplyr::ungroup(),
      abundance_top = abundance_top,
      abundance_rare = data.frame()
    )
  )
}
