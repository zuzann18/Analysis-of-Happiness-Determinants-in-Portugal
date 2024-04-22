# Analysis-of-Happiness-Determinants-in-Portugal
This project analyzes happiness determinants in Portugal using 2018 ESS data, focusing on factors like health and income. Through SAS logistic regression and statistical testing, we identified key influences on happiness. The results, visualized through charts and tables, offer insights for enhancing societal well-being.

1. Data Preprocessing:
Data Cleaning and Transformation:
Variable Recoding: Utilized PROC FORMAT to redefine categorical variables into more interpretable forms. For instance, happiness levels were transformed into a binary variable, 'is_happy', through dichotomization.
Data Integrity Checks: Employed PROC MEANS and PROC FREQ to perform exploratory data analysis, ensuring data quality, assessing the distribution of variables, and identifying outliers.
Handling of Missing Values: Missing data strategies were implemented using PROC STDIZE (for imputation) and conditional processing to ensure the robustness of the analyses. Cases with extensive missing data were excluded using listwise deletion to maintain the validity of the regression models.
2. Statistical Techniques:
Logistic Regression Analysis:
Model Building and Refinement: Constructed the logistic regression model using PROC LOGISTIC, incorporating predictor variables and interaction terms to explore their effects on happiness.
Statistical Testing for Model Validation: Performed hypothesis testing using PROC LOGISTIC options to include Wald tests for the assessment of the significance of each predictor in the model.
3. Objectives and Validation of Findings:
Project Objectives:
Primary Goal: To leverage the European Social Survey data to uncover key drivers of happiness in Portugal, thereby providing actionable insights for social policy development.
Verification of Results:
Model Diagnostic Checks: Conducted goodness-of-fit tests and residual analysis using PROC LOGISTIC to verify the adequacy of the model fit. Techniques such as the Hosmer-Lemeshow test were specifically considered to evaluate model goodness-of-fit.
Outcome Verification: Examined the magnitude and significance of the odds ratios, calculated within PROC LOGISTIC, to measure the effect sizes of the predictors on the probability of reporting happiness.
4. Measurement of Uncertainty and Empirical Validation:
Uncertainty Assessment:
Confidence Intervals and P-Values: Generated using PROC LOGISTIC, which provides detailed output including odds ratios, confidence intervals, and p-values for each factor in the model, allowing for precise interpretation of results.
Empirical Comparison:
Benchmarking Against Prior Studies: Compared findings with existing research by incorporating external benchmarks and previous study results to substantiate the reliability and validity of the conclusions.
Additional Tools and Techniques Used:
PROC SQL: Used for data manipulation tasks such as joining tables, creating new variables, and subsetting data, which facilitated more complex data arrangements and pre-analysis preparations.
PROC RANK and PROC UNIVARIATE: Applied for data normalization and distribution analysis. These procedures helped in understanding the distribution of continuous variables and preparing them for regression analysis.
PROC GPLOT and PROC SGPLOT: Employed for generating high-quality graphics to visualize the distribution of variables, the relationship between different variables, and the effects of the predictors on the outcome variable.
Macro Variables: Used extensively to automate repetitive tasks and parameterize parts of the SAS code, enhancing the efficiency and reproducibility of the analysis.
ODS (Output Delivery System): Configured to direct output to various destinations in different formats, facilitating the creation of well-formatted tables and charts for reporting and presentation purposes.
