library(ggplot2)
load("data/entregas-data.rda")

ggplot(entregas.data, aes(x=Aprobado, y=Days.to.Superacion))+geom_boxplot(notch=TRUE)+ylab("Días hasta superación")+xlab("Aprobado")+ggtitle("Días hasta superación en función de si se aprobó o no")
entregas.data$Objetivo <- as.factor(entregas.data$Objetivo)
ggplot(entregas.data, aes(x=Objetivo, y=Days.to.Superacion, fill=Curso))+geom_boxplot(notch=TRUE)+ylab("Días hasta superación")+xlab("Objetivo")+ggtitle("Días hasta superación en función del objetivo")
