#' @export
whisker.render.df <- function(tpl,d, collapse = TRUE){
  ld <-  apply(d, 1, function(r) {
    out <- as.list(r)
    names(out) <- names(r)
    out
  })
  l <- lapply(ld,function(r,tpl){
    whisker.render(tpl,r)
  },tpl)
  out <- unlist(l)
  if(collapse) out <- paste(out,collapse="\n")
  out
}

#' @export
#'
list_to_df <- function(l){
  as.data.frame(do.call(rbind, l))
}

`%||%` <- function (x, y)
{
  if (is.null(x) || is.na(x))
    return(y)
  else return(x)
}

nullToEmpty <- function(x, empty = ""){
  if(is.null(x)) return(empty)
  else return(x)
}
