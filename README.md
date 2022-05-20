
<!-- README.md is generated from README.Rmd. Please edit that file -->

# place

<!-- badges: start -->

[![R-CMD-check](https://github.com/mdsumner/place/workflows/R-CMD-check/badge.svg)](https://github.com/mdsumner/place/actions)
[![CRAN
status](https://www.r-pkg.org/badges/version/place)](https://CRAN.R-project.org/package=place)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of place is to specify a region simply as point
(longitude,latitude) and a region around that.

This package does absolutely nothing with this information, but other
packages might (get where I’m going …?).

Data at [virtualearth](http://a0.ortho.tiles.virtualearth.net/tiles/).

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("mdsumner/place")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(place)



## get me outta here
where()
#> where : -35.79906, 49.49449 (lon, lat)
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

More useful, give me a defined discretized region around a location.

``` r
where(147, -42, wh = c(1, 1) * 5000)
#> where : 147, -42 (lon, lat)
#> width : 5000
#> height: 5000

place("1 George St, Bathurst NSW", wh = c(1, 1.6) * 15000, dimension = 1024)
#> Loading required namespace: tidygeocoder
#> $extent
#> [1] -15000  15000 -24000  24000
#> 
#> $dimension
#> [1] 1024 1638
#> 
#> $projection
#> [1] "+proj=laea +lon_0=149.6 +lat_0=-33.4 +datum=WGS84"
```

------------------------------------------------------------------------

## Code of Conduct

Please note that the place project is released with a [Contributor Code
of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
