library(readr)
IndianWeatherRepository <- read_csv("./source_data/IndianWeatherRepository.csv")
IndianWeather <- IndianWeatherRepository

# Principal Component Analysis
selected_variables <- IndianWeather[, c("temperature_celsius", "humidity", "wind_mph")]
scaled_data <- scale(selected_variables) 
pca_result <- princomp(scaled_data)

# View the loadings for the first two principal components
loadings(pca_result)[, 1:2]
pc_scores <- pca_result$scores
# Clustering
num_clusters <- 3
kmeans_result <- kmeans(scaled_data, centers = num_clusters)

library(ggplot2)
pdf("Figures/Prin_com.pdf", width = 7, height = 7)
cluster_assignments <- kmeans_result$cluster
table(cluster_assignments)
# Assuming PC1 and PC2 are the first two principal components
plot(pc_scores[, 1], pc_scores[, 2], 
     col = cluster_assignments, pch = 16,
     xlab = "Principal Component 1", ylab = "Principal Component 2",
     main = "PC1 vs. PC2")
legend("topright", legend = unique(cluster_assignments), col = 1:length(unique(cluster_assignments)), pch = 16)
ggsave("Figures/Prin_com.png")
dev.off()