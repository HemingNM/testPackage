#' Add 1
#'
#' @param x A numeric vector
#'
#' @return numeric vector
#' @export
#'
#' @examples
#' add1(10)
add1 <- function(x) {
  data.table::as.data.table(x+1)
  }
