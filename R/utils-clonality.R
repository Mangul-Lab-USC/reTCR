.get_clonality <- function(data, attr_col) {
  return(methods::new(
    "Clonality",
    most_clonotype = data.frame(),
    least_clonotype = data.frame(),
    pielou = data.frame(),
    clonal_prop = data.frame(),
    abundance = data.frame(),
    abundance_top = data.frame(),
    abundance_rare = data.frame()
  ))
}
