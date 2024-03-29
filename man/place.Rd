% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/place.R
\name{place}
\alias{place}
\alias{place.character}
\title{Place}
\usage{
place(x, dimension = 512L, family = "laea", ...)

\method{place}{character}(x, dimension = 512L, family = "laea", ...)
}
\arguments{
\item{x}{place name (a city)}

\item{dimension}{number of pixels per margin (length one and aspect ratio is automatic)}

\item{family}{projection family 'laea' default, or an actual projection string}

\item{...}{other arguments passed to \link{where}}
}
\value{
list of extent, dimension, projection
}
\description{
Family
}
\details{
Note that if you give a longlat family, you should give a wh to where in degrees (we might fix)
}
\examples{
place("Hobart")
place("Bathurst", wh = c(10000, 15000))
if(requireNamespace("tidygeocoder")) place("Downtown Juneau, Juneau, AK, USA")
}
