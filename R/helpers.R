#' @export
#'
htmlItems <- function(d, filterCols, elemTpl = NULL){

  elemTplStd <- '
<div class="container m4 p2 bg-silver">
<h1 class="name">{{name}}</h1>
<p class="url">{{url}}</p>
<p class="author">{{author}}</p>
<p class="githubUrl">{{githubUrl}}</p>
</div>'
  elemTpl <- elemTpl %||% elemTplStd


  ## TODO
  #Apply Filter classes
   #filterCols <- c('tags','status','author')

   lFilters <- lapply(filterCols,function(col){
      catFilters <-lapply(d[,col],function(x){
        x <- as.character(nullToEmpty(x, empty="empty"))
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
#   names(buttons) <- filterCols
#
#   Map(function(b1){
#
#   },buttons)

  buttons <- unique(unlist(buttons))

  btnsHtml <- lapply(buttons,function(b){
    tags$button(b,class="button",`data-filter`= b)
  })
  btnsHtml <- Filter(function(b){!grepl("empty",b)},btnsHtml)
  filterDiv <- tags$div(id="filters",class="button-group",
                        #tags$button('All',class="is-checked",`data-filter`="*"),
                        tags$button('All',class="button",`data-filter`="*"),
                        btnsHtml
                       )
  doRenderTags(filterDiv)
}

#' @export
sortBtnHtml <- function(d,sortCols = NULL){
  sortCols <- sortCols %||% names(d)
  buttons <- sortCols
  #<button class="button" data-sort-by="name">name</button>
  btnsHtml <- lapply(buttons,function(b){
    tags$button(b,class="button",`data-sort-by`= b)
  })
  sortDiv <- tags$div(id="sorts",class="button-group",
                      tags$h3("Sort"),
                      tags$button("original-order",class="button",`data-sort-by`= "original-order"),
                      btnsHtml
  )
  doRenderTags(sortDiv)
}


#' @export
selectizeOpts <- function(d, filterCols){
  #filterCols <- c('tags','status','author')
  df <- d[c(filterCols)]
  l <- lapply(filterCols,function(col){
    df <- d[col]
    df$groupId <- col
    names(df) <- c("filterValueId","groupId")
    df <- df[!is.null(df$filterValueId),]
    df
  })
  optsDf <- do.call(rbind.data.frame, l)
  optsDf <- optsDf[optsDf$filterValueId != "",]
  optsDf <- optsDf[!duplicated(optsDf),]
  optsDf$filterValueId <- as.character(optsDf$filterValueId)
  optsDf <- ddply(optsDf, names(optsDf),function(d){
    x <- strsplit(d$filterValueId,",")[[1]]
    df <- data.frame(filterValueId = x, stringsAsFactors = FALSE)
    df$groupId <- d$groupId
    df
  })
  optsDf <- optsDf[!duplicated(optsDf),]
  optsDf <- optsDf[with(optsDf,order(groupId,filterValueId)),]
  optsDf$filterValueLabel <- optsDf$filterValueId
  optsDf
}



