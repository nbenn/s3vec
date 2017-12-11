
#' @importFrom assertthat assert_that
NULL

#' Construct an s3vec object
#'
#' \code{new_s3vec} is a low-level constructor that takes a list of
#' s3 objects of the same class. \code{s3vec} constructs an s3vec from
#' individual s3 objects and \code{as.blob} is a S3 generic that converts
#' existing objects.
#'
#' @param ... Individual s3 objects
#' @param x A list of s3 objects, or other object to coerce
#' 
#' @return An s3vec object that wraps around the supplied s3 objects.
#' 
#' @examples
#' a <- structure("a", class = "foo")
#' b <- structure("b", class = "foo")
#'
#' new_s3vec(list(a, b))
#' s3vec(a, b)
#' 
#' as.blob(list(a, b))
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

  assert_that(is.list(x),
              Reduce(identical, lapply(x, class)))

  sub_class <- unlist(unique(lapply(x, class)))

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
