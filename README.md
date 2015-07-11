# Isotope Htmlwidget for R

[Isotope](http://isotope.metafizzy.co/) layout library straight from R to render Data Frames as interactive galleries.
It handles sortings, filtering and custom item html templates.
Uses basscss.

# How to

If you provide filterCols you can select which columns to use as filters.

If you provide sortCols you can select which columns to use to sort the items.

You can also provide custom html templates to render the items.

```{r, message=FALSE}
# devtools::install_github("jpmarindiaz/isotope")
library(isotope)
d <- read.csv(system.file("data/candidatos.csv",package="isotope"), stringsAsFactors = FALSE)

filterCols <- c("genero","profesiones", "niveldeestudios","talante", "pragmaticoideologico","visionpais")
sortCols <- c("nombre","apoyosenadores","apoyorepresentantes")

tpl <- '
<div style="border: 1px solid grey; margin:5px; padding:5px">
  <div class="container">
    <h3 class="nombre">{{nombre}}</h3>
    <div style="width:125px; height: 125px; margin:auto">
      <img src={{foto}} class="circle" width="100px"/>
    </div>
    <p>Profesión: {{profesiones}}, Género: {{genero}},Nivel de estudios: {{niveldeestudios}}</p>
    <div class="apoyosenadores"><em>Apoyo Senadores:</em> {{apoyosenadores}}</div>
    <div class="apoyorepresentantes"><em>Apoyo Representantes:</em> {{apoyorepresentantes}}</div>
  </div>
</div>
'
isotope(d, filterCols = filterCols, sortCols = sortCols, lang = 'es', elemTpl = tpl)

```




# Todo

- Sort opts: Button names, original-order(add/remove, lang)
- style sort buttons
- Add width/height properties for elements
- add custom css
- Fix some layoutModes by adding height property to each item
- Warn about sort buttons not present in template
- Add more separators for multiple values per column currently only "," is supported.
