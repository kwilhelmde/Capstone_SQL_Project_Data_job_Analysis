### Introduction
Welcome to my SQL Portfolio Project, where I delve into the dynamics of the data job market, with a special emphasis on data analysis roles. This project reflects a journey to uncover top-paying jobs, in-demand skills, and the intersection of high demand with high salary in the field of data analytics.
Feel free to explore the SQL queries here: [sql_project folder](/sql_project/)
### Background
This project was initiated to gain a deeper understanding of the data analyst job market and to identify the skills that command the highest compensation and are in high demand.
The data utilized for this analysis originates from Luke Barousse’s SQL Course, available at ([SQL for Data Analytics](https://www.youtube.com/watch?v=7mz73uXD9DA&t=12856s)). This dataset comprises comprehensive information encompassing job titles, salaries, locations, and requisite skills.
The primary inquiries addressed through my SQL queries were as follows:

1. What are the highest-paying data analyst positions?
2. Which skills are prerequisites for these top-paying roles?
3. What skills are predominantly sought after by employers for data analyst positions?
4. Are there specific skills correlated with elevated salary levels?
5. Which skills present the most advantageous prospects for data analysts aiming to maximize their market value?
### Tools
In this project, I employed a diverse array of tools to conduct my analysis, including:
- **SQL** (Structured Query Language): This language enabled me to interact with the database, extract insights, and address key questions through tailored queries.
- **PostgreSQL**: Serving as the chosen database management system, PostgreSQL facilitated the storage, querying, and manipulation of the job posting data.
- **Visual Studio Code**: Leveraging this open-source administration and development platform, I managed the database and executed SQL queries efficiently.
### The Analysis
Each query within this project was dedicated to examining particular aspects of the data analyst job market. 
- Top Paying Data Analyst Jobs:

In the pursuit of identifying the highest-paying roles, filters were applied to data analyst positions based on their average yearly salary and location, with a particular emphasis on remote jobs. This query highlights the high-paying opportunities in the field.
```
SELECT
	job_id,
	job_title,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date,
	name AS company_name
FROM
	job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
	job_title = 'Data Analyst'
	AND salary_year_avg IS NOT NULL
	AND job_location = 'Anywhere'
ORDER BY
	salary_year_avg DESC
LIMIT 10;
```
| Job ID   | Job Title     | Job Location | Schedule Type | Average Salary (Yearly) | Posted Date          | Company Name                       |
|----------|---------------|--------------|---------------|-------------------------|----------------------|------------------------------------|
| 226942   | Data Analyst  | Anywhere     | Full-time     | $650,000.00             | 2023-02-20 15:13:33  | Mantys                             |
| 712473   | Data Analyst  | Anywhere     | Full-time     | $165,000.00             | 2023-08-14 16:01:19  | Get It Recruit - Information Tech |
| 1246069  | Data Analyst  | Anywhere     | Full-time     | $165,000.00             | 2023-12-08 09:16:37  | Plexus Resource Solutions         |
| 456042   | Data Analyst  | Anywhere     | Full-time     | $151,500.00             | 2023-09-25 10:59:56  | Get It Recruit - Healthcare       |
| 405581   | Data Analyst  | Anywhere     | Full-time     | $145,000.00             | 2023-05-01 13:00:20  | CyberCoders                        |
| 479485   | Data Analyst  | Anywhere     | Full-time     | $145,000.00             | 2023-03-15 16:59:55  | Level                              |
| 1090975  | Data Analyst  | Anywhere     | Full-time     | $140,500.00             | 2023-03-24 07:06:43  | Uber                               |
| 1482852  | Data Analyst  | Anywhere     | Full-time     | $138,500.00             | 2023-11-23 12:38:59  | Overmind                           |
| 479965   | Data Analyst  | Anywhere     | Full-time     | $135,000.00             | 2023-02-26 01:04:44  | InvestM Technology LLC            |
| 1326467  | Data Analyst  | Anywhere     | Full-time     | $135,000.00             | 2023-06-26 17:00:18  | EPIC Brokers                       |


- Skills for Top Paying Jobs:

To comprehend the skills necessary for the highest-paying jobs, combining job postings with skills data offers insights into the attributes valued by employers for well-compensated positions.

```
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg
    FROM
        job_postings_fact
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_location = 'Anywhere'
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)
SELECT
    top_paying_jobs.job_id,
    top_paying_jobs.job_title,
    top_paying_jobs.salary_year_avg,
    skills_dim.skills
FROM
    top_paying_jobs
    INNER JOIN
    skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    top_paying_jobs.salary_year_avg DESC;
```



- In-Demand Skills for Data Analysts:

This query facilitated the identification of frequently requested skills in job postings, shedding light on areas of significant demand.

```
SELECT
  skills_dim.skills,
  COUNT(skills_job_dim.job_id) AS demand_count
FROM
  job_postings_fact
  INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
  INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
  job_postings_fact.job_title_short = 'Data Analyst' AND
  job_country = 'Germany'
GROUP BY
  skills_dim.skills
ORDER BY
  demand_count DESC
LIMIT 5;
```

| Skills    | Demand Count |
|-----------|--------------|
| SQL       | 2947         |
| Python    | 2316         |
| Tableau   | 1370         |
| Excel     | 1327         |
| Power BI  | 1303         |



- Skills Based on Salary:

Investigating the average salaries tied to diverse skill sets provided insights into which skills are most financially rewarding.

```
SELECT 
  skills_dim.skills AS skill,         
  ROUND(AVG(job_postings_fact.salary_year_avg),2)        
  AS avg_salary
FROM
  job_postings_fact
	INNER JOIN
	  skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
	INNER JOIN
	  skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
  job_postings_fact.job_title_short = 'Data Analyst'
  AND job_country = 'Germany' 
  AND job_postings_fact.salary_year_avg IS NOT NULL
  GROUP BY
  skills_dim.skills 
ORDER BY
  avg_salary DESC;
```

| Skill          | Average Salary |
|----------------|----------------|
| Kafka          | 166419.50      |
| Terraform      | 166419.50      |
| BigQuery       | 166419.50      |
| NoSQL          | 166419.50      |
| Redshift       | 166419.50      |
| GitHub         | 150896.33      |
| Spark          | 138260.71      |
| GCP            | 127477.83      |
| No-SQL         | 111175.00      |
| Terminal       | 111175.00      |
| Databricks     | 111175.00      |
| Elasticsearch  | 111175.00      |
| Flask          | 111175.00      |
| React          | 111175.00      |
| PySpark        | 111175.00      |
| JavaScript     | 111175.00      |
| MATLAB         | 111175.00      |
| Pandas         | 108412.50      |
| Matplotlib     | 107491.67      |
| NumPy          | 105650.00      |
| SAS            | 105650.00      |
| Git            | 105000.00      |
| Python         | 104242.92      |
| Atlassian      | 102500.00      |
| Power BI       | 97748.63       |
| Tableau        | 97211.15       |
| SQL            | 93688.25       |
| Pascal         | 92000.00       |
| SQL Server     | 89100.00       |
| Neo4j          | 89100.00       |
| Julia          | 89100.00       |
| Linux          | 89100.00       |
| Excel          | 87623.43       |
| Looker         | 86927.30       |
| AWS            | 84004.67       |
| PowerPoint     | 83937.50       |
| Azure          | 83763.00       |
| C#             | 82083.75       |
| R              | 81861.93       |
| SAP            | 78007.00       |
| Java           | 75067.50       |
| Go             | 66554.25       |
| Sheets         | 57500.00       |
| Oracle         | 56700.00       |


-  Most Optimal Skills to Learn:

This query sought to combine insights from demand and salary data to pinpoint skills that are in high demand and offer substantial salaries, providing a strategic roadmap for skill enhancement.

```
WITH skills_demand AS (
  SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count
  FROM
    job_postings_fact
    INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
  WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
    AND job_postings_fact.salary_year_avg IS NOT NULL
    AND job_postings_fact.job_location = 'Anywhere'
  GROUP BY
    skills_dim.skill_id
),
average_salary AS (
  SELECT
    skills_job_dim.skill_id,
    AVG(job_postings_fact.salary_year_avg) AS avg_salary
  FROM
    job_postings_fact
    INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
  WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
    AND job_postings_fact.salary_year_avg IS NOT NULL
    AND job_postings_fact.job_location = 'Anywhere'
  GROUP BY
    skills_job_dim.skill_id
)
SELECT
  skills_demand.skills,
  skills_demand.demand_count,
  ROUND(average_salary.avg_salary, 2) AS avg_salary
FROM
  skills_demand
  INNER JOIN
  average_salary ON skills_demand.skill_id = average_salary.skill_id
ORDER BY
  demand_count DESC,
  avg_salary DESC
LIMIT 10;
```

| Skill       | Demand Count | Average Salary |
|-------------|--------------|----------------|
| SQL         | 398          | 97237.16       |
| Excel       | 256          | 87288.21       |
| Python      | 236          | 101397.22      |
| Tableau     | 230          | 99287.65       |
| R           | 148          | 100498.77      |
| Power BI    | 110          | 97431.30       |
| SAS         | 63           | 98902.37       |
| PowerPoint  | 58           | 88701.09       |
| Looker      | 49           | 103795.30      |


### What I Learned
Throughout this journey, the SQL toolkit has been supercharged with formidable capabilities:

- **Complex Query Crafting**: Mastery attained in advanced SQL, seamlessly merging tables and wielding WITH clauses for agile temp table manipulations.

- **Data Aggregation**: Familiarity cultivated with GROUP BY, harnessing aggregate functions like COUNT() and AVG() to summarize data effectively.

- **Analytical Wizardry**: Skills elevated in real-world problem-solving, transforming inquiries into actionable insights through adept SQL queries.

### Conclusions
This project helped me improve my SQL skills and provided invaluable insights into the dynamics of the data analyst job market. The findings underscore the significance of strategic skill development and targeted job search strategies. By prioritizing high-demand, high-salary skills, aspiring data analysts can position themselves advantageously in a competitive job market. Furthermore, this endeavor emphasizes the necessity of adaptability and continuous learning to navigate the evolving landscape of data analytics effectively.