.get_diversity <- function(data, attr_col) {
  div_data <- data %>%
    dplyr::group_by(sample, !!rlang::sym(attr_col)) %>%
    dplyr::summarise(
      clonotype_count = dplyr::n()
    ) %>%
    dplyr::left_join(data, by = c("sample", attr_col))

  diversity <- div_data %>%
    dplyr::group_by(sample, !!rlang::sym(attr_col)) %>%
    dplyr::summarise(
      shannon_index = sum(-freq * log(freq)),
      shannon_wiener_index = exp(sum(-freq * log(freq))),
      normalized_shannon_wiener_index = sum(-freq * log(freq)) / log(dplyr::n()),
      simpson_index = sum(freq^2),
      inverse_simpson_index = 1 / sum(freq^2),
      gini_simpson_index = 1 - sum(freq^2),
    )

  df_d50 <- data.frame()
  samples <- unique(div_data$sample)
  for (sample in samples) {
    df_temp <- div_data %>%
      dplyr::filter(sample == !!sample) %>%
      dplyr::arrange(dplyr::desc(freq)) %>%
      dplyr::mutate(clonotype_number = dplyr::row_number()) %>%
      dplyr::mutate(accum_freq = cumsum(freq)) %>%
      dplyr::filter(accum_freq >= 0.5 & accum_freq <= 0.6) %>%
      dplyr::slice(1) %>%
      dplyr::mutate(d50_index = clonotype_number / clonotype_count * 100)
    df_d50 <- dplyr::bind_rows(df_d50, df_temp)
  }

  return(methods::new(
    "Diversity",
    summary_data = diversity,
    shannon = dplyr::select(
      diversity,
      sample,
      !!rlang::sym(attr_col),
      shannon_index,
      shannon_wiener_index,
      normalized_shannon_wiener_index
    ),
    simpson = dplyr::select(
      diversity,
      sample,
      !!rlang::sym(attr_col),
      simpson_index,
      inverse_simpson_index,
      gini_simpson_index
    ),
    d50 = df_d50 %>%
      dplyr::select(sample, !!rlang::sym(attr_col), d50_index) %>%
      dplyr::arrange(dplyr::desc(d50_index)),
    chao1 = diversity,
    gini_coeff = diversity
  ))
}
