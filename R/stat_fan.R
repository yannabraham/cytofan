#' @inheritParams ggplot2::stat_identity
#'
#' @param step the number of quantiles to use to compute bins
#'
#' @section Computed variables:
#' \describe{
#'     \item{ymin}{the lower limit of the quantile}
#'     \item{ymax}{the upper limit of the quantile}
#'     \item{id}{an identifier for the quantile}
#'     \item{percent}{the fill colorto use in \code{geom_fan}}
#' }
#'
#' @rdname geom_fan
#' @export
stat_fan <- function(mapping = NULL, data = NULL, geom = NULL,
                     position = "identity", na.rm = FALSE, show.legend = NA,
                     inherit.aes = TRUE, step=0.01, ...) {
  list(
    layer(
      stat = StatFan, data = data, mapping = mapping, geom = geom,
      position = position, show.legend = show.legend, inherit.aes = inherit.aes,
      params = list(na.rm = na.rm, ...)
    )
  )
}

#' StatFan
#' @rdname ggplot2-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatFan <- ggproto("StatFan", Stat,
                            required_aes = "y",
                            default_aes = aes(fill=stat(percent),group=stat(id)),
                            compute_group = function(data,scales,step=0.01) do_fan(data$y,step)
)
