spp_rich <- function(x, ...){
  r <- sum(x>0, ...)
  return(r)
}
