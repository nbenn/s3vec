context("test-s3vec.R")

test_that("object creation works", {
  a <- structure("a", class = "foo")
  b <- structure("b", class = "foo")
  expect_s3_class(s3vec(a, b), c("foo", "s3vec"))
  expect_identical(s3vec(a, b),
                   new_s3vec(list(a, b)))
  c <- structure("c", class = "bar")
  expect_error(s3vec(a, b, c))

  s3vec(a)

  a <- structure("a", class = c("foo", "bar"))
  b <- structure("b", class = c("foo", "bar"))
  expect_s3_class(s3vec(a, b), c("foo", "bar", "s3vec"))
  expect_identical(s3vec(a, b),
                   new_s3vec(list(a, b)))
  c <- structure("c", class = "foobar")
  expect_error(s3vec(a, b, c))

  expect_identical(s3vec(a, b), as.s3vec(s3vec(a, b)))
  expect_identical(s3vec(a, b), as.s3vec(list(a, b)))
})
