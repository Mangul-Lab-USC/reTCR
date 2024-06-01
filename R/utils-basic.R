.get_basic <- function(data) {
  data <- data %>%
    dplyr::mutate(nt_length = nchar(cdr3nt))

  df_spectratype <- data %>%
    dplyr::group_by(
      dplyr::across(dplyr::all_of(c("sample", "nt_length", "cmv_status")))
    ) %>%
    dplyr::summarise(spectratype = sum(freq), .groups = "drop")

  df_unique_cdr3 <- data %>%
    dplyr::group_by(
      dplyr::across(dplyr::all_of(c("cdr3aa", "sample", "cmv_status")))
    ) %>%
    dplyr::summarise(count = dplyr::n(), .groups = "drop")

  df_unique_cdr3_mean <- df_unique_cdr3 %>%
    dplyr::group_by(dplyr::across(dplyr::all_of(c("sample", "cmv_status")))) %>%
    dplyr::summarise(convergence = mean(count), .groups = "drop")

  basic <- data %>%
    dplyr::group_by(sample, cmv_status) %>%
    dplyr::summarise(
      reads_count = sum(count, na.rm = TRUE),
      clonotype_count = dplyr::n(),
      mean_freq = mean(freq, na.rm = TRUE),
      geomean_freq = exp(mean(log(freq), na.rm = TRUE)),
      mean_cdr3nt_len = sum(nchar(cdr3nt) * freq,
        na.rm = TRUE
      ) / sum(freq, na.rm = TRUE),
      .groups = "drop"
    ) %>%
    dplyr::select(
      sample,
      cmv_status,
      reads_count,
      clonotype_count,
      mean_freq,
      geomean_freq,
      mean_cdr3nt_len
    )

  basic <- basic %>%
    dplyr::left_join(
      df_unique_cdr3_mean,
      by = c("sample", "cmv_status")
    )

  return(
    methods::new(
      "Basic",
      summary_data = basic,
      reads_count = dplyr::select(
        basic,
        sample,
        cmv_status,
        reads_count
      ),
      clonotype_count = dplyr::select(
        basic,
        sample,
        cmv_status,
        clonotype_count
      ),
      mean_freq = dplyr::select(
        basic,
        sample,
        cmv_status,
        mean_freq
      ),
      geomean_freq = dplyr::select(
        basic,
        sample,
        cmv_status,
        geomean_freq
      ),
      mean_cdr3nt_len = dplyr::select(
        basic,
        sample,
        cmv_status,
        mean_cdr3nt_len
      ),
      convergence = dplyr::select(
        basic,
        sample,
        cmv_status,
        convergence
      ),
      spectratype = df_spectratype
    )
  )
}