/* - Subquery creates a list of `company_id`s from the `job_postings` table
    - where there’s no degree needed/mentioned
    - when `job_no_degree_mentioned`  is `true`
- Main query uses subquery (located in the `WHERE`  clause) to get names of 
companies that don’t require a degree */

SELECT
    name as company_name
FROM
    company_dim
WHERE
    company_id IN (
    SELECT
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = TRUE
    )
ORDER BY name ASC

SELECT
    *
FROM 
    skills_job_dim


SELECT
    *
FROM 
    skills_dim
LIMIT
    10

/* Identify the top 5 skills that are most frequently mentioned in job postings. 
Use a subquery to find the skill IDs with the highest counts in the skills_job_dim table 
and then join this result with the skills_dim table to get the skill names.
Hints:
Focus on creating a subquery that identifies and ranks (ORDER BY in descending order) the top 5 
skill IDs by their frequency (COUNT) of mention in job postings.
Then join this subquery with the skills table (skills_dim) to match IDs to skill names. */

SELECT skills_dim.skills
FROM skills_dim
INNER JOIN 
(SELECT skill_id
FROM skills_job_dim
GROUP BY skill_id
ORDER BY COUNT(job_id) DESC
LIMIT 5)
AS top_skills ON skills_dim.skill_id = top_skills.skill_id

/* Determine the size category ('Small', 'Medium', or 'Large') for each company by first identifying the number of job postings they have. 
Use a subquery to calculate the total job postings per company. A company is considered 'Small' if it has less than 10 job postings, 'Medium' 
if the number of job postings is between 10 and 50, and 'Large' if it has more than 50 job postings. Implement a subquery to aggregate job counts
per company before classifying them based on size.
Hints:
Aggregate job counts per company in the subquery. This involves grouping by company and counting job postings.
Use this subquery in the FROM clause of your main query.
In the main query, categorize companies based on the aggregated job counts from the subquery with a CASE statement.
The subquery prepares data (counts jobs per company), and the outer query classifies companies based on these counts. */



SELECT 
    company_id,
    name,
    CASE
        WHEN jobs_posted < 10 THEN 'Small'
        WHEN jobs_posted BETWEEN 10 AND 50 THEN 'Medium'
        WHEN jobs_posted > 50 THEN 'Large'
    END AS size_company
FROM 
(
    SELECT
        company_dim.company_id,
        company_dim.name,
        COUNT(job_postings_fact.job_id) AS jobs_posted  
    FROM
        company_dim INNER JOIN job_postings_fact ON company_dim.company_id = job_postings_fact.company_id
    GROUP BY
        company_dim.company_id, company_dim.name
) AS company_job_count


