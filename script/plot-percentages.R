#!/usr/bin/env Rscript

library(tidyverse)
library(ggplot2)

load("data/circunstancias.rda")

circunstancias %>% group_by(Curso,aprobado,AsignaturasAtrasadas) %>% summarise(n = n()) %>%
  mutate(freq = n / sum(n))

circunstancias %>% group_by(Curso,aprobado, NoAsistencia) %>% summarise(n = n()) %>%
  mutate(freq = n / sum(n))

circunstancias %>% group_by(Curso,aprobado, Trabajando) %>% summarise(n = n()) %>%
  mutate(freq = n / sum(n))
