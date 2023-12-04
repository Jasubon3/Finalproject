library(readr)
IndianWeatherRepository <- read_csv("./source_data/IndianWeatherRepository.csv")
IndianWeather <- IndianWeatherRepository

library(ggplot2)
# Boxplot for temperature distribution by region
ggplot(IndianWeather, aes(x = region, y = temperature_celsius)) +
  geom_boxplot() +
  labs(title = "Temperature Distribution by Region") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  ylab("Temperature (Celsius)")
ggsave("Figures/Temp_distribution_region.png")

library(ggplot2)
# Scatter plot of temperature vs. humidity, colored by region
ggplot(IndianWeather, aes(x = temperature_celsius, y = humidity, color = region)) +
  geom_point() +
  labs(title = "Temperature vs. Humidity by Region") +
  xlab("Temperature (Celsius)") +
  ylab("Humidity") +
  theme_minimal()
ggsave("Figures/Temp_vs_Humidity_by_region.png")

