library("dplyr")
library("scatterD3")
library("ggmap")
library("mapproj")

boxofficemojo <- read.csv("../../data/europe_2016.tsv",header = TRUE, quote="", sep = "\t")

boxofficemojo$gross <- as.character(boxofficemojo$gross)
boxofficemojo$gross <- as.character(sub('\\$','',boxofficemojo$gross))
boxofficemojo$gross <- as.character(sub('\"','',boxofficemojo$gross))
boxofficemojo$gross <- as.character(sub('"','',boxofficemojo$gross))
boxofficemojo$gross <- as.character(sub(',','',boxofficemojo$gross))
boxofficemojo$gross <- as.character(sub(',','',boxofficemojo$gross))
boxofficemojo$gross <- as.numeric(boxofficemojo$gross)
boxofficemojo$country <- sub('"','',boxofficemojo$country)
boxofficemojo$country <- sub('"','',boxofficemojo$country)
boxofficemojo$title <- sub('"','',boxofficemojo$title)
boxofficemojo$title <- sub('"','',boxofficemojo$title)


# distributors <- boxofficemojo %>%
#   group_by(distributor) %>%
#   summarise(count = n())
# distributors <- distributors %>% filter(count > 50 & count < 700)
# boxofficemojo <- merge(boxofficemojo,distributors[,1],by = "distributor", all.y = TRUE)
total.gross.country <- boxofficemojo %>% group_by(country) %>% summarise(gross.country = sum(gross))
total.gross.title <- boxofficemojo %>% group_by(title) %>% summarise(gross.title = sum(gross))

# total.gross.title <- total.gross.title %>% filter(gross.title > 10000000)

data <- inner_join(boxofficemojo, total.gross.title, by = "title")
data <- inner_join(data, total.gross.country, by = "country")

data <- data[c("title","country", "gross", "gross.country")]

data$gross.score <-  with(data, data$gross/data$gross.country)
data <- data %>% filter(gross.score > 0.01)

movie.countrycount <- data %>% group_by(title) %>%
  summarise(count.country = n())

data <- inner_join(data,movie.countrycount, by = "title")
data <- data %>% filter(count.country > 4)

movie.country.score <- data[c("title","country","gross.score")]
movie.country.score <- movie.country.score[-1482,]
movie.stats <- movie.country.score %>% 
  group_by(title) %>%
  summarise(score.mean = mean(gross.score), score.sd = sd(gross.score))

# country.stats <- movie.country.score %>%
#   group_by(country) %>%
#   summarise(score.mean = mean(gross.score), score.sd = sd(gross.score))

# scatterD3(data = movie.stats, x = score.mean, y = score.sd, lab = title)
