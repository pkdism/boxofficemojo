library("mclust")
library("tibble")
source("../../src/r/main.r")
source("../../src/r/pca.r")

gmm <- function(data, num_clusters, label){
  gmm <- Mclust(data, G = num_clusters)
  gmm.clusters <- as.data.frame(gmm$classification)
  gmm.clusters <- tibble::rownames_to_column(gmm.clusters, var = label)
  return(gmm.clusters)
}

movie.gmm.clusters <- gmm(movie.pc.data, 10, "title")
country.gmm.clusters <- gmm(country.pc.data, 4, "country")

# write.csv(movie.gmm.clusters, file = "../../output/data/movie.gmm.clusters.csv")
# write.csv(country.gmm.clusters, file = "../../output/data/country.gmm.clusters.csv")
