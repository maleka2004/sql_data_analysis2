/*
question: what are the top paying data analyst jobs?
-identify the top 10 highest paying data analyst roles that are available remotely
-focus on job postings with specified salaries(remove nulls)
-why?higlight the top paying oppurtunities for data analysts
*/

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name as company_name
FROM 
    job_postings_fact
left join company_dim
on job_postings_fact.company_id= company_dim.company_id
WHERE
    job_title_short='Data Analyst' and 
    job_location= 'Anywhere' AND
    salary_year_avg is not NULL
order by 
    salary_year_avg desc

    limit 10