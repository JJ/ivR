#!/usr/bin/env Rscript

library(tidyverse)
library(ggplot2)

load("data/all-data.rda")

ggplot(all.data[all.data$Objetivo == 3,], aes(x=curso,y=superacion))+geom_boxplot(notch=T)+ylim(0,30)
