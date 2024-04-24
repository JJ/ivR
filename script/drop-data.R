library(dplyr)
library(ggplot2)
library(ggthemes)

drop.data <- function(entregas){
  entregas %>% group_by(Estudiante) %>% dplyr::filter( Max.Objetivo == Objetivo) %>% dplyr::summarize(Max.Objetivo=Max.Objetivo,Entrega.Semana = Entrega.Semana, Curso=curso) -> objetivo.semana
  return(objetivo.semana)
}

load("data/entregas-21-22.rda")
drop.data.21.22 <- drop.data(date.data)
load("data/entregas-22-23.rda")
drop.data.22.23 <- drop.data(date.data)
load("data/entregas-23-24.rda")
drop.data.23.24 <- drop.data(date.data)

objetivo.semana <- as_tibble(rbind(drop.data.21.22,drop.data.22.23,drop.data.23.24))
objetivo.semana$Max.Objetivo <- as.factor(objetivo.semana$Max.Objetivo)
objetivo.semana$Estudiante <- NULL

ggplot(objetivo.semana, aes(x=Max.Objetivo,y=Entrega.Semana,color=Curso))+geom_jitter(width = 0.25)+theme_economist()+ylim(0,25)


objetivo.semana %>% group_by(Max.Objetivo) %>% summarise(n = n()) %>% mutate(freq = n / sum(n)) %>% mutate( accumulated.frequency = cumsum(freq)) -> drop.objetivo
ggplot(drop.objetivo, aes(x=Max.Objetivo,y=accumulated.frequency,group=0))+geom_point()+geom_line()+theme_economist()+ylim(0,1)

objetivo.semana %>% group_by(Curso,Max.Objetivo) %>% summarise(n = n()) %>% mutate(freq = n / sum(n)) %>% mutate( accumulated.frequency = cumsum(freq)) -> drop.objetivo.curso
ggplot(drop.objetivo.curso, aes(x=Max.Objetivo,y=accumulated.frequency,group=Curso, color=Curso))+geom_point()+geom_line()+theme_economist()+ylim(0,1)




