library(readr)
IndianWeatherRepository <- read_csv("./source_data/IndianWeatherRepository.csv")
IndianWeather <- IndianWeatherRepository


# PCA on Humidity, Windspeed and Sunrise.......
library(dplyr)
IndianWeather_subset <- IndianWeather %>%
  mutate(sunrise_seconds = as.numeric(IndianWeather$sunrise)) %>%
  select(wind_mph, humidity, sunrise_seconds)

# Assuming 'IndianWeather_subset' contains your data
pca_result1 <- prcomp(IndianWeather_subset, scale. = TRUE)
summary(pca_result1)

library(ggplot2)
# Convert PCA result to a data frame
pca_df <- as.data.frame(pca_result1$x[, 1:2])  # Considering the first two principal components
ggplot(pca_df, aes(x = PC1, y = PC2, color = IndianWeather_subset$wind_mph)) +
  geom_point() +
  labs(title = "PCA Plot with Color") +
  theme_minimal()
ggsave("Figures/PCA_wind_hum_sunrise.png")