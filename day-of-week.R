library(tibble)

data.2122 <- read.csv("data-raw/fechas-entrega-2021-22.csv",sep=";")
data.2122$Curso <- "21-22"
data.2223 <- read.csv("data-raw/fechas-entrega-2022-23.csv",sep=";")
data.2223$Curso <- "22-23"

# concatenate data.2122 and data.2223
entregas.data <- rbind( data.2122,data.2223)

entregas.data <- entregas.data[ entregas.data$Incompleto == "Completo",]
entregas.data <- entregas.data[ entregas.data$Correccion != "",]
entregas.data$Incompleto <- NULL

# Create a new column that contains the day of the week equivalent to entregas.data$Correccion
entregas.data$dow.entrega <- as.factor(weekdays(as.Date(entregas.data$Entrega)))
entregas.data$dow.correccion <- as.factor(weekdays(as.Date(entregas.data$Correccion)))

