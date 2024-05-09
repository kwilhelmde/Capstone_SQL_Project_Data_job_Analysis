/* Create a table named data_science_jobs that will hold information about job
 postings. Include the following columns: job_id (integer and primary key), 
 job_title (text), company_name (text), and post_date (date). */

 CREATE TABLE data_science_jobs (
    job_id INT PRIMARY KEY,
    job_title TEXT,
    company_name TEXT,
    post_date DATE
 );

 /* Insert three job postings into the data_science_jobs table. Make sure each job 
 posting has a unique job_id, a job_title, a company_name, and a post_date. */

 INSERT INTO data_science_jobs (job_id, job_title, company_name, post_date)
 VALUES
 (1, 'Business Intelligence Consultant', 'GROUP 6C', '2024-01-04'),
 (2, 'Data Analyst', 'IT-Solutions', '2024-03-09'),
 (3, 'Data Scientist', 'ECO_Teams', '2024-05-07');

 SELECT 
    *
 FROM
    data_science_jobs;

/* Alter the data_science_jobs table to add a new Boolean column
 (uses True or False values) named remote. */

ALTER TABLE data_science_jobs
ADD remote BOOLEAN; 

-- Rename the post_date column to posted_on from the data_science_job table.

ALTER TABLE data_science_jobs
RENAME COLUMN post_date to posted_on;

/* Modify the remote column so that it defaults to FALSE in the data_science_job table .
 Hint: Use SET DEFAULT command */

ALTER TABLE data_science_jobs
ALTER COLUMN remote SET DEFAULT FALSE;

-- Drop the company_name column from the data_science_jobs table.

ALTER TABLE data_science_jobs
DROP COLUMN company_name;

/* Update the job posting with the job_id = 2 . Update the remote column for this 
job posting to TRUE in data_science_jobs.
Hint: Use SET to specify the column that needs to be updated and 
the new value for that column. */

UPDATE data_science_jobs
SET remote = TRUE
WHERE job_id = 2

SELECT *
FROM data_science_jobs

INSERT INTO data_science_jobs (job_id, job_title, posted_on)
VALUES
(4, 'Data Scientist', '2023-02-05');

DROP TABLE data_science_jobs;