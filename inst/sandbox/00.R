
library(devtools)
load_all()
document()
devtools::install()


library(isotope)

d <- read.csv("inst/data/latamCountries.csv", stringsAsFactors = FALSE)
filterCols <- c("idioma","zonaHoraria")
sortCols <- c("población","gdpPerCapita")
isotope(d[-1], filterCols = filterCols, sortCols = sortCols, lang = 'es')




d <- read.csv("inst/data/candidatos.csv", stringsAsFactors = FALSE)

filterCols <- c("genero","profesiones", "niveldeestudios","talante", "maspoliticoquetecnico","masmicroquemacrogerente","cambiamejoramodelo", "pragmaticoideologico","visionpais")
sortCols <- c("nombre","apoyosenadores","apoyorepresentantes")

isotope(d, filterCols = filterCols, sortCols = sortCols, lang = 'es')

tpl <- '
<div class="m1">
  <div class="container p1 border bg-lighter-gray">
    <p class={{nombre}}>{{nombre}}</p>
    <div style="width:125px; height: 125px; margin:auto">
      <img src={{foto}} class="circle" width="100px"/>
    </div>
    <p>{{profesiones}}{{genero}},{{niveldeestudios}}</p>
  </div>
</div>
'
style <- '.m1{background-color: red}'
isotope(d, layoutMode = 'fitRows', filterCols = filterCols,elemTpl = tpl,style = style)






d <- read.csv("inst/data/retail-sku-sample.csv",stringsAsFactors = FALSE)
#names(d) <- gsub(".","-",names(d),fixed=TRUE)

sorts <- names(d)
#names(sorts) <- paste("new ",names(d))
isotope(d, sortCols = sorts[1:4], lang = 'es')

isotope(d, layoutMode = 'fitColumns')
isotope(d, layoutMode = 'fitRows')
isotope(d, layoutMode = 'packery')
isotope(d, layoutMode = 'masonry')
isotope(d, layoutMode = 'cellsByColumn')
isotope(d, layoutMode = 'vertical')
isotope(d, filterCols = sorts[3:6])
isotope(d, filterCols = names(d), sortCols = names(d))
isotope(d, filterCols = names(d), sortCols = names(d), lang='es')


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










