# Difference-In-Differences-Analysis-of-Minimum-Wage-Effects-on-Fast-Food-Employment

An econometric analysis to evaluate the impact of New Jersey's minimum wage increase in April 1992 on employment levels in the fast-food industry, using a Difference-in-Differences (DiD) approach and additional robustness checks.

## Description

This project analyzes employment data from New Jersey and Pennsylvania to measure the causal effect of a minimum wage increase. The analysis involves implementing DiD estimators, testing the parallel trends assumption, and exploring robustness with fixed effects and nonparametric methods. This work was completed as part of ECON 418/518 at The University of Arizona

## Getting Started

### Dependencies

* R version 4.0 or higher
* Operating System: Windows 10, macOS, or Linux
* Required R packages:
```
pacman
```
```
plm
```
```
data.table
```
```
ggplot2
```
```
gridExtra
```

### Installing

* Download and install R from CRAN.
* Install RStudio for an enhanced coding environment (optional).
* Install the required libraries using ```"pacman"```:
```
install.packages("pacman")
pacman::p_load(data.table, ggplot2, plm, gridExtra)
```

### Executing program

* Clone the repository or download the project files to your local machine.
* Place the dataset ```("ECON_418-518_Exam_3_Data.csv")``` in the appropriate working directory.
* Open the R script in RStudio.
* Set the working directory:
```
setwd("path_to_your_directory")
```
* Run the script step-by-step to:
  * Load and preprocess the dataset.
  * Compute descriptive statistics and visualizations.
  * Estimate the DiD model and assess the treatment effect.
  * Perform robustness checks, such as adding fixed effects or testing for parallel trends.

## Authors

Roderick Featherstone
roderickfeatherstone@gmail.com

## Version History

* 0.2
    * Added fixed effects to the DiD model.
    * Conducted parallel trends tests and placebo analysis.
* 0.1
    * Initial implementation of the DiD estimator and basic visualizations.

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.

## Acknowledgments
* William Brasic for guidance on econometric techniques.
* The University of Arizona for providing resources and datasets.
* David Card and Alan Krueger for their seminal 1993 study, "Minimum Wages and Employment."
