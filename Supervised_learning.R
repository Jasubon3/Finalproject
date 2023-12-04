library(readr)
IndianWeatherRepository <- read_csv("./source_data/IndianWeatherRepository.csv")
IndianWeather <- IndianWeatherRepository

library(dplyr)
IndianWeather_subset <- IndianWeather %>%
  mutate(sunrise_seconds = as.numeric(IndianWeather$sunrise)) %>%
  select(wind_mph, humidity, sunrise_seconds)
X <- IndianWeather_subset
y <- IndianWeather$temperature_celsius  # Target variable

#Train-Test split

library(caret)
set.seed(123)  # For reproducibility
trainIndex <- createDataPartition(y, p = 0.7, list = FALSE)
X_train <- X[trainIndex, ]
X_test <- X[-trainIndex, ]
y_train <- y[trainIndex]
y_test <- y[-trainIndex]

# Model selection and training
library(randomForest)
model <- randomForest(y_train ~ ., data = X_train)

# Prediction
predictions <- predict(model, newdata = X_test)


library(Metrics)
rmse_value <- rmse(predictions, y_test)

# Visualization

library(ggplot2)

# Create a data frame with actual and predicted values
data <- data.frame(Actual = y_test, Predicted = predictions)

# Plotting actual vs predicted values
ggplot(data, aes(x = Actual, y = Predicted)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1, color = "red", linetype = "dashed") +  # Adding a diagonal line for reference
  labs(title = "Actual vs Predicted of temperature", x = "Actual Values", y = "Predicted Values") +
  theme_minimal()
ggsave("Figures/Actual_vs_Predicted_temp.png")