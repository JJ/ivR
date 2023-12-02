
library(ggplot2)

data.21.22 <- read.csv("data-raw/drop-objetivos-21-22.csv",header=F,sep=";")
data.22.23 <- read.csv("data-raw/drop-objetivos-22-23.csv",header=F,sep=";")
data.23.24 <- read.csv("data-raw/drop-objetivos-23-24.csv",header=F,sep=";")
#
ggplot(data.21.22,aes(x=V1,y=V3,group=1,color="21-22"))+geom_line()+geom_line(data=data.22.23,aes(x=V1,y=V3,group=2,color="22-23"))+geom_line(data=data.23.24,aes(x=V1,y=V3,group=2,color="23-24"))

