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
  l <- lapply(l,function(ll){lapply(ll,nullToEmpty)})
  do.call(rbind.data.frame, l)
  #plyr::ldply (l, data.frame)
  #data.frame(matrix(unlist(l), nrow=length(l), byrow=T))
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
