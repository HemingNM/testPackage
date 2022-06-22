test_that("richness computation works w/wo NAs", {
  expect_equal(spp_rich(c(3, 7, 10, 2, 0, 1, NA), na.rm=FALSE), as.numeric(NA))
  expect_equal(spp_rich(c(3, 7, 10, 2, 0, 1, NA), na.rm=TRUE), 5)
})

test_that("error is returned with wrong input class", {
  l <- list(c(3, 7, 10, 2, 0, 1, NA))
  expect_error(spp_rich(l))
})

test_that("returned object classes are correct", {
  sites <- testPackage::sites
  sitesr <- terra::rast(system.file("extdata", "sitesr.tif", package="testPackage"))

  expect_vector(spp_rich(c(3, 7, 10, 2, 0, 1, NA), na.rm=T))
  expect_vector(spp_rich(sites, na.rm=T))
  expect_s4_class(spp_rich(sitesr, na.rm=T), "SpatRaster")

  expect_type(spp_rich(c(3, 7, 10, 2, 0, 1, NA), na.rm=T), "integer")
  expect_type(spp_rich(sites, na.rm=T), "integer")
  expect_type(spp_rich(sitesr, na.rm=T), "S4")
})
