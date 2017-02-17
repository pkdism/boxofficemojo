source("../../src/r/main.r")

genre <- read.csv("../../data/genre_2016.tsv", sep = '\t', header = TRUE, quote = "")


movie.country.score.genre <- merge(movie.country.score, genre, by = "title", all.x = TRUE)

movie.country.score.genre <- left_join(movie.country.score.genre, total.gross.title, by = "title")

movie.country.score.genre <- left_join(movie.country.score.genre, total.gross.country, by = "country")

write.table(movie.country.score.genre, file = "../../output/data/main_data.tsv")
