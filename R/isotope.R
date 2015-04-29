#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
isotope <- function(d, layoutMode = "masonry", filterCols = NULL, sortCols = NULL, elemTpl = NULL, lang = "en",width = NULL, height = NULL) {

  if(lang == "es"){
    filterTitle <- 'Filtrar por'
    sortTitle <- 'Ordenar por'
  }else{
    filterTitle <- 'Filter'
    sortTitle <- 'Sort'
  }

  # Data names properly formatted to use as item classes
  originalNames <- names(d)
  names(d) <- gsub(".","-",names(d),fixed=TRUE)

  if(!is.null(sortCols)) {
    if(!sortCols %in% originalNames) stop(sortCols must be one of names(d))
    sortCols <- names(d)[match(sortCols,originalNames)]
    names(sortCols) <- originalNames[match(sortCols,names(d))]
  }
  if(!is.null(filterCols)) {
    if(!filterCols %in% originalNames) stop(filterCols must be one of names(d))
    filterCols <- names(d)[match(filterCols,originalNames)]
    names(filterCols) <- originalNames[match(filterCols,names(d))]
  }

  availableLayoutModes <- c('masonry','fitRows','cellsByRow','vertical','packery',
                            'masonryHorizontal','fitColumns','cellsByColumn','horizontal')
  availableLayoutModes <- c('masonry','fitRows','vertical')
  if(!layoutMode %in% availableLayoutModes)
    stop("layoutMode must be one of the following: 'masonry','fitRows','vertical'")

#   filterCols <- names(d)[match(filterCols,originalNames)]

  if(is.null(filterCols)){
    message("No filter columns provided: no filters will be shown")
    filterBtns <- ''
  } else{
    if(is.null(names(filterCols))) names(filterCols) <- filterCols
    filterBtns <- paste0('<h3>',filterTitle,'</h3><div id="select-car"></div>')
  }

  if(is.null(sortCols)){
    message("No sort columns provided: no sort buttons will be shown")
    sortBtns <- ""
    sortData <- ""
  }else{
    sortData <- as.list(paste0(".",sortCols))
    names(sortData) <- sortCols
    sortBtns <- sortBtnHtml(d,sortCols, sortTitle)
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
    selectizeOptgroups = selectizeOptgroups,
    layoutMode = layoutMode
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
isotopeOutput <- function(outputId, width = '100%', height = '600px'){
  shinyWidgetOutput(outputId, 'isotope', width, height, package = 'isotope')
}

#' Widget render function for use in Shiny
#'
#' @export
renderIsotope <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, isotopeOutput, env, quoted = TRUE)
}
