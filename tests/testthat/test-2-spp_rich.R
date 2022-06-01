test_that("computes richness fail with NA", {
  expect_equal(spp_rich(c(3, 7, 10, 2, 0, 1, NA)), as.numeric(NA))
})

test_that("computes richness works with na.rm=T", {
  expect_equal(spp_rich(c(3, 7, 10, 2, 0, 1, NA), na.rm=T), 5)
})
