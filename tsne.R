library(readr)
IndianWeatherRepository <- read_csv("./source_data/IndianWeatherRepository.csv")
IndianWeather <- IndianWeatherRepository

# TSNE
library(Rtsne)
library(dplyr)
IndianWeather_subset <- IndianWeather %>%
  mutate(sunrise_seconds = as.numeric(IndianWeather$sunrise)) %>%
  select(wind_mph, humidity, sunrise_seconds)
# Remove duplicate rows
IndianWeather_unique <- unique(IndianWeather_subset)
# Run t-SNE on the unique dataset
tsne_result <- Rtsne(IndianWeather_unique, dims = 2, perplexity = 30, verbose = TRUE)
tsne_df <- as.data.frame(tsne_result$Y)

library(ggplot2)
ggplot(tsne_df, aes(x = V1, y = V2)) +
  geom_point() +
  labs(title = "t-SNE Plot") +
  theme_minimal()
ggsave("Figures/t-SNE.png")