library(readr)
IndianWeatherRepository <- read_csv("./source_data/IndianWeatherRepository.csv")
IndianWeather <- IndianWeatherRepository

# Correlation Heatmap...........
# Assuming correlation_matrix contains the correlation values
library(ggplot2)
library(reshape2)
correlation_matrix <- data.frame(
  wind_mph = c(1.00000000, -0.01813135, 0.24702198),
  humidity = c(-0.01813135, 1.00000000, -0.42345699),
  sunrise_numeric = c(0.247022, -0.423457, 1.000000)
)

# Redefine the melted matrix with variable names specified
melted_matrix <- melt(correlation_matrix)

ggplot(melted_matrix, aes(x = variable, y = variable, fill = value)) +
  geom_tile() +
  scale_fill_gradient(low = "blue", high = "red") +
  labs(title = "Correlation Heatmap") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
ggsave("Figures/Correlation_Heatmap.png")