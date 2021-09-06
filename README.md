
<!-- README.md is generated from README.Rmd. Please edit that file -->

# where

<!-- badges: start -->

[![R-CMD-check](https://github.com/mdsumner/where/workflows/R-CMD-check/badge.svg)](https://github.com/mdsumner/where/actions)
[![CRAN
status](https://www.r-pkg.org/badges/version/where)](https://CRAN.R-project.org/package=where)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of where is to specify a region simply as point
(longitude,latitude) and a region around that.

This package does absolutely nothing with this information, but other
packages might (get where I’m going …?).

Data at [virtualearth](http://a0.ortho.tiles.virtualearth.net/tiles/).

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("mdsumner/where")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(where)

## get me outta here
where()
#> where : 1.100433, 72.30982 (lon, lat)
#> width : 111120
#> height: 111120
```

Ok, get me somewhere specific.

``` r
where(156, 34, wh = 100000)  ## 100km either side of that location
#> where : 156, 34 (lon, lat)
#> width : 1e+05
#> height: 1e+05
```

------------------------------------------------------------------------

## Code of Conduct

Please note that the where project is released with a [Contributor Code
of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
