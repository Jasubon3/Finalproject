Exploring Indian Weather Patterns: Insights from Data
=====================================================

### Instruction to run this code
This project was done on Apple M1 chip.

* Clone repository

```
git clone https://github.com/Jasubon3/Finalproject
cd my_project
```

* Build the Docker container using the command line
```
Docker build . -t 611
```
* Run the container

```
docker run -v $(pwd):/home/rstudio/my_project --rm -ti -p 8787:8787 611

```
Then visit http://localhost:8787 and log into the Rstudio server.

### Project Organization
Please examine the Makefile to understand the project organization.

### What to look for in this Project
This project has two parts.

1. A visualization of variables in the Indian Weather Patterns implementing what 
  I learnt in class.
  
2. A report of what I found about the Visualization.

### Results
This report describes what I found in Indian Weather patterns.

* Build the report to get the details.

```
cd my_project

```
```
make BIOS611_project_report.html

```









