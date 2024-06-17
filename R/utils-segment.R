#' Plot top n clonotypes
#'
#' This function plots the top n clonotypes.
#'
#' @param data A data frame of the main data.
#' @param n Integer. Number of top clonotypes to select.
#' @param attr_col Character. Attribute column name.
#'
#' @return A data frame of top n clonotypes.
#' @export
#'
#' @examples
#' \dontrun{
#' proj <- reTCR::get_study("PRJNA473147", "cmv_status")
#' reTCR::get_top_n_clonotypes(proj@data, 10, "cmv_status")
#' }
get_top_n_clonotypes <- function(data, n, attr_col) {
  stopifnot(n > 0)
  top <- data %>%
    dplyr::arrange(sample, freq) %>%
    dplyr::group_by(sample) %>%
    dplyr::slice_tail(n = n) %>%
    dplyr::select(freq, cdr3aa, sample, !!rlang::sym(attr_col))
  return(top)
}


#' Plot bottom n clonotypes
#'
#' This function plots the top n clonotypes.
#'
#' @param data A data frame of the main data.
#' @param n Integer. Number of top clonotypes to select.
#' @param attr_col Character. Attribute column name.
#'
#' @return A data frame of bottom n clonotypes.
#' @export
#'
#' @examples
#' \dontrun{
#' proj <- reTCR::get_study("PRJNA473147", "cmv_status")
#' reTCR::get_bottom_n_clonotypes(proj@data, 10, "cmv_status")
#' }
get_bottom_n_clonotypes <- function(data, n, attr_col) {
  stopifnot(n > 0)
  bottom <- data %>%
    dplyr::arrange(sample, freq) %>%
    dplyr::group_by(sample) %>%
    dplyr::slice_head(n = n) %>%
    dplyr::select(freq, cdr3aa, sample, !!rlang::sym(attr_col))
  return(bottom)
}
