source("../../src/r/main.r")

genre <- read.csv("../../data/movie_genre.tsv", sep = '\t', header = FALSE, quote = "")

names(genre) <- c("title", "genre")
genre <- right_join(genre, movie.country.score, by = "title")
