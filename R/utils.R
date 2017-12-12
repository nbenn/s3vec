
#' Test for an s3vec object
#'
#' In order for an object to be considered a proper s3vec object, it has to
#' 
#' \itemize{
#'   \item all child elements have to be of the same class
#'   \item the "s3vec" class attribute has to be in last position
#'   \item the remaining class attributes have to be the ones of the child
#'         elements
#' }
#' 
#' @param x An object to test.
#' 
#' @examples
#' a <- structure("a", class = "foo")
#' b <- structure("b", class = "foo")
#'
#' is_s3vec(s3vec(a, b))  # TRUE
#' is.s3vec(s3vec(a, b))  # TRUE
#' 
#' is_s3vec(a)            # FALSE
#' 
#' @export
#' 
is_s3vec <- function(x) {

  if (!inherits(x, "s3vec") || !has_common_class(x))
    return(FALSE)

  all_classes <- class(x)

  if (all_classes[length(all_classes)] != "s3vec")
    return(FALSE)

  if (length(all_classes) <= 1L)
    return(FALSE)

  isTRUE(get_s3vec_subclass(x) == get_common_class(x))
}

#' @rdname s3vec
#' 
#' @export
#' 
is.s3vec <- is_s3vec

get_common_class <- function(x) {

  assert_that(has_common_class(x))

  if (is.list(x)) {
    all_classes <- lapply(x, class)
    common_class <- unique(all_classes)
    assert_that(length(common_class) == 1L)
    unlist(common_class)
  } else
    class(x)
}

has_common_class <- function(x) {

  if (is.list(x) && length(x) > 1L) {
    all_classes <- lapply(x, class)
    return(all(sapply(all_classes[-1], identical, all_classes[[1]])))
  }

  TRUE
}

get_s3vec_subclass <- function(x) {

  all_classes <- class(x)
  assert_that(all_classes[length(all_classes)] == "s3vec",
              length(all_classes) > 1L)

  all_classes[-length(all_classes)]
}