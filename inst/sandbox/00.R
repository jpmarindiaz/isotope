
library(devtools)
library(htmlwidgets)


document()
devtools::install()

library(isotope)
isotope("hola")

library(yaml)
library(htmltools)
library(whisker)

l <- yaml.load_file("inst/data/htmlwidgets.yaml")
d <- list_to_df(l)

filterCols <- c('tags','status','author')

selectizeOptions <- selectizeOpts(d, filterCols)

cat(htmlItems(d, filterCols))
cat(filterBtnHtml(d,filterCols))
cat(sortBtnHtml(d,sortCols))










