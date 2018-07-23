#' Fan plots for trend and population visualizations
#'
#' Visualise the distribution of continuous variables by dividing each variables
#' into a fixed number of bins and returning the bin limits. In fan plots (`geom_fan`)
#' bins are grouped over all variables and colored after their distance from the center bin,
#' which corresponds to the median. The center bin corresponds to the strongest shade of `colorbase`,
#' while other bins get decreasing shades.
#'
#' `stat_fan` is suitable only for continuous y data. Moreover, if you have less than `1/step` points
#' you might need to adjust the `step` parameter.
#'
#' @param colorbase the colors to use to draw the ribbon. defaults to RColorBrewer `Oranges`.
#'     See \code{\link[RColorBrewer]{brewer.pal}} for details.
#'
#' @inheritParams ggplot2::layer
#' @inheritParams ggplot2::geom_point
#'
#' @examples
#' # reformat dataset from short-wide to tall-skinny
#' EuStockMarkets_ts <- lapply(colnames(EuStockMarkets),function(id) {
#'   data.frame(id=id,value=as.numeric(EuStockMarkets[,id]))
#' })
#' EuStockMarkets_ts <- do.call('rbind',EuStockMarkets_ts)
#'
#' # plot the distribution of the different stock markets
#' ggplot(EuStockMarkets_ts,aes(x=id,y=value))+
#'   geom_fan()
#'
#' # Change the step
#' ggplot(EuStockMarkets_ts,aes(x=id,y=value))+
#'   geom_fan(step=0.05)
#'
#' # change the default color
#' ggplot(EuStockMarkets_ts,aes(x=id,y=value))+
#'   geom_fan(colorbase='Greens')
#'
#' # any valid RColorBrewer palette will work
#' ggplot(EuStockMarkets_ts,aes(x=id,y=value))+
#'   geom_fan(colorbase='RdYlGn')
#'
#' @export
geom_fan <- function(mapping = NULL, data = NULL,
                     position = "identity", na.rm = FALSE, show.legend = NA,
                     inherit.aes = TRUE, step=0.01, colorbase='Oranges', ...) {
  list(
    layer(
      stat = StatFan, geom = GeomRibbon, data = data, mapping = mapping,
      position = position, show.legend = show.legend, inherit.aes = inherit.aes,
      params = list(na.rm = na.rm, ...)
    ),
    scale_fill_gradientn(colours=rev(RColorBrewer::brewer.pal(9,colorbase)) ),
    guides(fill=FALSE)
  )
}
