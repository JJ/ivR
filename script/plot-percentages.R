#!/usr/bin/env Rscript

library(tidyverse)
library(ggplot2)

load("data/circunstancias.rda")

circunstancias %>% group_by(Curso,aprobado,AsignaturasAtrasadas) %>% summarise(n = n()) %>%
  mutate(freq = n / sum(n))

circunstancias %>% group_by(Curso,AsignaturasAtrasadas,aprobado) %>% summarise(n = n()) %>%
  mutate(freq = n / sum(n))

asignaturas.atrasadas.aprobado <- circunstancias %>% group_by(Curso, AsignaturasAtrasadas,aprobado) %>% summarise(n = n()) %>%
  mutate(freq = n / sum(n))

ggplot(asignaturas.atrasadas.aprobado,aes(x=Curso,y=freq, fill=AsignaturasAtrasadas, color=aprobado))+geom_bar(stat="identity")

circunstancias %>% group_by(Curso,aprobado, NoAsistencia) %>% summarise(n = n()) %>%
  mutate(freq = n / sum(n))

circunstancias %>% group_by(Curso,aprobado, Trabajando) %>% summarise(n = n()) %>%
  mutate(freq = n / sum(n))

circunstancias %>% group_by(Curso,aprobado, Num) %>% summarise(n = n()) %>%
  mutate(freq = n / sum(n))

circunstancias %>% group_by(Curso, Num, aprobado) %>% summarise(n = n()) %>%
  mutate(freq = n / sum(n))

circunstancias %>% group_by(Curso, aprobado, Num) %>% summarise(n = n()) %>%
  mutate(freq = n / sum(n))


circunstancias %>% group_by(Curso, Num, aprobado) %>% summarise(n = n()) %>%
  mutate(freq = n / sum(n))

circunstancias %>% group_by(Curso, ConocimientosPrevios, aprobado) %>% summarise(n = n()) %>%
  mutate(freq = n / sum(n))


circunstancias %>% group_by(Curso, AsignaturasExigentes, aprobado) %>% summarise(n = n()) %>%
  mutate(freq = n / sum(n))

circunstancias %>% group_by(aprobado, Num) %>% summarise(n = n()) %>%
  mutate(freq = n / sum(n))

circunstancias %>% group_by(Curso, Num) %>% summarise(n = n()) %>%
  mutate(freq = n / sum(n))

asignaturas.atrasadas <- circunstancias %>% group_by(Curso, AsignaturasAtrasadas) %>% summarise(n = n()) %>%
  mutate(freq = n / sum(n))

ggplot(asignaturas.atrasadas,aes(x=Curso,y=freq, fill=AsignaturasAtrasadas))+geom_bar(stat="identity")

falta.base <- circunstancias %>% group_by(Curso, ConocimientosPrevios) %>% summarise(n = n()) %>%
  mutate(freq = n / sum(n))

ggplot(falta.base,aes(x=Curso,y=freq, fill=ConocimientosPrevios))+geom_bar(stat="identity")
