library(readr)
IndianWeatherRepository <- read_csv("./source_data/IndianWeatherRepository.csv")
IndianWeather <- IndianWeatherRepository


# Temperature trend
library(ggplot2)
ggplot(IndianWeather, aes(x = last_updated, y = temperature_celsius)) +
  geom_line() +
  labs(title = "Temperature Trends over Time", x = "Date", y = "Temperature (°C)")
ggsave("Figures/temp_trend.png")



library(ggplot2)
ggplot(data = IndianWeather, aes(x = longitude, y = latitude, color = temperature_celsius)) +
  geom_point() +
  scale_color_gradient(low = "blue", high = "red", name = "Temperature (Celsius)") +
  labs(title = "Temperature Variation by Location in India")
ggsave("Figures/Temp_Variation.png")