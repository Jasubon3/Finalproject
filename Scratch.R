#### Indian Weather Repo

library(readr)
#IndianWeatherRepository <- read_csv("./source_data/IndianWeatherRepository.csv")
library(readr)
IndianWeatherRepository <- read_csv("my_project/source_data/IndianWeatherRepository.csv")

IndianWeather <- IndianWeatherRepository

# Temperature trend
library(ggplot2)

ggplot(IndianWeather, aes(x = last_updated, y = temperature_celsius)) +
  geom_line() +
  labs(title = "Temperature Trends over Time", x = "Date", y = "Temperature (°C)")
ggsave("Figures/temp_trend.png")

# Weather Conditions
library(ggplot2)
ggplot(IndianWeather, aes(x = condition_text)) +
  geom_bar() +
  coord_flip() +
  labs(title = "Weather Conditions", x = "Count", y = "Condition")
ggsave("Figures/Weather_cond.png")

library(ggplot2)

# You might need to adjust the size scaling factor (size = ...) based on your data
ggplot(IndianWeather, aes(x = location_name, y = region, size = condition_text)) +
  geom_point(alpha = 0.6) +
  labs(title = "Bubble Plot of Location, Region, and Condition") +
  theme_minimal()




# Detecting Outliers
z_scores_temperature <- scale(IndianWeather$temperature_fahrenheit)
  # Define the threshold
threshold <- 2
outliers_temperature <- which(abs(z_scores_temperature) > threshold)
outliers_data <- IndianWeather[outliers_temperature, ]


library(ggplot2)

ggplot(data = IndianWeather, aes(x = longitude, y = latitude, color = temperature_celsius)) +
  geom_point() +
  scale_color_gradient(low = "blue", high = "red", name = "Temperature (Celsius)") +
  labs(title = "Temperature Variation by Location in India")
ggsave("Figures/Temp_Variation.png")

# Principal Component Analysis
selected_variables <- IndianWeather[, c("temperature_celsius", "humidity", "wind_mph")]
scaled_data <- scale(selected_variables) 

pca_result <- princomp(scaled_data)
# View the loadings for the first two principal components
loadings(pca_result)[, 1:2]

# Extract PC scores
pc_scores <- pca_result$scores


# Clustering
num_clusters <- 3
kmeans_result <- kmeans(scaled_data, centers = num_clusters)

cluster_assignments <- kmeans_result$cluster
table(cluster_assignments)


# Assuming PC1 and PC2 are the first two principal components
plot(pc_scores[, 1], pc_scores[, 2], 
     col = cluster_assignments, pch = 16,
     xlab = "Principal Component 1", ylab = "Principal Component 2",
     main = "Clustered Data (PC1 vs. PC2)")
legend("topright", legend = unique(cluster_assignments), col = 1:length(unique(cluster_assignments)), pch = 16)
ggsave("Figures/Clustered_Data.png")




#Hierarchical Clustering
hc_result <- hclust(dist(scaled_data, method = "euclidean"), method = "complete")
plot(hc_result, main = "Dendrogram for Hierarchical Clustering", xlab = "Index", ylab = "Distance")
cluster_assignments <- cutree(hc_result, k = num_clusters)
ggsave("Figures/Hierarchical_Clustering.png")

# Assuming your scaled data is named scaled_data
library(dbscan)
dbscan_result <- dbscan(scaled_data, eps = 0.5, minPts = 5)

# Create a data frame with cluster assignments and the scaled data
clustered_data <- data.frame(scaled_data, Cluster = as.factor(dbscan_result$cluster))

# Plotting the clusters
ggplot(clustered_data, aes(x = temperature_celsius, y = humidity, color = Cluster)) +
  geom_point() +
  labs(title = "DBSCAN Clustering Result") +
  theme_minimal()
ggsave("Figures/DBSCAN_clustering.png")





# Correlation..............
relevant_data <- IndianWeather[, c("wind_mph", "humidity", "sunrise")]

# Convert time of sunrise to numeric format (e.g., minutes since midnight)
relevant_data$sunrise_numeric <- as.numeric(relevant_data$sunrise)
# Selecting relevant columns for correlation
relevant_columns <- relevant_data[c("wind_mph", "humidity", "sunrise_numeric")]

# Calculating correlation matrix
correlation_matrix <- cor(relevant_columns)



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
#.................................


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


# TSNE

library(Rtsne)
# Remove duplicate rows
IndianWeather_unique <- unique(IndianWeather_subset)
# Run t-SNE on the unique dataset
tsne_result <- Rtsne(IndianWeather_unique, dims = 2, perplexity = 30, verbose = TRUE)
tsne_df <- as.data.frame(tsne_result$Y)

ggplot(tsne_df, aes(x = V1, y = V2)) +
  geom_point() +
  labs(title = "t-SNE Plot") +
  theme_minimal()
ggsave("Figures/t-SNE.png")
#.............


# Supervised Learning

# Split data
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













