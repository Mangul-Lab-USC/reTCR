.get_diversity <- function(data, attr_col) {
  df_div <- data %>%
    dplyr::group_by(sample, !!rlang::sym(attr_col)) %>%
    dplyr::summarise(
      clonotype_count = dplyr::n()
    ) %>%
    dplyr::left_join(data, by = c("sample", attr_col))

  diversity <- df_div %>%
    dplyr::group_by(sample, !!rlang::sym(attr_col)) %>%
    dplyr::summarise(
      shannon_index = sum(-freq * log(freq)),
      shannon_wiener_index = exp(sum(-freq * log(freq))),
      normalized_shannon_wiener_index = sum(-freq * log(freq)) / log(dplyr::n()),
      simpson_index = sum(freq^2),
      inverse_simpson_index = 1 / sum(freq^2),
      gini_simpson_index = 1 - sum(freq^2),
    )

  gini <- function(list_of_values) {
    sorted_list <- sort(list_of_values)
    height <- 0
    area <- 0
    for (value in sorted_list) {
      height <- height + value
      area <- area + height - value / 2
    }
    fair_area <- height * length(list_of_values) / 2
    return((fair_area - area) / fair_area)
  }

  samples <- unique(df_div$sample)
  df_d50 <- data.frame()
  df_gini <- data.frame()
  df_chao1 <- data.frame()

  for (sample in samples) {
    filt_df <- df_div %>% dplyr::filter(sample == !!sample)

    gini_temp <- filt_df %>% dplyr::mutate(gini_coeff = gini(filt_df$freq))
    df_gini <- dplyr::bind_rows(df_gini, gini_temp)

    d50_temp <- filt_df %>%
      dplyr::arrange(dplyr::desc(freq)) %>%
      dplyr::mutate(clonotype_number = dplyr::row_number()) %>%
      dplyr::mutate(accum_freq = cumsum(freq)) %>%
      dplyr::filter(accum_freq >= 0.5 & accum_freq <= 0.6) %>%
      dplyr::slice(1) %>%
      dplyr::mutate(d50_index = clonotype_number / clonotype_count * 100)
    df_d50 <- dplyr::bind_rows(df_d50, d50_temp)

    singleton <- sum(filt_df$count == 1)
    doubleton <- sum(filt_df$count == 2)
    chao1 <- filt_df$clonotype_count[1] + ((singleton * (singleton - 1)) / (2 * (doubleton + 1)))
    if (doubleton != 0) {
      step1 <- 1 / 4 * ((singleton / doubleton)^4)
      step2 <- (singleton / doubleton)^3
      step3 <- 1 / 2 * ((singleton / doubleton)^2)
      step4 <- doubleton * (step1 + step2 + step3)
      chao1_sd <- sqrt(step4)
    } else {
      chao1_sd <- 0
    }

    chao1_sd <- as.numeric(chao1_sd)
    chao1_temp <- filt_df %>% dplyr::mutate(chao1 = chao1, chao1_sd = chao1_sd)
    df_chao1 <- dplyr::bind_rows(df_chao1, chao1_temp)
  }

  return(methods::new(
    "Diversity",
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
    chao1 = df_chao1 %>%
      dplyr::select(sample, !!rlang::sym(attr_col), chao1, chao1_sd) %>%
      dplyr::distinct(sample, .keep_all = TRUE),
    gini_coeff = df_gini %>%
      dplyr::select(sample, !!rlang::sym(attr_col), gini_coeff) %>%
      dplyr::distinct(sample, .keep_all = TRUE)
  ))
}
