#!/usr/bin/env Rscript

library(tidyverse)
library(ggplot2)
library(ggthemes)
load("data/all-data.rda")

ggplot(all.data, aes(x=Aprobado,y=superacion))+geom_boxplot(notch=T)+ylim(0,30)

summary(all.data[ all.data$Aprobado == T,]$superacion)
summary(all.data[ all.data$Aprobado == F,]$superacion)
wilcox.test( all.data[ all.data$Aprobado == T,]$superacion,all.data[ all.data$Aprobado == F,]$superacion)

aprobados <- all.data[ all.data$Aprobado == T,]
aprobados$Aprobado <- NULL
p <- c(.25,.5,.75,.9,1)
tabla.dias.entregas <- aprobados %>% group_by(Objetivo) %>% dplyr::summarize(porcentaje=scales::percent(p),entregas = quantile(entrega.Dias,p))
save(tabla.dias.entregas, file="data/tabla-dias-entregas.rda")

all.data$Objetivo <- as.factor(all.data$Objetivo)

ggplot(all.data, aes(x=Objetivo,y=Entrega.Semana))+geom_boxplot(notch=T)+geom_jitter(aes(color=curso))+theme_economist()+ylim(0,20)

superados <- all.data[!is.na(all.data$Correccion.Semana),]
superados$superacion.Semana <- superados$superacion/7

ggplot(superados, aes(x=Objetivo,y=superacion.Semana))+geom_boxplot(notch=T)+geom_jitter(aes(color=curso))+theme_economist()+ylim(0,4)

ggplot(all.data, aes(x=Objetivo,y=Correccion.Semana))+geom_boxplot(notch=T)+geom_jitter(aes(color=curso))+theme_economist()+ylim(0,20)

objetivo.5 <- all.data[ all.data$Max.Objetivo == 5,]
p <- c(.5,.75)
objetivo.5 %>% group_by(Objetivo) %>% dplyr::summarize(porcentaje=scales::percent(p),entregas = quantile(entrega.Dias,p))

objetivo.6 <- all.data[ all.data$Max.Objetivo == 6,]
objetivo.6 %>% group_by(Objetivo) %>% dplyr::summarize(porcentaje=scales::percent(p),entregas = quantile(entrega.Dias,p))

objetivo.7 <- all.data[ all.data$Max.Objetivo == 7,]
objetivo.7 %>% group_by(Objetivo) %>% dplyr::summarize(porcentaje=scales::percent(p),entregas = quantile(entrega.Dias,p))
