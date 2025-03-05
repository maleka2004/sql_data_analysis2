/*
question- what are the top skills based on salary?
-look at the average salary associated with each skill for data analyst positions
-focus on roles with specified slaries, regardless of location
why?
*/

select 
round (avg(salary_year_avg),0)as avg_salary,
skills

from job_postings_fact as jpf 
inner join skills_job_dim as sjd on jpf.job_id=sjd.job_id
inner join skills_dim as sd on sjd.skill_id= sd.skill_id
where job_title_short= 'Data Analyst' and
salary_year_avg is not NULL and job_work_from_home= True
group by 
skills
order by avg_salary desc
limit 25

/* 
High-Paying Tech Skills – PySpark leads the list with an average salary of $208,172, highlighting the demand for big data processing and analytics.

Version Control & DevOps Matter – Skills like Bitbucket ($189,155) and GitLab ($154,500) command high salaries, showing the importance of CI/CD and code management in modern development.

Data & Cloud Skills Are Valuable – Tools like Databricks ($141,907), GCP ($122,500), and PostgreSQL ($123,879) indicate strong compensation for cloud and database expertise.

*/
