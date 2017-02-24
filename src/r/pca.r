source("../../src/r/main.r")
library(reshape2)
library("tidyr")
get_data <- function(pc){
  x <- summary(pc)
  vars <- x$sdev^2
  vars <- vars/sum(vars)
  temp <- data.frame(rbind("SD" = x$sdev, "POV" = vars,
                           "CP" = cumsum(vars)))
  i = 1
  for(i in 1:ncol(temp)){
    if(temp["CP", i] >= 0.90) break
  }
  
  data <- data.frame(pc$x[,1:i])
  data = data[1:nrow(data),]
  return(data)
}

movie.score.matrix <- spread(movie.country.score,country,gross.score)
movie.score.matrix[is.na(movie.score.matrix)] = 0
rownames(movie.score.matrix) <- movie.score.matrix[,1]
movie.score.matrix <- movie.score.matrix[,-1]

country.score.matrix <- spread(movie.country.score,title, gross.score)
country.score.matrix[is.na(country.score.matrix)] = 0
rownames(country.score.matrix) <- country.score.matrix[,1]
country.score.matrix <- country.score.matrix[,-1]


movie.pc <- prcomp(movie.score.matrix, center = TRUE, scale = TRUE)
country.pc <- prcomp(country.score.matrix, center = TRUE, scale = TRUE)


movie.pc.data <- get_data(movie.pc)

country.pc.data <- get_data(country.pc)
write.csv(movie.pc.data, file = "../../output/data/movie.pc.data.csv")
write.csv(country.pc.data, file = "../../output/data/country.pc.data.csv")

