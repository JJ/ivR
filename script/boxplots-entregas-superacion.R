#!/usr/bin/env Rscript


library(ggplot2)
library(ggthemes)
library(dplyr)

load("data/all-data.rda")

all.data %>% group_by(curso,Objetivo) %>% mutate(number.of.observations=n()) -> all.data

ggplot(all.data[ all.data$Objetivo == 0,], aes(x=curso,y=entrega.Dias,fill=number.of.observations))+geom_boxplot(notch=T)+ylim(0,30)
ggplot(all.data[ all.data$Objetivo == 0,], aes(x=curso,y=Correccion.Dias))+geom_boxplot(notch=T)+ylim(0,30)

ggplot(all.data[ all.data$Objetivo == 1,], aes(x=curso,y=entrega.Dias,fill=number.of.observations))+geom_boxplot(notch=T)+ylim(0,30)
ggplot(all.data[ all.data$Objetivo == 1,], aes(x=curso,y=Correccion.Dias))+geom_boxplot(notch=T)+ylim(0,30)

ggplot(all.data[ all.data$Objetivo == 2,], aes(x=curso,y=entrega.Dias,fill=number.of.observations))+geom_boxplot(notch=T)
ggplot(all.data[ all.data$Objetivo == 2,], aes(x=curso,y=Correccion.Dias))+geom_boxplot(notch=T)

ggplot(all.data[ all.data$Objetivo == 3,], aes(x=curso,y=entrega.Dias,fill=number.of.observations))+geom_boxplot(notch=T)
ggplot(all.data[ all.data$Objetivo == 3,], aes(x=curso,y=Correccion.Dias))+geom_boxplot(notch=T)
