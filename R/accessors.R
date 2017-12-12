#' @export
`[.s3vec` <- function(x, i, ...) {
  new_s3vec(NextMethod())
}

#' @export
`[<-.s3vec` <- function(x, i, ..., value) {

  sub_class <- get_s3vec_subclass(x)
  assert_that(get_common_class(value) == sub_class)

  res <- NextMethod()
  new_s3vec(lapply(res, `class<-`, sub_class))
}