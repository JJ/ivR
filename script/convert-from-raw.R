#!/usr/bin/env Rscript

library(parsedate)

args = commandArgs(trailingOnly=TRUE)
if (length(args)==0) {
  data.file = "data-raw/fechas-entrega-2021-22.csv"
} else {
  # default output file
  data.file = args[1]
}

date.data <- read.csv(data.file,sep=";")
inicio <- parse_iso_8601("2021-09-13T00:00:00+02:00")
date.data$Correccion <- parse_iso_8601(date.data$Correccion)
date.data$Correccion.Semana <- as.numeric( date.data$Correccion - inicio, units = "weeks")

date.data$Entrega <- parse_iso_8601(date.data$Entrega)
date.data$Entrega.Semana <- as.numeric( date.data$Entrega - inicio, units = "weeks")

date.data$superacion <- as.numeric(date.data$Correccion - date.data$Entrega, units="days");
date.data$curso = "21-22"
date.data <- date.data[order(date.data$Entrega),]
date.data$entregas <- seq.int(nrow(date.data))
date.data$Entrega <- NULL
date.data$Correccion <- NULL

save(date.data, file="data/entregas-20-21.rda")
