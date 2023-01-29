#!/usr/bin/env Rscript

library(parsedate)

data.20.21 <- read.csv("data-raw/fechas-entrega-2021-22.csv",sep=";")
inicio <- parse_iso_8601("2021-09-13T00:00:00+02:00")
data.20.21$Correccion <- parse_iso_8601(data.20.21$Correccion)
data.20.21$Correccion.Semana <- as.numeric( data.20.21$Correccion - inicio, units = "weeks")

data.20.21$Entrega <- parse_iso_8601(data.20.21$Entrega)
data.20.21$Entrega.Semana <- as.numeric( data.20.21$Entrega - inicio, units = "weeks")

data.20.21$superacion <- as.numeric(data.20.21$Correccion - data.20.21$Entrega, units="days");
data.20.21$curso = "21-22"
data.20.21 <- data.20.21[order(data.20.21$Entrega),]
data.20.21$entregas <- seq.int(nrow(data.20.21))
data.20.21$Entrega <- NULL
data.20.21$Correccion <- NULL

save(data.20.21, file="data/entregas-20-21.rda")
