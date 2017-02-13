source("../../src/r/main.r")
library(reshape2)
get_data <- function(pc){
  x <- summary(pc)
  vars <- x$sdev^2
  vars <- vars/sum(vars)
  temp <- data.frame(rbind("SD" = x$sdev, "POV" = vars,
                           "CP" = cumsum(vars)))
  i = 1
  for(i in 1:ncol(temp)){
    if(temp["CP", i] >= 0.85) break
  }
  
  data <- data.frame(pc$x[,1:i])
  data = data[1:nrow(data),]
  return(data)
}

movie.score.matrix <- acast(movie.country.score, title~country, value.var = "gross.score")
movie.score.matrix[is.na(movie.score.matrix)] = 0

country.score.matrix <- acast(movie.country.score, country~title, value.var = "gross.score")
country.score.matrix[is.na(country.score.matrix)] = 0


movie.pc <- prcomp(movie.score.matrix, center = TRUE, scale = TRUE)
country.pc <- prcomp(country.score.matrix, center = TRUE, scale = TRUE)


movie.pc.data <- get_data(movie.pc)

country.pc.data <- get_data(country.pc)
