library(rjson)
library(dplyr)
reviews <- fromJSON(file="../reviews.json")
reviewedPRs <- fromJSON(file="../reviewed-prs.json")

reviews.df <- data.frame( unlist(reviews))

all.reviews.df <- data.frame( name = character(),
                             numberOfReviews = numeric(),
                             numberOfPrs = numeric())

for (nick in names(reviews)) {
  all.reviews.df <- rbind(all.reviews.df, data.frame(name=nick,
                                                     numberOfReviews=reviews[[nick]],
                                                     numberOfPrs=length(reviewedPRs[[nick]])))
}



