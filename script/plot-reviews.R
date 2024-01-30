library(jsonlite)
library(ggplot2)

reviews <- fromJSON("../reviews.json")

reviews$JJ <- NULL
reviews.df <- data.frame( name=names(reviews), reviews=unlist(reviews) )

ggplot(reviews.df, aes(x=reviews)) +  geom_histogram(binwidth=5) +
  ggtitle("Histogram of Reviews") + xlab("Number of Reviews") + ylab("Number of Apps")

