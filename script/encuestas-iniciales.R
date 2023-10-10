library(dplyr)
library(tidyr)
library(stringr)
library(ggplot2)
library(ggthemes)

ficheros_encuesta <- dir("data/encuestas-iniciales")
ficheros_encuesta <- paste0("data/encuestas-iniciales/",ficheros_encuesta)
datos.encuesta <- do.call(rbind,lapply(ficheros_encuesta,read.csv))

datos.encuesta$year <- format(as.Date(datos.encuesta$Marca.temporal,format="%d/%m/%Y %H:%M:%S"),"%Y")
colnames(datos.encuesta) <- c("Marca.temporal","Eleccion.asignatura","Expectativas","Conocimientos.previos","Adquisicion.conocimientos","year")

datos.encuesta$git <- str_detect(datos.encuesta$Conocimientos.previos,"git")
datos.encuesta$python <- str_detect(datos.encuesta$Conocimientos.previos,"Python")

resumen.datos <- datos.encuesta %>% group_by(year,Adquisicion.conocimientos,git,python) %>% summarize(n=n())
resumen.git <- datos.encuesta %>% group_by(git, Adquisicion.conocimientos) %>% summarize(n=n()) %>% mutate(freq = n / sum(n))
resumen.conocimientos.year <- datos.encuesta %>% filter(git=TRUE) %>% group_by(Adquisicion.conocimientos,year) %>% summarize(n=n())
resumen.conocimientos <- datos.encuesta %>% group_by(Adquisicion.conocimientos) %>% summarize(n=n())

ggplot(resumen.datos,aes(x=year,y=n,fill=Adquisicion.conocimientos))+geom_bar(stat="identity",position="dodge")+facet_grid(git~python)+theme_economist()+theme(legend.position="bottom")
ggplot(resumen.git,aes(x=git,y=n,fill=Adquisicion.conocimientos))+geom_bar(stat="identity",position="dodge")+theme_economist()+theme(legend.position="bottom")
ggplot(resumen.conocimientos.year,aes(x=year,y=n,fill=Adquisicion.conocimientos))+geom_bar(stat="identity",position="dodge")+theme_economist()+theme(legend.position="bottom")
ggplot(resumen.conocimientos,aes(x=Adquisicion.conocimientos,y=n))+geom_bar(stat="identity",position="dodge")+theme_economist()+theme(legend.position="bottom")
