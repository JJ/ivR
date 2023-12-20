library(ggplot2)
library(ggthemes)
load("data/tabla-dias-entregas.rda")

tabla.dias.entregas$porcentaje <- as.numeric(gsub("%", "", tabla.dias.entregas$porcentaje))
tabla.dias.entregas$Objetivo <- as.factor(tabla.dias.entregas$Objetivo)
ggplot(tabla.dias.entregas, aes(x=porcentaje, y=entregas,group=Objetivo, color=Objetivo))+geom_line()+geom_point()+ylab("Día de entrega")+scale_x_continuous(name="Porcentaje",breaks=c(25,50,75,90,100),labels=c("25%","50%","75%","90%","100%"))+theme_economist()+ggtitle("Día de entrega en función del objetivo")

