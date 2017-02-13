source("../../src/r/pca.r")

kmeans_func <- function(data,num_clusters){
  fit <- kmeans(data,num_clusters)
  cluster <- as.data.frame(fit$cluster)
  cluster$sse <- fit$tot.withinss
  return(cluster)
}

sse <- function(data){
  res <- data.frame(cluster_size = numeric(), sse = numeric())
  for (i in 2:20){
    temp <- kmeans_func(data,i)
    res[i-1,] = c(i,temp[1,]$sse)
  }
  return(res)
}

movie.kmeans.sse <- sse(movie.pc.data)
country.kmeans.sse <- sse(country.pc.data)

# plot(movie.kmeans.sse, type = 'b')
# plot(country.kmeans.sse, type = 'b')

movie.kmeans.clusters <- kmeans_func(movie.pc.data, 8)
movie.kmeans.clusters <- rownames_to_column(movie.kmeans.clusters, var = "title")

country.kmeans.clusters <- kmeans_func(country.pc.data, 4)
country.kmeans.clusters <- rownames_to_column(country.kmeans.clusters, var = "country")


# write.csv(movie.kmeans.clusters, file = "../../output/data/movie.kmeans.clusters.csv")
# write.csv(country.kmeans.clusters, file = "../../output/data/country.kmeans.clusters.csv")
