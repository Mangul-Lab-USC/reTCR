.get_diversity <- function(data) {
  return(methods::new(
    "Diversity",
    shannon_index = 1.5,
    gini_index = 0.3
  ))
}