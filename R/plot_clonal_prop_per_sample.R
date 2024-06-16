#' Plot clonal proportion per sample
#'
#' This function plots the clonal proportion per sample.
#'
#' @param data A data frame of clonal proportion per sample.
#' @param attr_col Character. Attribute column name.
#'
#' @return A ggplot2 plot of clonal proportion per sample plot.
#' @export
#'
#' @examples
#' \dontrun{
#' proj <- reTCR::get_study(id="PRJNA473147", attr_col="cmv_status")
#' clonal_prop <- proj@clonality@clonal_prop
#' reTCR::plot_clonal_prop_per_sample(clonal_prop, "cmv_status")
#' }
plot_clonal_prop_per_sample <- function(data, attr_col) {
  ggplot2::ggplot(
    data,
    ggplot2::aes(
      x = sample,
      y = clonality_portion,
      fill = !!rlang::sym(attr_col)
    )
  ) +
    ggplot2::geom_bar(stat = "identity", position = ggplot2::position_dodge()) +
    ggplot2::labs(x = "sample", y = "number of clonotypes") +
    ggplot2::theme_classic() +
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
    ) +
    ggplot2::scale_y_continuous(expand = c(0, 0)) +
    ggplot2::scale_fill_brewer(palette = "Set1", name = attr_col)
}
