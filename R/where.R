#' Where
#'
#' Specify a region by location point (longitude, latitude) and a width and height
#' around that point.
#'
#' Width and height will be assumed to be in metres usually, but no units are recorded.
#'
#' If no input point is given one is generated randomly. The default wh value is approximately the distance
#' along one degree of a great circle on Earth.
#' @param x longitude
#' @param y latitude
#' @param wh width and height (can be a single value) assumed to be metres
#' @param ... in the print method
#'
#' @return a where structure, the location and width/height around it
#' @export
#' @importFrom grDevices xy.coords
#' @importFrom stats runif
#' @examples
#' where()
#'
#' where(147, -42, wh = c(2000, 3000))
where <- function(x, y = NULL, wh = 1.852e3 * 60) {
  if (missing(x) && is.null(y)) {
    x <- runif(1L, -180, 180)
    y <- runif(1L, -90, 90)
  }
  if (is.null(y)) {
    if (length(x) < 2) stop("both x, and y (longitude,latitude) must be given")
  }

  if (length(x) == 2) {
    xy <- x
  } else {
    xy <- do.call(cbind, xy.coords(x, y)[c("x", "y")])[1L, , drop = FALSE]  ## we only get one
  }
  wh <- rep(wh, length.out = 2L)
  ## should we do this??  NO
  #if (length(wh) < 2) wh <- c(1/cos(xy[2L] * pi/180), 1) * wh
  if (abs(xy[1L])> 180) message("where x is outside the normal longitude range -180,180")
  if (abs(xy[2L])> 90) message("where y is outside the normal latitude range -90,90")
  if (anyNA(xy)) stop("missing values x,y")
  if (anyNA(wh[1])) stop("missing value wh")
  structure(list(where = xy, wh = wh), class = c("where", "list"))
}

## we want +, - and 1-way or two way to increase the width height
## possibly *, / to shift sideways, up-down?
Ops.where <- function(e1, e2) {
 stop("not implemented")
}
#' @name where
#' @export
print.where <- function(x, ...) {
  cat(sprintf("where : %s, %s (lon, lat)\n", format(x$where[1L]), format(x$where[2L])))
  cat(sprintf("width : %s\n", format(x$wh[1L])))
  cat(sprintf("height: %s\n", format(x$wh[2L])))
}
