library(dplyr)
library(ggplot2)
library(ggthemes)

drop.data <- function(entregas){
  entregas %>% group_by(Estudiante) %>% dplyr::filter( Max.Objetivo == Objetivo) %>% dplyr::summarize(Max.Objetivo=Max.Objetivo,Entrega.Semana = Entrega.Semana) -> objetivo.semana
  return(objetivo.semana)
}

load("data/entregas-21-22.rda")
drop.data.21.22 <- drop.data(date.data)
load("data/entregas-22-23.rda")
drop.data.22.23 <- drop.data(date.data)
load("data/entregas-23-24.rda")
drop.data.23.24 <- drop.data(date.data)

objetivo.semana <- as_tibble(rbind(drop.data.21.22,drop.data.22.23,drop.data.23.24))
objetivo.semana$Estudiante <- NULL

ggplot(objetivo.semana, aes(x=Max.Objetivo,y=Entrega.Semana))+geom_point()+theme_economist()+ylim(0,20)
