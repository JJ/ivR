library(tibble)

data.2122 <- read.csv("data-raw/fechas-entrega-2021-22.csv",sep=";")
data.2122$Curso <- "21-22"
data.2223 <- read.csv("data-raw/fechas-entrega-2022-23.csv",sep=";")
data.2223$Curso <- "22-23"

entregas.data <- rbind( data.2122,data.2223)

entregas.data <- entregas.data[ entregas.data$Incompleto == "Completo",]
entregas.data <- entregas.data[ entregas.data$Correccion != "",]
entregas.data$Incompleto <- NULL

entregas.data$dow.entrega <- as.factor(weekdays(as.Date(entregas.data$Entrega)))
entregas.data$dow.correccion <- as.factor(weekdays(as.Date(entregas.data$Correccion)))
entregas.data$dow.entrega <- ordered( entregas.data$dow.entrega, levels=c("lunes","martes","miércoles","jueves","viernes","sábado","domingo"))
entregas.data$dow.correccion <- ordered( entregas.data$dow.correccion, levels=c("lunes","martes","miércoles","jueves","viernes","sábado","domingo"))

ggplot(entregas.data, aes(x=dow.entrega, fill=Curso)) + geom_bar() + labs(title="Distribución de entregas por día de la semana", x="Día de la semana", y="Número de entregas", fill="Curso") + theme_bw() + theme(plot.title = element_text(hjust = 0.5))
ggplot(entregas.data, aes(x=dow.correccion, fill=Curso)) + geom_bar() + labs(title="Distribución de correcciones por día de la semana", x="Día de la semana", y="Número de correcciones", fill="Curso") + theme_bw() + theme(plot.title = element_text(hjust = 0.5))
