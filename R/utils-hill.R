.get_hill_numbers <- function(df) {
  q1 <- df %>%
    dplyr::mutate(q1 = -(freq * log(freq))) %>%
    dplyr::group_by(sample) %>%
    dplyr::summarise(shannon_index_tool = sum(q1)) %>%
    dplyr::mutate(
      Result = exp(shannon_index_tool),
      Q = "1"
    ) %>%
    dplyr::select(sample, Q, Result)

  q2 <- df %>%
    dplyr::mutate(q2 = freq^2) %>%
    dplyr::group_by(sample) %>%
    dplyr::summarise(simpson_index_tool = sum(q2)) %>%
    dplyr::mutate(
      Result = 1 / simpson_index_tool,
      Q = "2"
    ) %>%
    dplyr::select(sample, Q, Result)

  calculate_q <- function(df, q) {
    df %>%
      dplyr::mutate(new_col = freq^q) %>%
      dplyr::group_by(sample) %>%
      dplyr::summarise(new_col_sum = sum(new_col)) %>%
      dplyr::mutate(
        Result = (new_col_sum)^(-1 / (q - 1)),
        Q = as.character(q)
      ) %>%
      dplyr::select(sample, Q, Result)
  }

  # Calculate q3 to q6
  q3 <- calculate_q(df, 3)
  q4 <- calculate_q(df, 4)
  q5 <- calculate_q(df, 5)
  q6 <- calculate_q(df, 6)

  result <- dplyr::bind_rows(q1, q2, q3, q4, q5, q6)
  return(result)
}
