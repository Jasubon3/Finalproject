PHONY: clean

clean:
	rm -f Figures
	mkdir Figures

	
Figures/temp_trend.png: Scratch.R source_data/IndianWeatherRepository.csv
	Rscript Scratch.R 
Figures/Weather_cond.png: Scratch.R source_data/IndianWeatherRepository.csv
	Rscript Scratch.R 
Figures/Clustered_Data.png: Scratch.R source_data/IndianWeatherRepository.csv
	Rscript Scratch.R
Figures/Hierarchical_Clustering.png: Scratch.R source_data/IndianWeatherRepository.csv
	Rscript Scratch.R
Figures/DBSCAN_clustering.png: Scratch.R source_data/IndianWeatherRepository.csv
	Rscript Scratch.R
Figures/Correlation_Heatmap.png: Scratch.R source_data/IndianWeatherRepository.csv
	Rscript Scratch.R
Figures/PCA_wind_hum_sunrise.png: Scratch.R source_data/IndianWeatherRepository.csv
	Rscript Scratch.R
Figures/t-SNE.png: Scratch.R source_data/IndianWeatherRepository.csv
	Rscript Scratch.R
Figures/Actual_vs_Predicted_temp.png:Scratch.R source_data/IndianWeatherRepository.csv
	Rscript Scratch.R
Figures/Temp_distribution_region.png:Scratch.R source_data/IndianWeatherRepository.csv
	Rscript Scratch.R
Figures/Temp_vs_Humidity_by_region.png:Scratch.R source_data/IndianWeatherRepository.csv
	Rscript Scratch.R
	
	
	