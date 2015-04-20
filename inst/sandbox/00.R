
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
d$uniqueId <- seq(1:nrow(d))





filterBtnTpl <-


h <- ht
cat(htmlItems)










