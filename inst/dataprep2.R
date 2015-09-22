library(isotope)


d <- read.csv("inst/data/concejo-bogota.csv")
d <- d[1:19]
names(d) <- gsub("."," ",names(d),fixed= TRUE)

x <- paste0(d$`Fue concejal`,d$`Es concejal`)
d$`Ha sido concejal` <- ifelse(x == "", "No ha sido_concejal","Si ha sido_concejal")

names(d)
d <- d[c("Nombre completo", "Link foto","Partido","Trabajó con Petro","Tiene un vínculo directo o indirecto con el carrusel de la contratación","Tiene padrino político","Ha sido concejal","Es delfín","Ha ocupado cargos públicos","perfilito")]


names(d) <- c("Nombre","imageUrl","Partido","Trabajó con Petro","Vínculo al carrusel","Tiene padrino político","Ha sido concejal","Es delfín","Ha ocupado cargos públicos","Perfilito")

d$`Trabajó con Petro` <- ifelse(d$`Trabajó con Petro` == "si", "Trabajó","No trabajó")
d$`Vínculo al carrusel` <- ifelse(d$`Vínculo al carrusel` == "si", "Vinculado","No vinculado")
d$`Tiene padrino político` <- ifelse(d$`Tiene padrino político` == "si", "Tiene padrino","No tiene padrino")
d$`Es delfín` <- ifelse(d$`Es delfín` == "si","Es delfín", "No es delfín")
d$`Ha ocupado cargos públicos` <- ifelse(d$`Ha ocupado cargos públicos`=="si","Si cargos públicos","No cargos publicos")
d$PartidoLabel <- d$Partido
#d$Partido <-  gsub(" ","_",d$Partido,fixed= TRUE)

write.csv(d,"inst/data/concejo-bogota-min.csv",row.names = FALSE)






