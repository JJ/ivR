library(ggplot2)
library(dplyr)

objective.versions <- read.csv("data-raw/objetivos-versiones.csv")
objective.versions$user <- as.factor(objective.versions$user)
objective.versions$objective <- as.factor(objective.versions$objective)

ggplot(objective.versions,aes(x=user,y=version))+geom_violin()

ggplot(objective.versions, aes(x=objective, y=version)) + geom_violin() + theme_economist()
