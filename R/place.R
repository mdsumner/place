
#' Place
#'
#' @param x place name (a city)
#' @param dimension number of pixels per margin (length one and aspect ratio is automatic)
#' @param family projection family 'laea' default
#' @param ... other arguments passed to [where]
#'
#' @return list of extent, dimension, projection
#' @export
#'
#' @examples
#' place("Hobart")
#' place("Bathurst", wh = c(10000, 15000))
#' if(requireNamespace("tidygeocoder")) place("Downtown Juneau, Juneau, AK, USA")
place <- function(x, dimension = 512L, family = "laea", ...) {
 UseMethod("place")
}
#' @name place
#' @export
place.character <- function(x, dimension = 512L, family = "laea", ...) {

  ## first, is it in our city/s
  idx <- match(tolower(x[1L]), tolower(city$name))
  if (is.na(idx) || length(idx) < 1 || idx < 1) {
    if (requireNamespace("tidygeocoder")) {
      data <- try(tidygeocoder::geo(x, quiet = TRUE, progress_bar = FALSE), silent = TRUE)
      if (inherits(data, "try-error") || is.na(data$lat[1L])) {
        #message()
        stop(sprintf("could not geocode %s", x))
      }
      w <- where(data$long[1], data$lat[1], ...)
    } else {
      message(sprintf("could not attempt to geocode %s, install 'tidygeocoder' and try again", x))
      stop(sprintf("cannot find %s", x))
    }
  } else {
    w <- where(city$lon[idx], city$lat[idx], ...)
  }
  ##dput(trimws( unlist(lapply(strsplit(system("proj -lp | grep conic --ignore-case", intern = T), ":"), "[", 1L))))
  conics <- c("bipc", "ccon", "eqdc", "imw_p", "lcc", "lcca", "leac", "pconic", "poly", "rpoly")

  if (family %in% conics) {
    lat_1_2 <- w$where[2] + c(-1, 1) * w$wh[2] * cos(w$where[2] * pi/180) / 111120
    crs <- sprintf("+proj=%s +lon_0=%.1f +lat_0=%.1f +lat_1=%.1f +lat_2=%.1f +datum=WGS84", family, w$where[1], w$where[2], lat_1_2[1], lat_1_2[2])
  } else {
    crs <- sprintf("+proj=%s +lon_0=%.1f +lat_0=%.1f +datum=WGS84", family, w$where[1], w$where[2])
  }

  if (family %in% c("merc", "eqc")) {
    warning("place heuristics for the projection don't work with Mercator or Equidistant Cylindrical (yet)")
  }
  ## here do aspect ratio, because we might have a where()$wh aspect ratio
  if (length(dimension) == 1L) {
    rat <- w$wh[2]/w$wh[1]
    dimension <- round(rep(dimension, 2) * sort(c(1, rat)))
  }
  list(extent = c(-1, 1, -1, 1) * rep(w$wh, each = 2), dimension = dimension, projection = crs)
}
