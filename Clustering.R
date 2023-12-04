library(readr)
IndianWeatherRepository <- read_csv("./source_data/IndianWeatherRepository.csv")
IndianWeather <- IndianWeatherRepository

#Hierarchical Clustering
selected_variables <- IndianWeather[, c("temperature_celsius", "humidity", "wind_mph")]
scaled_data <- scale(selected_variables) 
num_clusters <- 3
kmeans_result <- kmeans(scaled_data, centers = num_clusters)
cluster_assignments <- kmeans_result$cluster
table(cluster_assignments)
library(ggplot2)
pdf("Figures/Hierarchical_Clustering.pdf", width = 7, height = 7)
hc_result <- hclust(dist(scaled_data, method = "euclidean"), method = "complete")
plot(hc_result, main = "Dendrogram for Hierarchical Clustering", xlab = "Index", ylab = "Distance")
cluster_assignments <- cutree(hc_result, k = num_clusters)
ggsave("Figures/Hierarchical_Clustering.png")
dev.off()

# Assuming your scaled data is named scaled_data
library(dbscan)
dbscan_result <- dbscan(scaled_data, eps = 0.5, minPts = 5)

# Create a data frame with cluster assignments and the scaled data
clustered_data <- data.frame(scaled_data, Cluster = as.factor(dbscan_result$cluster))

# Plotting the clusters
library(ggplot2)
ggplot(clustered_data, aes(x = temperature_celsius, y = humidity, color = Cluster)) +
  geom_point() +
  labs(title = "DBSCAN Clustering Result") +
  theme_minimal()
ggsave("Figures/DBSCAN_clustering.png")