#' Plot relative abundance for all clonotypes
#'
#' This function plots the relative abundance for all clonotypes.
#'
#' @param data A data frame of relative abundance for all clonotypes.
#'
#' @return A ggplot2 plot of relative abundance for all clonotypes.
#' @export
#'
#' @examples
#' \dontrun{
#' proj <- reTCR::get_study(id="PRJNA473147", attr_col="cmv_status")
#' reTCR::plot_clonotype_abundance(proj@clonality@abundance)
#' }
plot_clonotype_abundance <- function(data) {
  label_order <- unique(data$clonotype_group)
  colors <- RColorBrewer::brewer.pal(n = length(label_order), name = "Set1")

  ggplot2::ggplot(
    data,
    ggplot2::aes(x = sample, y = relative_abundance, fill = clonotype_group)
  ) +
    ggplot2::geom_bar(
      stat = "identity",
      width = 0.5,
      color = NA
    ) +
    ggplot2::scale_fill_manual(
      values = colors,
      breaks = label_order
    ) +
    ggplot2::labs(x = "sample", y = "clonotype frequency") +
    ggplot2::theme_minimal() +
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(
        angle = 90,
        vjust = 0.5,
        hjust = 1,
        size = 10
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
      axis.ticks = ggplot2::element_line(color = "black", linewidth = 0.3),
      strip.background = ggplot2::element_blank(),
      strip.text = ggplot2::element_text(size = 12)
    ) +
    ggplot2::scale_x_discrete(
      labels = function(x) {
        stringr::str_wrap(x, width = 10)
      }
    ) +
    ggplot2::scale_y_continuous(expand = c(0, 0))
}
