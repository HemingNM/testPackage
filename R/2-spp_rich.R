#' Calcula riqueza
#'
#' Essa função calcula a riqueza em um vetor de abundância/presença de
#' espécies de uma comunidade.
#'
#' @param x A numeric vector of species abundances/presences in the community
#' @inheritParams base::sum
#'
#' @return numeric
# #' @export
#'
#' @examples
#' mata <- c(3, 7, 10, 2, 0, 1)
#' spp_rich(mata)
#'
.spp_rich <- function(x, na.rm = FALSE){
  r <- sum(x>0, na.rm = na.rm)
  return(r)
}



#' Computes species richness
#'
#' @inheritParams .spp_rich
#'
#' @return An object of the same class of x (i.e. numeric vector, matrix or SpatRaster)
#' @export
#'
#' @examples
#' spp_rich(c(3, 7, 10, 2, 0, 1, NA))
#'
spp_rich <- function(x, na.rm = FALSE){
  if(inherits(x, c("integer", "numeric"))){
    ## vetor
    r <- .spp_rich(x, na.rm=na.rm)
  } else if(inherits(x, "matrix")){
    ## matriz
    r <- apply(x, 1, .spp_rich, na.rm=na.rm)
  } else if(inherits(x, "SpatRaster")){
    ## raster
    r <- terra::app(x, .spp_rich, na.rm=na.rm)
  } else {
    stop("Argument 'x' must be an object of class 'numeric', 'matrix' or 'SpatRaster'")
  }
  return(r)
}
