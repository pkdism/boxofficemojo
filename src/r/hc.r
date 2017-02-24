source("../../src/r/pca.r")

movie.score.matrix <- as.data.frame(movie.score.matrix)
movie.score.matrix.scale <- scale(movie.score.matrix, center = TRUE, scale = TRUE)
movie.score.matrix.dist <- dist(movie.score.matrix.scale, method = "euclidean", diag = FALSE, upper = FALSE, p = 2)
movie.score.matrix.hclust <- hclust(movie.score.matrix.dist, method = "ward.D2")
movie.score.matrix <- rownames_to_column(movie.score.matrix, var = "title")
 plot(movie.score.matrix.hclust, hang = -1, cex = 1.2, labels = movie.score.matrix$title)
movie.score.matrix.hclust.clusters <- data.frame(cutree(movie.score.matrix.hclust,8))
movie.score.matrix.hclust.clusters <- rownames_to_column(movie.score.matrix.hclust.clusters, var = "title")
names(movie.score.matrix.hclust.clusters) = c("title", "cluster")
# write.csv(movie.score.matrix.hclust.clusters, file = "../../output/data/movie.hclust.clusters.csv")


country.score.matrix <- as.data.frame(country.score.matrix)
country.score.matrix.scale <- scale(country.score.matrix, center = TRUE, scale = TRUE)
country.score.matrix.dist <- dist(country.score.matrix.scale, method = "euclidean", diag = FALSE, upper = FALSE, p = 2)
country.score.matrix.hclust <- hclust(country.score.matrix.dist, method = "ward.D2")
country.score.matrix <- rownames_to_column(country.score.matrix, var = "country")
 plot(country.score.matrix.hclust, hang = -1, cex = 1.2, labels = country.score.matrix$country)
country.score.matrix.hclust.clusters <- data.frame(cutree(country.score.matrix.hclust,4))
country.score.matrix.hclust.clusters <- rownames_to_column(country.score.matrix.hclust.clusters, var = "country")
names(country.score.matrix.hclust.clusters) = c("country", "cluster")
# write.csv(country.score.matrix.hclust.clusters, file = "../../output/data/country.hclust.clusters.csv")
