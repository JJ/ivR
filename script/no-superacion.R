library(dplyr)
library(ggplot2)
library(ggthemes)

superacion.tasa <- function(entregas){
  entregas %>% group_by(Objetivo) %>% summarize(n = n(), no.superados=sum(is.na(superacion)), tasa.superacion = 1-no.superados/n ) -> tasa.superacion
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

ggplot(tasas.curso, aes(x=Objetivo,y=no.superados, color=Curso,group=Curso))+geom_point()+geom_line()+theme_economist()

# compute autocorrelation of no.superados for every Curso

tasas.curso %>% group_by(Curso) %>% do(data.frame(acf=acf(.$no.superados,plot=FALSE)$acf[2])) %>% ungroup() -> acf.curso.lag1
tasas.curso %>% group_by(Curso) %>% do(data.frame(acf=acf(.$no.superados,plot=FALSE)$acf[3])) %>% ungroup() -> acf.curso.lag2
tasas.curso %>% group_by(Curso) %>% do(data.frame(acf=acf(.$no.superados,plot=FALSE)$acf[4])) %>% ungroup() -> acf.curso.lag3
