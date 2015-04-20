#' @export
#'
htmlItems <- function(d, filterCols, elemTpl = NULL){

  elemTplStd <- '
<div class="container">
<h1>{{name}}</h1>
<p>{{url}}</p>
<p>{{githubUrl}}</p>
</div>'
  elemTpl <- elemTpl %||% elemTplStd


  ## TODO
  #Apply Filter classes
   #filterCols <- c('tags','status','author')

   lFilters <- lapply(filterCols,function(col){
      catFilters <-lapply(d[,col],function(x){
        x <- nullToEmpty(x, empty="empty")
        filterRowValues <- c(col,strsplit(x,",")[[1]])
        elemClass <- paste(filterRowValues,collapse = " ")
      })
      catFilters
    })
  dtmp <- as.data.frame(mapply(c,lFilters))
  elem <- unite_(dtmp,"classes",names(dtmp),sep=" ")
  elemClass <- paste("element-item",elem$classes)


  tpl <- paste0('<div class="{{itemClasses}}">',elemTpl,'\n</div>')
  d$itemClasses <- elemClass
  whisker.render.df(tpl,d)

}

#' @export
#'
filterBtnHtml <- function(d, filterCols = NULL){
  #filterCols <- c('tags','status','author')
  filterCols <- filterCols %||% names(d)
  buttons <- lapply(filterCols, function(col){
    l <- lapply(d[,col],function(x){
      x <- nullToEmpty(x, empty="empty")
      #filterRowValues <- paste(col,strsplit(x,",")[[1]],sep"-")
      filterRowValues <- c(strsplit(x,",")[[1]])
      paste0(".",c(col,filterRowValues),collapse = "")
      })
    l
    })
  buttons <- unique(unlist(buttons))

  btnsHtml <- lapply(buttons,function(b){
    tags$button(b,class="button",`data-filter`= b)
  })
  btnsHtml <- Filter(function(b){!grepl("empty",b)},btnsHtml)
  filterDiv <- tags$div(id="filters",class="button-group",
                       tags$button('All',class="is-checked",`data-filter`="*"),
                       btnsHtml
                       )
  doRenderTags(filterDiv)
}

sortCols <- c("name","author")

sortBtnHtml <- function(d,sortCols){

}
