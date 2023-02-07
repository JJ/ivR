
library(ggplot2)
data <- read.csv("data-raw/drop-objetivos.csv")

ggplot(data,aes(x=X,y=X2223.No.superados,group="2223"))+geom_line(colour='blue')+geom_line(data=data,aes(x=X,y=X2122.No.superados,group="2122"),colour='pink')
