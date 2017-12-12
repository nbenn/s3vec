
#' @importFrom assertthat assert_that
NULL

#' Construct an s3vec object
#'
#' `new_s3vec` is a low-level constructor that takes a list of
#' s3 objects of the same class. `s3vec` constructs an s3vec from
#' individual s3 objects and `as.s3vec` is a S3 generic that converts
#' existing objects. `is_s3vec` or `is.s3vec` test whether the object
#' is an s3vec object.
#'
#' @param ... Individual s3 objects
#' @param x A list of s3 objects, or other object to coerce
#' 
#' @examples
#' a <- structure("a", class = "foo")
#' b <- structure("b", class = "foo")
#'
#' new_s3vec(list(a, b))
#' s3vec(a, b)
#' 
#' as.s3vec(list(a, b))
#' 
#' @export
#' 
s3vec <- function(...) {
  new_s3vec(list(...))
}

#' @rdname s3vec
#' 
#' @export
#' 
new_s3vec <- function(x) {

  assert_that(has_common_class(x))

  sub_class <- get_common_class(x)

  structure(x, class = c(sub_class, "s3vec"))
}

#' @rdname s3vec
#' 
#' @export
#' 
as.s3vec <- function(x, ...) {
  UseMethod("as.s3vec")
}

#' @export
as.s3vec.s3vec <- function(x, ...) {
  x
}

#' @export
as.s3vec.list <- function(x, ...) {
  new_s3vec(x)
}

#' @export
as.list.s3vec <- function(x, ...) {
  unclass(x)
}
