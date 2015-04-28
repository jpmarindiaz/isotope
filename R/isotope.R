#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
isotope <- function(d, filterCols = NULL, sortCols = NULL, elemTpl = NULL, width = NULL, height = NULL) {

  # Data names properly formatted to use as item classes
  originalNames <- names(d)
  names(d) <- gsub(".","-",names(d),fixed=TRUE)

  if(!is.null(sortCols)) {
    sortCols <- names(d)[match(sortCols,originalNames)]
    names(sortCols) <- originalNames[match(sortCols,names(d))]
  }
  if(!is.null(filterCols)) {
    filterCols <- names(d)[match(filterCols,originalNames)]
    names(filterCols) <- originalNames[match(filterCols,names(d))]
  }

#   filterCols <- names(d)[match(filterCols,originalNames)]

  if(is.null(filterCols)){
    message("No filter columns provided: no filters will be shown")
    filterBtns <- ''
  } else{
    if(is.null(names(filterCols))) names(filterCols) <- filterCols
    filterBtns <- '<h3>Filter</h3><div id="select-car"></div>'
  }

  if(is.null(sortCols)){
    message("No sort columns provided: no sort buttons will be shown")
    sortBtns <- ""
    sortData <- ""
  }else{
    sortData <- as.list(paste0(".",sortCols))
    names(sortData) <- sortCols
    sortBtns <- sortBtnHtml(d,sortCols)
  }

  if(is.null(elemTpl)){
    message("Using default element template")
    items <- htmlItems(d,filterCols)
  } else{
    items <- htmlItems(d,filterCols,elemTpl)
  }

  ## Selectize
  if(is.null(filterCols)){
    selectizeOptions <- list()
    selectizeOptgroups <- list()
    selectizeOptgroups$groupLabel <- list()
  } else{
    selectizeOptions <- selectizeOpts(d, filterCols)
    selectizeOptgroups <- data.frame(groupId =  unique(selectizeOptions$groupId))
    selectizeOptgroups$groupLabel <- names(filterCols)[match(selectizeOptgroups$groupId,filterCols)]
  }

  # forward options using x
  x = list(
    filterBtns = filterBtns,
    sortBtns = sortBtns,
    sortData = sortData,
    items = items,
    selectizeOptions = selectizeOptions,
    selectizeOptgroups = selectizeOptgroups
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'isotope',
    x,
    width = width,
    height = height,
    package = 'isotope'
  )
}

#' Widget output function for use in Shiny
#'
#' @export
isotopeOutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'isotope', width, height, package = 'isotope')
}

#' Widget render function for use in Shiny
#'
#' @export
renderIsotope <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, isotopeOutput, env, quoted = TRUE)
}
