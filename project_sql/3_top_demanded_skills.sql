 /*
 question- what are the most in demand skills for data analyst?
 -join job postings to inner join table similar to query 2
 -identify the top five in demand skills
 -focus on all job postings 
 -why?
 */

 select 
 sd.skills,
 count (sjd.job_id)as demand_count
 from job_postings_fact as jpf 
inner join skills_job_dim as sjd on jpf.job_id=sjd.job_id
inner join skills_dim as sd on sjd.skill_id= sd.skill_id
where jpf.job_title_short= 'Data Analyst' 
and job_location= 'Anywhere'
group by sd.skills
order BY
demand_count DESC


limit 5
