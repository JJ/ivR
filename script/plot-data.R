#!/usr/bin/env Rscript

library(tidyverse)
library(ggplot2)

load("data/all-data.rda")

ggplot(all.data, aes(x=Aprobado,y=superacion))+geom_boxplot(notch=T)+ylim(0,30)

summary(all.data[ all.data$Aprobado == T,]$superacion)
summary(all.data[ all.data$Aprobado == F,]$superacion)
wilcox.test( all.data[ all.data$Aprobado == T,]$superacion,all.data[ all.data$Aprobado == F,]$superacion)

aprobados <- all.data[ all.data$Aprobado == T,]
aprobados$Aprobado <- NULL
p <- c(.5,.75)
aprobados %>% group_by(Objetivo) %>% dplyr::summarize(porcentaje=scales::percent(p),entregas = quantile(entrega.Dias,p))
