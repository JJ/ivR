#!/usr/bin/env Rscript

library(tidyverse)

load("data/entregas-21-22.rda")
date.data.2122 <- date.data
load("data/entregas-22-23.rda")
date.data.2223 <- date.data
load("data/entregas-23-24.rda")
date.data.2324 <- date.data
load("data/entregas-24-25.rda")
date.data.2425 <- date.data

all.data <- as_tibble(rbind(date.data.2122,date.data.2223,date.data.2324,date.data.2425))
all.data$entrega.Dias <- all.data$Entrega.Semana*7
all.data$Correccion.Dias <- all.data$Correccion.Semana*7
all.data$entregas <- NULL

save(all.data, file="data/all-data.rda")
