#!/usr/bin/env Rscript

library(parsedate)

args = commandArgs(trailingOnly=TRUE)
data.file = "data-raw/fechas-entrega-2021-22.csv"
fecha.inicial = "2021-09-13T00:00:00+02:00"
sufijo.fichero = "21-22"


if (length(args)>=1) {
  data.file = args[1]
}

if (length(args)>=2) {
  fecha.inicial = args[2]
}

if (length(args)>=3) {
  sufijo.fichero = args[3]
}

date.data <- read.csv(data.file,sep=";")
inicio <- parse_iso_8601(fecha.inicial)
date.data$Correccion <- parse_iso_8601(date.data$Correccion)
date.data$Correccion.Semana <- as.numeric( date.data$Correccion - inicio, units = "weeks")

date.data$Entrega <- parse_iso_8601(date.data$Entrega)
date.data$Entrega.Semana <- as.numeric( date.data$Entrega - inicio, units = "weeks")

date.data$superacion <- as.numeric(date.data$Correccion - date.data$Entrega, units="days");
date.data$curso = sufijo.fichero
date.data <- date.data[order(date.data$Entrega),]
date.data$entregas <- seq.int(nrow(date.data))
date.data$Entrega <- NULL
date.data$Correccion <- NULL

save(date.data, file=paste0("data/entregas-",sufijo.fichero,".rda"))
