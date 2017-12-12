context("test-utils.R")

test_that("common class can be determined", {
  expect_true(has_common_class(
    list(structure("a", class = "foo"), structure("b", class = "foo"))))
  expect_false(has_common_class(
    list(structure("a", class = "bar"), structure("b", class = "foo"))))
  expect_false(has_common_class(
    list(structure("a"), structure("b", class = "foo"))))
  expect_true(has_common_class(list(structure("a"), structure("b"))))
  expect_true(has_common_class(list(structure("a", class = "foo"))))
  expect_true(has_common_class(list(structure("a"))))

  expect_true(has_common_class("a"))
  expect_true(has_common_class(c("a", 1L)))
  expect_false(has_common_class(list("a", 1L)))
  expect_true(has_common_class(NULL))
  expect_false(has_common_class(list("a", NULL)))

  expect_equal(get_common_class(list(structure("a", class = "foo"),
                                     structure("b", class = "foo"))),
               "foo")
  expect_error(get_common_class(list(structure("a", class = "foo"),
                                     structure("b", class = "bar"))))
  expect_equal(get_common_class(list(structure("a"),
                                     structure("b"))),
               "character")
  expect_equal(get_common_class(list(structure("a", class = "foo"))),
               "foo")
  expect_equal(get_common_class(structure("a", class = "foo")), "foo")

  expect_equal(get_common_class("a"), "character")
  expect_equal(get_common_class(c("a", 1L)), "character")
  expect_error(get_common_class(list("a", 1L)))
  expect_equal(get_common_class(NULL), "NULL")
  expect_error(get_common_class(list("a", NULL)))
})

test_that("get subclasses of s3vec", {
  expect_equal(get_s3vec_subclass(
    structure(list(structure("a", class = "foo"),
                   structure("b", class = "foo")), class = c("foo", "s3vec"))),
    "foo")
  expect_equal(get_s3vec_subclass(
    structure(list(structure("a", class = "foo"),
                   structure("b", class = "bar")), class = c("foo", "s3vec"))),
    "foo")
  expect_equal(get_s3vec_subclass(
    structure(list("a"), class = c("foo", "s3vec"))), "foo")
  expect_error(get_s3vec_subclass(structure(list("a"), class = "s3vec")))
  expect_error(get_s3vec_subclass(structure(list("a"),
                                            class = c("s3vec", "foo"))))
  expect_error(get_s3vec_subclass(structure(list("a"))))
})