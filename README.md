### Introduction
Welcome to my SQL Portfolio Project, where I delve into the dynamics of the data job market, with a special emphasis on data analysis roles. This project reflects a journey to uncover top-paying jobs, in-demand skills, and the intersection of high demand with high salary in the field of data analytics.
Feel free to explore the SQL queries here: [sql_project folder](/sql_project/)
### Background
This project was initiated to gain a deeper understanding of the data analyst job market and to identify the skills that command the highest compensation and are in high demand.
The data utilized for this analysis originates from Luke Barousse’s SQL Course, available at ([SQL for Data Analytics](https://www.lukebarousse.com/sql)). This dataset comprises comprehensive information encompassing job titles, salaries, locations, and requisite skills.
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
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

### The Analysis
Each query within this project was dedicated to examining particular aspects of the data analyst job market. 

#### 1. Top Paying Data Analyst Jobs:

In the pursuit of identifying the highest-paying roles, filters were applied to data analyst positions based on their average yearly salary and location, with a particular emphasis on remote jobs. This query highlights the high-paying opportunities in the field.
```sql
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
	job_title_short = 'Data Analyst'
	AND salary_year_avg IS NOT NULL
	AND job_location = 'Anywhere'
ORDER BY
	salary_year_avg DESC
LIMIT 10;
```
| Job ID   | Job Title                                     | Location | Schedule   | Salary (Year Avg) | Posted Date        | Company Name                                  |
|----------|-----------------------------------------------|----------|------------|-------------------|--------------------|-----------------------------------------------|
| 226942   | Data Analyst                                 | Anywhere | Full-time  | 650000.0          | 2023-02-20 15:13:33| Mantys                                        |
| 547382   | Director of Analytics                         | Anywhere | Full-time  | 336500.0          | 2023-08-23 12:04:42| Meta                                          |
| 552322   | Associate Director- Data Insights             | Anywhere | Full-time  | 255829.5          | 2023-06-18 16:03:12| AT&T                                          |
| 99305    | Data Analyst, Marketing                      | Anywhere | Full-time  | 232423.0          | 2023-12-05 20:00:40| Pinterest Job Advertisements                   |
| 1021647  | Data Analyst (Hybrid/Remote)                 | Anywhere | Full-time  | 217000.0          | 2023-01-17 00:17:23| Uclahealthcareers                             |
| 168310   | Principal Data Analyst (Remote)               | Anywhere | Full-time  | 205000.0          | 2023-08-09 11:00:01| SmartAsset                                    |
| 731368   | Director, Data Analyst - HYBRID              | Anywhere | Full-time  | 189309.0          | 2023-12-07 15:00:13| Inclusively                                   |
| 310660   | Principal Data Analyst, AV Performance Analysis | Anywhere | Full-time | 189000.0          | 2023-01-05 00:00:25| Motional                                      |
| 1749593  | Principal Data Analyst                        | Anywhere | Full-time  | 186000.0          | 2023-07-11 16:00:05| SmartAsset                                    |
| 387860   | ERM Data Analyst                              | Anywhere | Full-time  | 184000.0          | 2023-06-09 08:01:04| Get It Recruit - Information Technology       |

Here's the breakdown of the top data analyst jobs in 2023:

- **Wide Salary Range:** The salary range for the top 10 highest-paying data analyst roles span from $184,000 to $650,000, per year. This wide range highlights the diverse compensation packages available in the field.
- **Diverse Employers:** Employers in the data analytics sector are diverse, including companies like Mantys, Meta, AT&T, Pinterest Job Advertisements, and more, showcasing the broad range of industries and organizations seeking data analysts.
- **Job Title Variety:** The job titles for data analytics roles are diverse and reflective of the different levels and specializations within the field, ranging from "Data Analyst" and "Director of Analytics" to "Principal Data Analyst" and "Associate Director- Data Insights.

#### 2. Skills for Top Paying Jobs:

To comprehend the skills necessary for the highest-paying jobs, combining job postings with skills data offers insights into the attributes valued by employers for well-compensated positions.

```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name as company name
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

![Top Paying Roles](assets\Top_Paying_Jobs.png)
The bar graph visualizes the frequency of skills required for the top 10 highest-paying data analyst positions. This graph was generated utilizing Microsoft Excel, employing my SQL query results.

Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:

- **SQL** is leading with a bold count of 8.
- **Python** follows closely with a bold count of 7.
- **tableau** is also highly sought after, with a bold count of 6. Other skills like R, Snowflake, Pandas, and Excel show varying degrees of demand.

#### 3. In-Demand Skills for Data Analysts:

This query facilitated the identification of frequently requested skills in job postings in Germany, shedding light on areas of significant demand.

```sql
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

Here's the breakdown of the most demanded skills for data analysts in 2023, according to the most frequently requested skills in job postings in Germany:

-**SQL** was the most in-demand skill for data analysts in Germany in 2023, with 2947 job postings.

-**Python** followed closely behind, with 2316 job postings, showcasing its importance in data analysis roles.

-**Tableau** demonstrated significant relevance, with 1370 job postings, highlighting the demand for data visualization expertise.

-**Excel** remained a fundamental skill, with 1327 job postings, underlining its enduring importance in data analysis.

-**Power BI** also saw substantial demand, with 1303 job postings, indicating the need for expertise in data visualization and reporting tools.

#### 4. Skills Based on Salary:

Investigating the average salaries tied to diverse skill sets provided insights into which skills are most financially rewarding in Germany.

```sql
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

![Top Paying Roles](assets\Skills_Based_on_Salary.png)
The bar graph visualizes the skills that are most financially rewarding in Germany. This graph was generated utilizing Microsoft Excel, employing my SQL query results.

Here's a breakdown of the results for top paying skills for Data Analysts:

The demand for Big Data and ML skills is soaring, as evidenced by the popularity of tools like Kafka, Spark, Databricks, and PySpark. Each of these tools specializes in critical areas such as streaming data processing, distributed computing, cloud-based analytics, and Python-based Big Data processing, attracting professionals with varying average salaries.

Moreover, mastery of software development and deployment tools like GitHub and Git is indispensable. These platforms underscore the importance of version control and collaborative workflows in software development, offering appealing average salaries to skilled practitioners.

In parallel, expertise in cloud computing is highly coveted, with Google Cloud Platform (GCP) and Azure emerging as top contenders. GCP shines in cloud computing and data engineering realms, while Azure boasts a comprehensive suite of cloud services from Microsoft. The acquisition of these skills promises promising career prospects in the rapidly evolving tech landscape.

#### 5.  Most Optimal Skills to Learn:

This query sought to combine insights from demand and salary data to pinpoint skills that are in high demand and offer substantial salaries, providing a strategic roadmap for skill enhancement. This analysis makes a particular emphasis on jobs that were posted in Germany

```sql
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
    AND job_postings_fact.job_country = 'Germany'
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
    AND job_postings_fact.job_country = 'Germany'
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

| Skills   | Demand Count | Average Salary |
|----------|--------------|----------------|
| sql      | 24           | 93688.25       |
| python   | 18           | 104242.92      |
| tableau  | 13           | 97211.15       |
| spark    | 7            | 138260.71      |
| excel    | 7            | 87623.43       |
| r        | 7            | 81861.93       |
| looker   | 5            | 86927.30       |
| pandas   | 4            | 108412.50      |
| power bi | 4            | 97748.63       |
| go       | 4            | 66554.25       |

Here's a breakdown of the most optimal skills for Data Analysts in 2023:

**SQL**: With the highest demand count of 24, SQL skills are widely sought after in the German job market. Despite a slightly lower average salary of €93,688.25, proficiency in SQL offers solid career prospects.

**Python**: Python follows closely with 18 demand counts and a higher average salary of €104,242.92, indicating strong demand and rewarding opportunities for Python programmers in Germany.

**Tableau**: Despite a lower demand count compared to SQL and Python, Tableau's average salary of €97,211.15 makes it a lucrative skill to possess, especially for data visualization roles.

**Spark, Excel, and R**: These skills tie with 7 demand counts each. Spark stands out with the highest average salary of €138,260.71, followed by Excel and R. Proficiency in these technologies can lead to competitive salaries and job opportunities.

**Looker, Pandas, Power BI, and Go**: While these skills have lower demand counts (ranging from 5 to 4), they still offer attractive average salaries, making them valuable additions to one's skill set for those seeking diverse career paths in Germany.

### What I Learned
Throughout this journey, the SQL toolkit has been supercharged with formidable capabilities:

- **Complex Query Crafting**: Mastery attained in advanced SQL, seamlessly merging tables and wielding WITH clauses for agile temp table manipulations.

- **Data Aggregation**: Familiarity cultivated with GROUP BY, harnessing aggregate functions like COUNT() and AVG() to summarize data effectively.

- **Analytical Wizardry**: Skills elevated in real-world problem-solving, transforming inquiries into actionable insights through adept SQL queries.

### Conclusions
This project helped me improve my SQL skills and provided invaluable insights into the dynamics of the data analyst job market. The findings underscore the significance of strategic skill development and targeted job search strategies. By prioritizing high-demand, high-salary skills, aspiring data analysts can position themselves advantageously in a competitive job market. Furthermore, this endeavor emphasizes the necessity of adaptability and continuous learning to navigate the evolving landscape of data analytics effectively.
