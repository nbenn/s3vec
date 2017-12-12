context("test-s3vec.R")

test_that("object creation works", {
  a <- structure("a", class = "foo")
  b <- structure("b", class = "foo")
  c <- structure("c", class = "foo")
  expect_s3_class(s3vec(a), c("foo", "s3vec"))

  expect_s3_class(s3vec(a, b), c("foo", "s3vec"))
  expect_identical(s3vec(a, b),
                   new_s3vec(list(a, b)))
  expect_s3_class(s3vec(a, b, c), c("foo", "s3vec"))

  c <- structure("c", class = "bar")
  expect_error(s3vec(a, b, c))

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

test_that("testing for s3vec objects", {
  a <- structure("a", class = "foo")

  expect_true(is_s3vec(s3vec(a)))
  expect_true(is.s3vec(s3vec(a)))

  expect_true(is_s3vec(structure(list(structure("a", class = "foo")),
                                 class = c("foo", "s3vec"))))
  expect_false(is_s3vec(structure(list("a"), class = c("foo", "s3vec"))))
  expect_false(is_s3vec(structure("a", class = c("foo", "s3vec"))))
  expect_false(is_s3vec(structure(list("a"), class = c("s3vec", "foo"))))
  expect_false(is_s3vec(structure(list("a"), class = "foo")))
  expect_false(is_s3vec(structure(list("a"), class = "s3vec")))

  expect_true(is_s3vec(
    structure(list(structure("a", class = "foo"),
                   structure("b", class = "foo")), class = c("foo", "s3vec"))))
  expect_false(is_s3vec(
    structure(list(structure("a", class = "foo"),
                   structure("b", class = "bar")), class = c("foo", "s3vec"))))
  expect_false(is_s3vec(
    structure(list(structure("a", class = "foo"),
                   structure("b", class = "foo")), class = c("bar", "s3vec"))))
  expect_false(is_s3vec(
    structure(list(structure("a", class = "foo"),
                   structure("b", class = "bar")), class = c("bar", "s3vec"))))

})