library(dplyr)
library(scales)

load("data/all-data.rda")

all.data.aprobados <- all.data %>% filter(Aprobado == T)
p <- c(.5,.75,.9,1)
all.data.aprobados %>% group_by(Objetivo) %>% summarize(porcentaje=scales::percent(p),entrega.semana = quantile(Entrega.Semana,p)) -> tabla.dias.entregas

for(i in 1:15){
  print(paste("Semana", i))
  print( tabla.dias.entregas %>% filter(entrega.semana <= i & entrega.semana >= i-1) )

}

all.data.aprobados %>% group_by(Objetivo) %>% summarize(porcentaje=scales::percent(p),correccion.semana = quantile(Correccion.Semana,p,na.rm=T)) -> tabla.dias.correccion

for(i in 1:15){
  print(paste("Semana", i))
  print( tabla.dias.correccion %>% filter(correccion.semana <= i & correccion.semana >= i-1) )

}

library(ggplot2)
library(ggthemes)
ggplot(all.data[all.data$Objetivo==0,], aes(x=Correccion.Semana,y=Max.Objetivo))+geom_point()+geom_smooth(method="lm")+theme_economist()+ylab("Objetivo")+xlab("Entrega Semana")+ggtitle("Objetivo en función de la entrega")+xlim(0,6)

