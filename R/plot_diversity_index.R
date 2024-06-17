#' Plot diversity index metrics
#'
#' This function plots the diversity index metrics.
#'
#' @param data A data frame of diversity index metrics.
#' @param index Character. Diversity index metric.
#' @param attr_col Character. Attribute column name.
#'
#' @return A ggplot2 plot of diversity index metrics.
#' @export
#'
#' @examples
#' \dontrun{
#' proj <- reTCR::get_study(id = "PRJNA473147", attr_col = "cmv_status")
#' reTCR::plot_diversity_index(
#'   proj@diversity@shannon,
#'   "shannon_wiener_index",
#'   "cmv_status"
#' )
#' }
plot_diversity_index <- function(data, index, attr_col) {
  label_order <- unique(data[[attr_col]])
  colors <- RColorBrewer::brewer.pal(n = 3, name = "Set1")[c(2, 1)]

  df_summary <- data %>%
    dplyr::group_by(.data[[attr_col]]) %>%
    dplyr::summarize(
      mean_index = mean(.data[[index]], na.rm = TRUE),
      sem_index = stats::sd(.data[[index]], na.rm = TRUE) / sqrt(dplyr::n())
    )

  ggplot2::ggplot(
    df_summary,
    ggplot2::aes(
      x = .data[[attr_col]],
      y = .data$mean_index,
      fill = .data[[attr_col]]
    )
  ) +
    ggplot2::geom_bar(position = "dodge", stat = "identity") +
    ggplot2::geom_errorbar(
      ggplot2::aes(
        ymin = .data$mean_index - .data$sem_index,
        ymax = .data$mean_index + .data$sem_index
      ),
      position = ggplot2::position_dodge(0.9),
      width = 0.2
    ) +
    ggplot2::scale_fill_manual(
      values = colors,
      breaks = label_order,
      name = attr_col
    ) +
    ggplot2::labs(x = attr_col, y = index) +
    ggplot2::theme_minimal() +
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(
        angle = 90, vjust = 0.5, hjust = 1, size = 10
      ),
      axis.text.y = ggplot2::element_text(size = 10),
      axis.title = ggplot2::element_text(size = 14),
      legend.title = ggplot2::element_blank(),
      legend.text = ggplot2::element_text(size = 12),
      legend.position = "right",
      panel.grid.major = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank(),
      axis.line = ggplot2::element_line(color = "black"),
      axis.text = ggplot2::element_text(margin = ggplot2::margin(t = 10)),
      axis.ticks = ggplot2::element_line(color = "black", size = 0.3),
      strip.background = ggplot2::element_blank(),
      strip.text = ggplot2::element_text(size = 12)
    ) +
    ggplot2::scale_x_discrete(
      labels = function(x) stringr::str_wrap(x, width = 10)
    )
}
