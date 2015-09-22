# library(devtools)
# load_all()
# document()

library(isotope)

d <- read.csv("inst/data/concejo-bogota-min.csv")
names(d) <- gsub("."," ",names(d),fixed= TRUE)
filterCols <- c("Partido","Ha sido concejal","Trabajó con Petro","Vínculo al carrusel","Tiene padrino político","Es delfín","Ha ocupado cargos públicos")


isotope(d, layoutMode = 'fitRows', filterCols = filterCols, lang = 'es',elemTpl = NULL,style = NULL, filtersAsCols = FALSE, placeholder = 'SEL FILTRO')


tpl <- '
<div class=\ "
defaultBoxOut\">
<div class=\ "defaultBoxIn\">
<div id="navbar">
<img class=\ "imageUrl\" src=\ "{{imageUrl}}\" width=\ "100%\"/>\n
<p class=\ "Partido\">{{PartidoLabel}}</p>\n
</div>
<div id="content">
<h3 class=\ "Nombre\">{{Nombre}}</h3>\n

<p class=\ "Trabajó-con-Petro\"></p>\n
<p class=\ "Vínculo-al-carrusel\"></p>\n
<p class=\ "Tiene-padrino-político\"></p>\n
<p class=\ "Ha-sido-concejal\"></p>\n
<p class=\ "Es-delfín\"></p>\n
<p class=\ "Ha-ocupado-cargos-públicos\"></p>
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

e <- isotope(d, layoutMode = layout,filterCols = filterCols, lang = 'es',elemTpl = tpl,style = style, placeholder = 'Haga click aquí para utilizar los filtros')


saveWidget(e,"~/Desktop/tarjeton-concejo-bogota-2015-v3.html",selfcontained = TRUE)






