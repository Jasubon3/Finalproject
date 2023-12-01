FROM rocker/rstudio
RUN apt update && apt install -y man-db && rm -rf /var/lib/ap/lists/*
RUN yes|unminimize

ARG USER_ID
#RUN usermod -u $USER_ID rstudio %% groupmod -g $GROUP_ID rstudio
RUN chown -R rstudio:rstudio /home/rstudio

# install R packages 
RUN R -e "install.packages('tidyverse')"
RUN R -e "install.packages('reshape2')"
RUN R -e "install.packages('Rtsne')"
RUN R -e "install.packages('caret')"
RUN R -e "install.packages('randomForest')"
RUN R -e "install.packages('Metrics')"
RUN R -e "install.packages('dbscan')"
