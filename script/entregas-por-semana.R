library(dplyr)
library(scales)

load("../data/all-data.rda")

all.data.aprobados <- all.data %>% filter(Aprobado == T)
p <- c(.5,.75,.9,1)
all.data.aprobados %>% group_by(Objetivo) %>% summarize(porcentaje=scales::percent(p),entrega.semana = quantile(Entrega.Semana,p)) -> tabla.dias.entregas

for(i in 1:15){
  print(paste("Semana", i))
  tabla.dias.entregas.semana <- tabla.dias.entregas %>% filter(entrega.semana <= i)

}



