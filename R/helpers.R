#' @export
#'
htmlItems <- function(d, tpl){


  ## TODO
  #Apply Filter classes
#  filterCols <- c('tags','status','author')
#   lFilters <- lapply(filterCols,function(col){
#     catFilters <-lapply(d[,col],function(x){
#       x <- nullToEmpty(x, empty="empty")
#       filterRowValues <- c(col,strsplit(x,",")[[1]])
#       filters <- paste0('.',filterRowValues, collapse=", ")
#       filters
#     })
#     catFilters
#   })
#   unique(unlist(lFilters))

  tpl <- '
<div class="container">
<h1>{{name}}</h1>
<p>{{url}}</p>
</div>'
  tpl <- paste0('<div class="element-item">\n',tpl,'</div>')
  whisker.render.df(tpl,d)
}

#' @export
#'
filterButtons <- function(d, filterCols = NULL){

  filterCols <- c('tags','status','author')
  filterCols <- filterCols %||% names(d)


  buttons <- lapply(filterCols, function(col){
    lapply(d[,col],function(x){
      x <- nullToEmpty(x, empty="empty")
      #filterRowValues <- paste(col,strsplit(x,",")[[1]],sep"-")
      filterRowValues <- c(strsplit(x,",")[[1]])
      paste(col,filterRowValues,sep="-")
      })
    })
  buttons <- unique(unlist(buttons))

  btnHtml <- lapply(buttons,function(b){
    tags$button(b,`data-filter`= paste0(".",b))
  })
  btnHtml <- Filter(function(b){!grepl("empty",b)},btnHtml)
  btnShowAll <- tags$button('tags',class="is-checked",`data-filter`="*")
  btnHtml <- c(btnShowAll, btnHtml)

renderTags(btnHtml)


  tags$button('tags',`data-filter`=filter)

  #<button class="button is-checked" data-filter="*">show all</button>
  #tpl <- '<button class="button" data-filter=".metal">metal</button>'



tpl <- paste0('<h2>Filter</h2>
<div id="filters" class="button-group">',tpl,'</div>')
  whisker.render.df(tpl,d)
}

btn$attribs$class

