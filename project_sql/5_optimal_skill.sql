/*
what are the most optimal skills to learn- high paying and high demand 
*/
with skills_demand as (select
sd.skill_id, 
 sd.skills,
 count (sjd.job_id)as demand_count
 from job_postings_fact as jpf 
inner join skills_job_dim as sjd on jpf.job_id=sjd.job_id
inner join skills_dim as sd on sjd.skill_id= sd.skill_id
where jpf.job_title_short= 'Data Analyst' 
and salary_year_avg is not null
and job_location= 'Anywhere'
group by sd.skill_id
),
average_salary as (
select 
sjd.skill_id,
round (avg(salary_year_avg),0)as avg_salary

from job_postings_fact as jpf 
inner join skills_job_dim as sjd on jpf.job_id=sjd.job_id
inner join skills_dim as sd on sjd.skill_id= sd.skill_id
where job_title_short= 'Data Analyst' and
salary_year_avg is not NULL and job_work_from_home= True
group by 
sjd.skill_id
)

SELECT
skills_demand.skill_id,
skills_demand.skills,
skills_demand.demand_count,
avg_salary
from skills_demand
inner join average_salary on skills_demand.skill_id=average_salary.skill_id
where demand_count>10
order by  avg_salary DESC,demand_count DESC 
limit 25