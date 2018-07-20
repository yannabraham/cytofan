#' Compute summary statistics for \code{stat_fan}
#'
#' Extracts the limits of the Ntiles of a distribution for use in the \code{stat_fan} function
#'
#' @param x the value to summarize
#' @param step the number of bins to break the data into, based on the \code{quantile} function
#'
#' @return a data.frame containing
#'     \itemize{
#'         \item ymin    : the lower limit of the quantile
#'         \item ymax    : the upper limit of the quantile
#'         \item id      : an identifier for the quantile
#'         \item percent : the fill colorto use in \code{geom_fan}
#'     }
#' @examples
#' FanEuStockMarkets <- lapply(colnames(EuStockMarkets),function(id) {
#'     res <- do_fan(EuStockMarkets[,id])
#'     res$id <- id
#'     return(res)
#' })
#' FanEuStockMarkets <- do.call(rbind,FanEuStockMarkets)
#'
#' @importFrom stats quantile
#' @export
do_fan <- function(x,step=0.01) {
  data.frame(ymin=quantile(x,probs=seq(0,1,step))[-length(seq(0,1,step))],
             ymax=quantile(x,probs=seq(0,1,step))[-1],
             id=seq(1,length(seq(step,1,step))),
             percent=abs(seq(step,1,step)-0.5))
}
