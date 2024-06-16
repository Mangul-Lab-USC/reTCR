#' Plot reads group abundance for top 100 clonotypes
#'
#' This function plots reads group abundance for top 100 clonotypes.
#'
#' @param data A data frame of relative abundance for top 100 clonotypes.
#' @param attr_col Character. Attribute column name.
#'
#' @return A ggplot2 plot of reads group abundance for top 100 clonotypes.
#' @export
#'
#' @examples
#' \dontrun{
#' proj <- reTCR::get_study(id = "PRJNA473147", attr_col = "cmv_status")
#' reTCR::plot_reads_group_abundance(proj@clonality@abundance_top)
#' }
plot_reads_group_abundance <- function(data) {
  label_order <- unique(data$reads_group)
  colors <- c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00")

  df_counts <- data %>%
    dplyr::filter(reads_group != "None") %>%
    dplyr::group_by(sample, reads_group) %>%
    dplyr::summarize(count = dplyr::n()) %>%
    dplyr::ungroup()

  ggplot2::ggplot(
    df_counts,
    ggplot2::aes(
      x = sample,
      y = count,
      fill = reads_group
    )
  ) +
    ggplot2::geom_bar(position = "stack", stat = "identity", width = 0.7) +
    ggplot2::scale_fill_manual(
      values = colors,
      breaks = label_order,
      name = "reads_group"
    ) +
    ggplot2::labs(x = "sample", y = "number of clonotypes") +
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
    ) +
    ggplot2::scale_y_continuous(expand = c(0, 0))
}
