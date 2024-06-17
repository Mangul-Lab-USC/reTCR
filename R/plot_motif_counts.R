#' Plot Motif Counts
#'
#' This function plots the motif counts.
#'
#' @param data A data frame containing the motif counts.
#' @param threshold the minimum count threshold (default: 60).
#'
#' @return A ggplot2 object representing the motif counts plot.
#' @export
#'
#' @examples
#' \dontrun{
#' proj <- reTCR::get_study(id="PRJNA473147", attr_col="cmv_status")
#' reTCR::plot_motif_counts(proj@motif@aa_motif_count, 20)
#' }
plot_motif_counts <- function(data, threshold = 60) {
  data <- dplyr::filter(data, count > threshold)
  df <- stats::aggregate(count ~ cmv_status + motif, data = data, FUN = length)
  colnames(df)[3] <- "number_of_samples"
  df <- dplyr::filter(df, number_of_samples > 2)
  data <- dplyr::inner_join(data, df, by = c("cmv_status", "motif"))

  ggplot2::ggplot(
    data,
    ggplot2::aes(
      x = motif,
      y = count,
      color = cmv_status
    )
  ) +
    ggplot2::geom_jitter(width = 0.2, size = 3) +
    ggplot2::labs(
      x = "Amino acid motif",
      y = "Count",
      color = "CMV Status"
    ) +
    ggplot2::theme_bw() +
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(
        angle = 90,
        hjust = 1,
        vjust = 0.5
      ),
      axis.title = ggplot2::element_text(size = 16),
      axis.text = ggplot2::element_text(size = 12),
      legend.title = ggplot2::element_text(size = 14),
      legend.text = ggplot2::element_text(size = 12)
    )
}
