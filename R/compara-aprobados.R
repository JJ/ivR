library(ggplot2)
load("data/entregas-data.rda")

ggplot(entregas.data, aes(x=Aprobado, y=Days.to.Superacion))+geom_boxplot(notch=TRUE)+ylab("Días hasta superación")+xlab("Aprobado")+ggtitle("Días hasta superación en función de si se aprobó o no")
