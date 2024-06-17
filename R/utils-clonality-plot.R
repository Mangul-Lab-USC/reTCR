#' Plot clonal proportion per sample
#'
#' This function plots the clonal proportion per sample.
#'
#' @param data A data frame of clonal proportion per sample.
#' @param attr_col Character. Attribute column name.
#'
#' @return A ggplot2 plot of clonal proportion per sample.
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

#' Plot clonal proportion per group
#'
#' This function plots the clonal proportion per group.
#'
#' @param data A data frame of clonal proportion per group.
#' @param attr_col Character. Attribute column name.
#'
#' @return A ggplot2 plot of clonal proportion per group.
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

#' Plot reads group abundance for top 100 clonotypes
#'
#' This function plots reads group abundance for top 100 clonotypes.
#'
#' @param data A data frame of relative abundance for top 100 clonotypes.
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
  colors <- RColorBrewer::brewer.pal(n = length(label_order), name = "Set1")

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
