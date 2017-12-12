
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- build with rmarkdown::render("README.Rmd") -->
s3vec
=====

The goal of s3vec is to provide a wrapper around collections of s3 objects (of the same class) to make them behave like vectors of objects.

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://img.shields.io/badge/lifecycle-experimental-orange.svg) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/nbenn/s3vec?branch=master&svg=true)](https://ci.appveyor.com/project/nbenn/s3vec) [![Travis build status](https://travis-ci.org/nbenn/s3vec.svg?branch=master)](https://travis-ci.org/nbenn/s3vec) [![Coverage status](https://codecov.io/gh/nbenn/s3vec/branch/master/graph/badge.svg)](https://codecov.io/github/nbenn/s3vec?branch=master)

Installation
------------

You can install s3vec from github with:

``` r
# install.packages("devtools")
devtools::install_github("nbenn/s3vec")
```

Hello World
-----------

Assume we have an s3 class `point`, representing a point in 2 dimensions. Now we create 100 instances of `point` and store them in the list `points`.

``` r
point <- function(x, y) {
  stopifnot(is.numeric(x), is.numeric(y))
  structure(list(x = x, y = y), class = "point")
}

points <- mapply(point, runif(100), runif(100), SIMPLIFY = FALSE)
```

We would like to implement a `max` function that returns the point with the greatest distance from the origin. We cannot use s3 dispatch on `point`, because our collection of points is a list. For a function like `abs`, this is less of an issue, as it can be applied to individual objects by iterating through the list.

``` r
abs.point <- function(x) {
  sqrt(x$x ^ 2 + x$y ^ 2)
}

abs(points[[1]])
#> [1] 0.4365035
sapply(points[1:5], abs)
#> [1] 0.4365035 0.5849015 0.3050203 0.4567308 0.8658854

max.point <- function(x, ...) {
  max(sapply(x, abs))
}

max(points)
#> Error in max(points): invalid 'type' (list) of argument
```

In order to get around this issue, `s3vec` wraps an additional class (`s3vec`) around such a list, holding several objects of the same type and bring this type to the surface of this wrapped object. Like this, s3 dispatch can be used for the point class.

``` r
points <- as.s3vec(points)

class(points)
#> [1] "point" "s3vec"

max(points)
#> [1] 1.366007
```
