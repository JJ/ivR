
library(ggplot2)
data <- read.csv("data-raw/drop-objetivos.csv")

ggplot(data,aes(x=X,y=X2223.estudiantes,group="2223"))+geom_line(colour='blue')+geom_point()+geom_line(data=data,aes(x=X,y=X2122.estudiantes,group="2122"),colour='pink')+geom_point(data=data,aes(x=X,y=X2122.estudiantes,group="2122")
ggplot(data,aes(x=X,y=X2223.No.superados,group="2223"))+geom_line(colour='blue')+geom_line(data=data,aes(x=X,y=X2122.No.superados,group="2122"),colour='pink')
ggplot(data,aes(x=X,y=X2223.No.entregados,group="2223"))+geom_line(colour='blue')+geom_line(data=data,aes(x=X,y=X2122.No.entregados,group="2122"),colour='pink')

