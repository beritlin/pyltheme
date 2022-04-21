#' Complete list of palettes
#'
#' Use \code{\link{wes_palette}} to construct palettes of desired length.
#'
#' @export
pyl_palettes <- list(
  blankwhite = c("#000000", "#404040", "#7F7F7F", "#BFBFBF", "#FFFFFF"),
  funcore = c("#331F16", "#C5BBAC", "#ECE1D2", "#B3B3B3", "#333333"),
  funcore1 = c("#626F76", "#4E5255", "#331F16", "#C5BBAC" ,"#9B9483","#ECE1D2","#B3B3B3"),
  blue = c("#222A35", "#333F50", "#8497B0", "#ADB9CA" ,"#D6DCE5"),
  pink = c("#4C3A32", "#C2A097", "#D18679", "#F7C9C0", "#FFF6EB"),
  beach = c("#283949", "#7786A3", "#CDD8DF", "#F3F2EE", "#E4DAD4", "#BA9A88", "#563F31")
)

#' My colour palette generator
#'
#' These are some colours that I often use in analyses or presentation
#'
#' @param n Number of colours. Most palettes have about 5-7 colours within.
#' 
#' @param name Name of desired palette. 
#' 
#' @param type Either "continuous" or "discrete". Use continuous if you want
#'   to automatically interpolate between colours.
#'   @importFrom graphics rgb rect par image text
#' @return A vector of colours.
#' @export
#' @keywords colours
#' @examples
#' pyl_palette("funcore1")
#' pyl_palette("beach")
#' pyl_palette("blue")
#' pyl_palette("pink", 3)
#'
#' # If you need more colours than normally found in a palette, you
#' # can use a continuous palette to interpolate between existing
#' # colours
#' pal <- pyl_palette(21, name = "funcore1", type = "c")
#' image(volcano, col = pal)
#' 
pyl_palette <- function(name, n, type = c("discrete", "continuous")) {
  type <- match.arg(type)

  pal <- pyl_palettes[[name]]
  if (is.null(pal))
    stop("Palette not found.")

  if (missing(n)) {
    n <- length(pal)
  }

  if (type == "discrete" && n > length(pal)) {
    stop("Number of requested colours more than the palette can offer.")
  }

  out <- switch(type,
    continuous = grDevices::colorRampPalette(pal)(n),
    discrete = pal[1:n]
  )
  structure(out, class = "palette", name = name)
}

#' @export
#' @importFrom graphics rect par image text
#' @importFrom grDevices rgb
print.palette <- function(x, ...) {
  n <- length(x)
  old <- par(mar = c(0.5, 0.5, 0.5, 0.5))
  on.exit(par(old))

  image(1:n, 1, as.matrix(1:n), col = x,
    ylab = "", xaxt = "n", yaxt = "n", bty = "n")

  rect(0, 0.9, n + 1, 1.1, col = rgb(1, 1, 1, 0.8), border = NA)
  text((n + 1) / 2, 1, labels = attr(x, "name"), cex = 1.5, family = "mono",font=2)
}
pyl_palette("funcore1")
#' heatmap
#'
#' A heatmap example
"heatmap"

