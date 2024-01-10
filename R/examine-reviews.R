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

all.reviews.df <- all.reviews.df[ all.reviews.df$name != "JJ" & all.reviews.df$name !="Gdakgdak22",]

all.reviews.df$notaReviews <- ifelse(all.reviews.df$numberOfReviews > 14, 2, all.reviews.df$numberOfReviews/7)

write( toJSON(all.reviews.df), file="../reviews-con-nota.json")

