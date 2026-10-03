SELECT *
From jobs_in_data;

## Creating Table

Create table Jobs_Table
like jobs_in_data;
insert Jobs_Table
select *
from jobs_in_data;
SELECT *
FROM  jobs_table;

-- 1. Remove Duplicates
## Creating Indicator
Select *,
Row_Number() Over(
Partition By job_title, job_category, salary_currency, salary, salary_in_usd, employee_residence, experience_level, employment_type, work_setting, company_location, company_size) as row_num
From jobs_table;

## Creating CTE For Duplicates ( 1st Method )
With duplicate_cte AS
(
Select *,
Row_Number() Over(
Partition By job_title, job_category, salary_currency, salary, salary_in_usd, employee_residence, experience_level, employment_type, work_setting, company_location, company_size) as row_num
From jobs_table
)
SELECT *
From duplicate_cte
Where row_num > 1;

## Checking

WITH duplicate_cte AS (
  SELECT *,
  ROW_NUMBER() OVER(
    PARTITION BY job_title, job_category, salary_currency, salary, salary_in_usd, 
                 employee_residence, experience_level, employment_type, 
                 work_setting, company_location, company_size
  ) AS row_num
  FROM jobs_table
)
SELECT COUNT(*) AS duplicate_count
FROM duplicate_cte
WHERE row_num > 1;

select *
From jobs_table
where job_title = 'Applied Scientist' and
job_category = 'Data Science and Research' and
salary_currency = 'USD' and
salary = '260000' and 
employee_residence = 'United States' and 
experience_level = 'Senior' and 
employment_type = 'Full-time' and
work_setting = 'In-person' and 
company_location = 'United States' and
company_size = 'L';


## Making Table For Removing ( 2nd Method )
CREATE TABLE `jobs_Table2` (
  `work_year` int DEFAULT NULL,
  `job_title` text,
  `job_category` text,
  `salary_currency` text,
  `salary` int DEFAULT NULL,
  `salary_in_usd` int DEFAULT NULL,
  `employee_residence` text,
  `experience_level` text,
  `employment_type` text,
  `work_setting` text,
  `company_location` text,
  `company_size` text,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

Select *
From jobs_TAble2;

Insert into jobs_Table2
Select *,
Row_Number() Over(
Partition By job_title, job_category, salary_currency, salary, salary_in_usd, employee_residence, experience_level, employment_type, work_setting, company_location, company_size) as row_num
From jobs_table;

Select * 
From jobs_Table2
Where row_num > 1;
Delete 
From jobs_Table2
Where row_num > 1;
SELECT COUNT(*) 
FROM jobs_Table2;


SELECT COUNT(*) FROM jobs_in_data;
SELECT COUNT(*) FROM jobs_table;
SELECT COUNT(*) FROM jobs_Table2;


-- 2. Standerdize the Data
Select * 
From jobs_Table2;

SELECT DISTINCT experience_level 
FROM jobs_Table2;
SELECT DISTINCT employment_type 
FROM jobs_Table2;
SELECT DISTINCT TRIM(job_title) <> job_title AS has_whitespace 
FROM jobs_Table2;

SELECT MIN(salary_in_usd), MAX(salary_in_usd), AVG(salary_in_usd)
FROM jobs_Table2
WHERE salary_in_usd <= 0;

SELECT 
  MIN(salary_in_usd) AS min_salary,
  MAX(salary_in_usd) AS max_salary,
  AVG(salary_in_usd) AS avg_salary,
  SUM(salary_in_usd <= 0) AS invalid_salary_count
FROM jobs_Table2;
 
## Skip This Sesseion Cuase There is no Issue in Table.
 
 
 -- 3. Null Values or blank Values
 SELECT 
  SUM(job_title IS NULL) AS null_job_title,
  SUM(salary_in_usd IS NULL) AS null_salary,
  SUM(employee_residence IS NULL) AS null_residence
FROM jobs_Table2;

 ## Skip This Sesseion Cuase There is no Issue in Table.
 
 
 -- 4. Remove Unneccesory Col and Row
alter table jobs_Table2
drop column row_num;

Select *
From jobs_Table2;


SELECT * FROM jobs_Table2
INTO OUTFILE '/path/to/jobs_clean.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';