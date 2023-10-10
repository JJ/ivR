library(dplyr)
library(tidyr)
library(stringr)

ficheros_encuesta <- dir("data/encuestas-iniciales")
ficheros_encuesta <- paste0("data/encuestas-iniciales/",ficheros_encuesta)
datos.encuesta <- do.call(rbind,lapply(ficheros_encuesta,read.csv))

# Extract year from datos.encuesta$Marca.temporal
datos.encuesta$year <- format(as.Date(datos.encuesta$Marca.temporal,format="%d/%m/%Y %H:%M:%S"),"%Y")
colnames(datos.encuesta) <- c("Marca.temporal","Eleccion.asignatura","Expectativas","Conocimientos.previos","Adquisicion.conocimientos","year")

datos.encuesta$git <- str_detect(datos.encuesta$Conocimientos.previos,"git")
datos.encuesta$python <- str_detect(datos.encuesta$Conocimientos.previos,"Python")

# summarize data by year, Adquisicion.conocimientos, git, python
resumen.datos <- datos.encuesta %>% group_by(year,Adquisicion.conocimientos,git,python) %>% summarize(n=n())
resumen.git <- datos.encuesta %>% group_by(Adquisicion.conocimientos) %>% summarize(n=n())
resumen.conocimientos.year <- datos.encuesta %>% group_by(Adquisicion.conocimientos,year) %>% summarize(n=n())

