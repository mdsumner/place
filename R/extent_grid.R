#' Extent grid
#'
#' Helper function to create a grid dimension with a sensible aspect ratio.
#'
#' @param extent numeric vector, xmin,xmax,ymin,ymax
#' @param dim optional dimension, 1 number or 2
#' @param projection optional projection string to store
#' @param lonlat if set uses cosine latitude scaling for width for longitude
#'
#' @return list of extent, dimension, projection
#' @export
#'
#' @examples
#' extent_grid(c(0, 1, 0, 2))
extent_grid <- function(extent, dim = NULL, projection = NULL, lonlat = FALSE) {
  xl <- diff(extent[1:2])
  yl <- diff(extent[3:4])
  asp <- xl/yl * if (lonlat) cos(mean(yl) * pi/180) else 1
  if (is.null(dim) && !dev.cur() == 1) {
    dim <- dev.size("px")
  } else {
    if (is.null(dim)) dim <- c(512, 512)
  }

  # dim <- rep(dim, length.out = 2L)
  # wm <- which.max(dim)
  # dim[-wm] <- max(dim)*asp

  dim <- as.integer(dim * c(1, 1) * sort(c(1, asp)))

  list(extent = extent, dimension = as.integer(round(dim)), projection = projection)
}
