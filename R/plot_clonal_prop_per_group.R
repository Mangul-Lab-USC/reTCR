#' Plot clonal proportion per group
#'
#' This function plots the clonal proportion per group.
#'
#' @param data A data frame of clonal proportion per group.
#' @param attr_col Character. Attribute column name.
#'
#' @return A ggplot2 plot of clonal proportion per group plot.
#' @export
#'
#' @examples
#' \dontrun{
#' proj <- reTCR::get_study(id = "PRJNA473147", attr_col = "cmv_status")
#' clonal_prop <- proj@clonality@clonal_prop
#' reTCR::plot_clonal_prop_per_group(clonal_prop, "cmv_status")
#' }
plot_clonal_prop_per_group <- function(data, attr_col) {
  data[[attr_col]] <- as.factor(data[[attr_col]])
  ggplot2::ggplot(
    data,
    ggplot2::aes_string(
      x = attr_col,
      y = "clonality_portion"
    )
  ) +
    ggplot2::geom_violin(trim = FALSE, fill = "skyblue", alpha = 0.5) +
    ggplot2::geom_boxplot(outlier.shape = NA, width = 0.1, alpha = 0.7) +
    ggplot2::geom_jitter(width = 0, height = 0.1, size = 1.5, alpha = 0.6) +
    ggplot2::theme_classic() +
    ggplot2::labs(x = attr_col, y = "number of clonotypes") +
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(
        angle = 90, vjust = 0.5, hjust = 1, size = 10
      ),
      axis.text.y = ggplot2::element_text(
        size = 12,
        margin = ggplot2::margin(l = 10)
      ),
      axis.title.x = ggplot2::element_text(
        size = 14,
        margin = ggplot2::margin(t = 10)
      ),
      axis.title.y = ggplot2::element_text(size = 14),
      legend.title = ggplot2::element_text(size = 14),
      legend.text = ggplot2::element_text(size = 12)
    )
}
