library(dplyr)
library(ggplot2)
library(ggthemes)

superacion.tasa <- function(entregas){
  # Percentage of objectives where superacion = NA
  entregas %>% group_by(Objetivo) %>% summarize(n = n(), tasa.superacion = 1-sum(is.na(superacion))/n) -> tasa.superacion
  return(tasa.superacion)
}

load("data/entregas-21-22.rda")
tasa.21.22 <- superacion.tasa(date.data)
tasa.21.22$Curso <- "21-22"
load("data/entregas-22-23.rda")
tasa.22.23 <- superacion.tasa(date.data)
tasa.22.23$Curso <- "22-23"
load("data/entregas-23-24.rda")
tasa.23.24 <- superacion.tasa(date.data)
tasa.23.24$Curso <- "23-24"

tasas.curso <- as_tibble(rbind(tasa.21.22,tasa.22.23,tasa.23.24))
tasas.curso$Objetivo <- as.factor(tasas.curso$Objetivo)

ggplot(tasas.curso, aes(x=Objetivo,y=tasa.superacion,group=Curso, color=Curso))+geom_point()+geom_line()+theme_economist()+ylim(0,1)




