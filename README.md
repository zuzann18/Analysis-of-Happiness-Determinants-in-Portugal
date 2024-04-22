# Analysis-of-Happiness-Determinants-in-Portugal
This project analyzes happiness determinants in Portugal using 2018 ESS data, focusing on factors like health and income.
##Project Objectives:

Primary Goal: Leverage the European Social Survey data to uncover key drivers of happiness in Portugal, providing actionable insights for social policy development.

## 1. Data Preprocessing:
Data Cleaning and Transformation:

*Variable Recoding*: Utilized PROC FORMAT to redefine categorical variables into more interpretable forms, including transforming happiness levels into a binary variable, 'is_happy', through dichotomization.
*Data Integrity Checks*: Employed PROC MEANS and PROC FREQ to perform exploratory data analysis, ensuring data quality, assessing the distribution of variables, and identifying outliers.
*Handling of Missing Values*: Implemented missing data strategies using PROC STDIZE for imputation and conditional processing to maintain the validity of the regression models. Extensive missing cases were excluded via listwise deletion.
## 2. Statistical Techniques:
Logistic Regression Analysis:

Model Building and Refinement: Constructed the logistic regression model using PROC LOGISTIC, incorporating predictor variables and interaction terms to explore their effects on happiness.
### Statistical Testing for Model Validation: 
Conducted hypothesis testing using options within PROC LOGISTIC to perform *Wald tests* for assessing the significance of each predictor.
## 3. Validation of Findings:

Model Diagnostic Checks: Utilized goodness-of-fit tests and residual analysis to verify the adequacy of the model fit, including specific evaluations like the *Hosmer-Lemeshow test*.
Outcome Verification: Analyzed the magnitude and significance of the odds ratios to measure the effect sizes of the predictors on the probability of reporting happiness.
## 4. Measurement of Uncertainty and Empirical Validation:
Uncertainty Assessment:

*Confidence Intervals and P-Values*: Generated using PROC LOGISTIC, providing detailed output including odds ratios, confidence intervals, and p-values for precise interpretation.
Empirical Comparison:
Benchmarking Against Prior Studies: Validated findings by comparing with external benchmarks and previous research to substantiate the reliability and validity of the conclusions.
## Additional Tools and Techniques Used:
PROC SQL: For data manipulation tasks such as joining tables and creating new variables.
PROC RANK and PROC UNIVARIATE: For data normalization and analyzing distributions.
PROC GPLOT and PROC SGPLOT: For generating high-quality graphics to visualize the effects of predictors on the outcome variable.
Macro Variables: Used to automate tasks and enhance the efficiency of the analysis.
ODS (Output Delivery System): Configured to output results in various formats, aiding in the creation of well-formatted reports.

