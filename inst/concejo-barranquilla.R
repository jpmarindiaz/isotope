library(devtools)
load_all()
document()
install()
library(isotope)

d <- read.csv("inst/data/alcaldia-bucaramanga.csv")
names(d) <- gsub("."," ",names(d),fixed= TRUE)

filterCols <- names(d)[!names(d) %in% c("Número","Nombre","Perfilito","imageUrl")]

isotope(d, layoutMode = 'fitRows', filterCols = filterCols, lang = 'es',elemTpl = NULL,style = NULL, filtersAsCols = FALSE, placeholder = 'SEL FILTRO')


# d <- d[2:14]
#
# names(d)[1] <- "Nombre"
# names(d)[12] <- "Perfilito"
# names(d)[13] <- "imageUrl"
# filterCols <- names(d)[3:ncol(d)-2]


isotope(d, layoutMode = 'fitRows', filterCols = filterCols, lang = 'es',elemTpl = NULL,style = NULL, filtersAsCols = FALSE, placeholder = 'SEL FILTRO')


tpl <- '
<div class=\ "
defaultBoxOut\">
<div class=\ "defaultBoxIn\">
<div id="navbar">
<img class=\ "imageUrl\" src=\ "{{imageUrl}}\" width=\ "100%\"/>\n
<p class=\ "Partido\">{{Partido}}</p>\n
</div>
<div id="content">
<h3 class=\ "Nombre\">{{Nombre}}</h3>\n

<p class=\ "Partido\"></p>\n
<p class=\ "Tiene-padrino-político\"></p>\n
<p class=\ "Ha-sido-funcionario-público\"></p>\n
<p class=\ "Ha-sido-elegido-por-voto-popular\"></p>\n
<p class=\ "Tiene-relación-con-condenados\"></p>\n
<p class=\ "Es-cercano-al-alcalde\"></p>\n
<div class="Perfilito"><p>{{Perfilito}}</p></div>
</div>
</div>
</div>
'

style <- '
.element-item{
height: 265px !important;
position:relative;
min-height: 265px;
overflow:hidden;
}
.defaultBoxOut{
height: 240px !important;
border:1px solid #D0DAD0;
border-radius: 2px;
padding:5px;
margin:5px;
position:relative;
overflow:hidden;
}
.defaultBoxIn{
max-width: 250px;
height: 220px;
overflow:hidden;
position:relative;
}
.defaultBoxIn h3{
color: #43ABD3;
}
.defaultBoxIn p {
font-size: 80%;
color: #8A8A8C;
}
#content {
margin-left:  30%;
padding: 5px;
}
#navbar {
float: left;
width: 35%;
padding: 5px;
}
#navbar p{
color: #43ABD3;
font-size: 90%;
}
.Perfilito{
height: 150px;
overflow:scroll;
}

'


layout = "fitRows"
isotope(d, layoutMode = layout,filterCols = filterCols, lang = 'es',elemTpl = tpl,style = style, placeholder = 'Haga click aquí para utilizar los filtros')

# e <- isotope(d, layoutMode = layout,filterCols = filterCols, lang = 'es',elemTpl = tpl,style = style, placeholder = 'Haga click aquí para utilizar los filtros')
#
#
# saveWidget(e,"~/Desktop/tarjeton-concejo-barranquilla-2015-v1.html",selfcontained = TRUE)
#





