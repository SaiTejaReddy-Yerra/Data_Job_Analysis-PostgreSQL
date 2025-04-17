/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
    helping job seekers understand which skills to develop that align with top salaries
*/

SELECT * FROM company_dim LIMIT 10;
SELECT * FROM skills_dim LIMIT 10;
SELECT * FROM skills_job_dim LIMIT 10;
SELECT * FROM job_postings_fact LIMIT 10;

WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    from
        job_postings_fact j 
    INNER JOIN company_dim c ON j.company_id = c.company_id
    WHERE
        job_title_short ='Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY 
        salary_year_avg DESC
    LIMIT 10
)

SELECT t.*,s.skills
FROM top_paying_jobs t
INNER JOIN skills_job_dim sj ON t.job_id = sj.job_id
INNER JOIN skills_dim s ON sj.skill_id = s.skill_id
ORDER BY 
        salary_year_avg DESC;