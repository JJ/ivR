#!/usr/bin/env Rscript

library(tidyverse)

circunstancias.2122 <- read.csv("data-raw/circunstancias-evaluacion-resultados-21-22.csv")
circunstancias.2223 <- read.csv("data-raw/circunstancias-evaluacion-resultados-22-23.csv")

circunstancias.2122$Curso <- "21-22"
circunstancias.2223$Curso <- "22-23"

circunstancias <- as_tibble( rbind( circunstancias.2122, circunstancias.2223) )
circunstancias$Num <- circunstancias$AsignaturasAtrasadas + circunstancias$NoAsistencia + circunstancias$Trabajando

save(circunstancias, file="data/circunstancias.rda")
