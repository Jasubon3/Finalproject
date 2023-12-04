PHONY: clean

clean:
	rm -f Figures
	mkdir Figures

	
Figures/temp_trend.png Figures/temp_Variation.png: Temp_trend_variation.R source_data/IndianWeatherRepository.csv
	Rscript Temp_trend_variation.R
Figures/Prin_com.png: Principal_component.R source_data/IndianWeatherRepository.csv
	Rscript Principal_component.R
Figures/Hierarchical_Clustering.png: Clustering.R source_data/IndianWeatherRepository.csv
	Rscript Clustering.R
Figures/DBSCAN_clustering.png: Clustering.R source_data/IndianWeatherRepository.csv
	Rscript Clustering.R
Figures/Correlation_Heatmap.png: Correlation_heatmap.R source_data/IndianWeatherRepository.csv
	Rscript Correlation_heatmap.R
Figures/PCA_wind_hum_sunrise.png: PCA_humi_windspeed_sun.R source_data/IndianWeatherRepository.csv
	Rscript PCA_humi_windspeed_sun.R
Figures/t-SNE.png: tsne.R source_data/IndianWeatherRepository.csv
	Rscript tsne.R
Figures/Actual_vs_Predicted_temp.png: Supervised_learning.R source_data/IndianWeatherRepository.csv
	Rscript Supervised_learning.R
Figures/Temp_distribution_region.png Figures/Temp_vs_Humidity_by_region.png: Temp_hum_by_region.R source_data/IndianWeatherRepository.csv
	Rscript Temp_hum_by_region.R
	