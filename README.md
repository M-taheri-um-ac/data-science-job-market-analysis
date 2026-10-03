# Data Science Job Market Analysis

Analysis of salary trends in data-related careers (2020–2024), using **SQL** for data cleaning and **R** for exploratory analysis, hypothesis testing, and regression modeling.

📄 **📄 **[View the full analysis report (live demo)](https://m-taheri-um-ac.github.io/data-science-job-market-analysis/Data_Science_Job_Market_Analysis.html)****

---

## Dataset

- Source: [Jobs and Salaries in Data Science](https://www.kaggle.com/datasets/hummaamqaasim/jobs-in-data) (Kaggle)
- Raw records: 9,355 | After cleaning: 5,004
- Key fields: `job_title`, `job_category`, `experience_level`, `employment_type`, `work_setting`, `salary_in_usd`, `company_location`, `company_size`

## Project Structure

```
├── sql/        SQL script used for deduplication and data validation
├── data/       Cleaned dataset (CSV) exported from SQL, used as input for R
├── report/     R Markdown report (.Rmd) and rendered HTML output
```

## Methodology

1. **Data Cleaning (SQL):** Deduplication using `ROW_NUMBER() OVER (PARTITION BY ...)`, null checks, text standardization checks, and salary validity checks.
2. **Exploratory Data Analysis (R):** Summary statistics and boxplot visualization of salary by experience level.
3. **Assumption Checking:** Normality (QQ-plot) and homogeneity of variance (Levene's Test) were checked before selecting a hypothesis test.
4. **Hypothesis Testing:** Welch's ANOVA and Kruskal-Wallis test (used in place of classical ANOVA due to unequal variances).
5. **Regression Modeling:** Multiple linear regression, with nested model comparison (`anova()`) to test whether adding `job_category` significantly improved the model.

## Key Findings

| Question | Result |
|---|---|
| Does experience level affect salary? | Yes, significant (p < 0.001) |
| Highest-paying job category | Machine Learning and AI (+$48,227 vs. baseline) |
| Does work setting matter? | Yes — but Hybrid roles have the *lowest* average salary, not Remote |
| Variance explained by final model | 26.2% (Adjusted R²) |

## Limitations

- The model explains only 26% of salary variance — unmeasured factors (specific job title, years of experience, individual skills) likely account for much of the rest.
- Data spans 2020–2024 without inflation adjustment.
- `company_location` / `employee_residence` were not included in the final model.

## Tools

`MySQL` · `R` (`dplyr`, `ggplot2`, `car`, `ggpubr`, `gtsummary`)

## Author

Mahdi Taheri
