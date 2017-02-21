source("../../src/r/main.r")

genre <- read.csv("../../data/genre_2016.tsv", sep = '\t', header = TRUE, quote = "")


movie.country.score.genre <- merge(movie.country.score, genre, by = "title", all.x = TRUE)

movie.country.score.genre <- left_join(movie.country.score.genre, total.gross.title, by = "title")

movie.country.score.genre <- left_join(movie.country.score.genre, total.gross.country, by = "country")

# write.csv(movie.country.score.genre, file = "../../output/data/movie.country.score.genre.csv")
# write.csv(movie.stats, file = "../../output/data/movie.stats.csv")
# write.csv(total.gross.country, file = "../../output/data/total.gross.country.csv")
# write.csv(total.gross.title, file = "../../output/data/total.gross.title.csv")

