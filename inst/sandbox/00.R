
library(devtools)
library(htmlwidgets)


document()
devtools::install()

library(isotope)
l <- yaml.load_file("inst/data/htmlwidgets.yaml")
d <- list_to_df(l)
filterCols <- c('tags','status','author','jsLibIds')
sortCols <- c("name","author","url")
isotope(d, filterCols, sortCols)

d <- mtcars
isotope(d, filterCols = c("gear","carb"))

d <- iris
names(iris) <- gsub(".","-",names(iris),fixed=TRUE)
elemTpl <- '
<div class="m1">
<div class="container p1 border bg-olive lime">
<h2 class="{{Species}}">{{Species}}</h2>
<p class="Sepal-Length"><strong>Sepal Length: </strong>{{Sepal-Length}}</p>
<p class="Petal-Width"><strong>Petal Width: </strong>{{Petal-Width}}</p>
</div>
</div>
'
isotope(d, filterCols = "Species",sortCols = c("Petal-Width","Sepal-Length"),elemTpl = elemTpl)



library(yaml)
library(htmltools)
library(whisker)







selectizeOptions <- selectizeOpts(d, filterCols)

cat(htmlItems(d, filterCols))
cat(filterBtnHtml(d,filterCols))
cat(sortBtnHtml(d,sortCols))










