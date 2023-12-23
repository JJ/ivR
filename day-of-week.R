library(tibble)
library(ggplot2)
library(parsedate)
library(dplyr)

inicio <- as_tibble( data.frame( Curso=c("21-22","22-23","23-24"),
                                 Inicio=c(as.Date("2021-09-13"),
                                          as.Date("2022-09-12"),
                                          as.Date("2023-09-11")
                                          )
                                 )
)

data.2122 <- read.csv("data-raw/fechas-entrega-2021-22.csv",sep=";")
data.2122$Curso <- "21-22"
data.2223 <- read.csv("data-raw/fechas-entrega-2022-23.csv",sep=";")
data.2223$Curso <- "22-23"
data.2324 <- read.csv("../IV-/data/fechas-entrega.csv",sep=";")
data.2324$Curso <- "23-24"

entregas.data <- rbind( data.2122,data.2223,data.2324)

entregas.data <- entregas.data[ entregas.data$Incompleto == "Completo",]
entregas.data <- entregas.data[ entregas.data$Correccion != "",]
entregas.data$Incompleto <- NULL

entregas.data$dow.entrega <- as.factor(weekdays(as.Date(entregas.data$Entrega)))
entregas.data$dow.correccion <- as.factor(weekdays(as.Date(entregas.data$Correccion)))
entregas.data$dow.entrega <- ordered( entregas.data$dow.entrega, levels=c("lunes","martes","miércoles","jueves","viernes","sábado","domingo"))
entregas.data$dow.correccion <- ordered( entregas.data$dow.correccion, levels=c("lunes","martes","miércoles","jueves","viernes","sábado","domingo"))

entregas.data <- entregas.data %>% left_join(inicio, by="Curso")

entregas.data$Entrega.Days  <- as.Date(entregas.data$Entrega) - as.Date(entregas.data$Inicio)
entregas.data$Entrega.Week <- as.integer(entregas.data$Entrega.Days/7) +1


ggplot(entregas.data, aes(x=dow.entrega, fill=Curso)) + geom_bar() + labs(title="Distribución de entregas por día de la semana", x="Día de la semana", y="Número de entregas", fill="Curso") + theme_bw() + theme(plot.title = element_text(hjust = 0.5))
ggplot(entregas.data, aes(x=dow.correccion, fill=Curso)) + geom_bar() + labs(title="Distribución de correcciones por día de la semana", x="Día de la semana", y="Número de correcciones", fill="Curso") + theme_bw() + theme(plot.title = element_text(hjust = 0.5))

ggplot(entregas.data[ entregas.data$Curso == "23-24",], aes(x=dow.entrega ) )+ geom_bar() + labs(title="Distribución de entregas por día de la semana", x="Día de la semana", y="Número de entregas", fill="Curso") + theme_bw() + theme(plot.title = element_text(hjust = 0.5))

ggplot(entregas.data[ entregas.data$Curso == "23-24",], aes(x=dow.correccion ) )+ geom_bar() + labs(title="Distribución de superaciones por día de la semana", x="Día de la semana", y="Número de superaciones de objetivo", fill="Curso") + theme_bw() + theme(plot.title = element_text(hjust = 0.5))
