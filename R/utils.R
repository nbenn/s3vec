get_common_class <- function(x) {

  assert_that(has_common_class(x))

  unlist(unique(lapply(x, class)))
}

has_common_class <- function(x) {

  if (!is.list(x)) return(FALSE)

  if (length(x) > 1L) {
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