context("test-accessors.R")

test_that("s3vec elements can be subsetted", {
  a <- structure("a", class = "foo")
  b <- structure("b", class = "foo")
  c <- structure("c", class = "foo")
  abc <- s3vec(a, b, c)

  expect_s3_class(abc[2], c("foo", "s3vec"))
  expect_s3_class(abc[2:3], c("foo", "s3vec"))
  expect_false("s3vec" %in% class(abc[[2]]))
})

test_that("s3vec elements can be replaced", {
  a <- structure("a", class = "foo")
  b <- structure("b", class = "foo")
  c <- structure("c", class = "foo")
  ab <- s3vec(a, b)

  ab[2] <- c
  expect_s3_class(ab, c("foo", "s3vec"))
  expect_equal(ab[[2]], c)

  ab[1:2] <- list(b, c)
  expect_s3_class(ab, c("foo", "s3vec"))
  expect_equal(ab[[1]], b)

  ab[[2]] <- c
  expect_s3_class(ab, c("foo", "s3vec"))
  expect_equal(ab[[2]], c)
})
