library("Rtsne")

# source("../../src/r/kmeans.r")
source("../../src/r/gmm.r")

movie.rtsne <- Rtsne(movie.pc.data, dims = 2, initial_dims = 23, perplexity = 30,
                     theta = 0.5, check_duplicates = FALSE, pca = TRUE, max_iter = 1000,
                     verbose = FALSE, is_distance = FALSE, Y_init = NULL)

movie.rtsne.res <- as.data.frame(movie.rtsne$Y)
movie.rtsne.res$title <- movie.gmm.clusters$title
movie.rtsne.res$cluster <- movie.gmm.clusters$`gmm$classification`

scatterD3(data = movie.rtsne.res, x = V1, y = V2, lab = title, col_var = cluster)

country.rtsne <- Rtsne(country.pc.data, dims = 2, initial_dims = 23, perplexity = 5,
                       theta = 0.5, check_duplicates = FALSE, pca = TRUE, max_iter = 1000,
                       verbose = FALSE, is_distance = FALSE, Y_init = NULL)

country.rtsne.res <- as.data.frame(country.rtsne$Y)
country.rtsne.res$country <- country.gmm.clusters$country
country.rtsne.res$cluster <- country.gmm.clusters$`gmm$classification`

scatterD3(data = country.rtsne.res, x = V1, y = V2, lab = country, col_var = cluster)
