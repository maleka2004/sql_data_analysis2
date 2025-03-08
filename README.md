# Introduction
Dive into the data job market!focusing on data analyst roles, this project explores top_paying jobs, in_demand skills, and where high demand meets high salary in data analytics.

SQL queries? chech them out here : [project_sql folder](C:\Users\SS\Desktop\sql_data_analysis2\project_sql)

# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top paid and in demand skills, streamlining others work to find optimal jobs.

Data hails from my [SQL Course](https://lukebarousse.com/sql). Its packed with insights on job totle, salaries, locations, and essential skills

### The questions I wanted to answer through my SQL queries were:

1. What are the top paying data analyst jobs?
2. What skills are required for these top paying jobs?
3. What skills are most in demand for data analyst?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go to for database management and executing SQL queries.
- **Git and Github:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.


# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market.
Here's how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest paying roles I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlughts the high paying oppurtunities in the field.
```sql
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

    limit 10;
```
Here's the breakdown of the top data analyst jobs in 2023:
- **Wide salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000 indicating significant salary potential in the field.
- **Diverse Employers:**    Companies like SmartAsset, Meta, and AT$T are among those offering high salaries, showing a broad interest accross different inductries.
- **Job Tiltle Variety:** There's a high diversity in job titles, from dasta analyst to director of analytics, reflecting varied roles and specializations within data analytics.

![top paying roles](assets\1_tp_paying_job.png)
*Bar graph visualizing the salary for the top 10 salaries for data analysts, ChatGPT generated this graph from my sql results*

### 2. Skills For Top Paying Jobs
To understand what skills are required for the top paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high compensation roles

```sql
with top_paying_jobs as (
SELECT
    job_id,
    job_title,
    salary_year_avg,
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

    limit 10)
    
select 
tpj.*,
sd.skills 
from top_paying_jobs as tpj
inner join skills_job_dim as sjd on tpj.job_id=sjd.job_id
inner join skills_dim as sd on sjd.skill_id= sd.skill_id
order by salary_year_avg DESC
```
Key insights
- SQL - 7 mentions
- Python - 6 mentions
- Tableau - 5 mentions
- Excel - 3 mentions
- Power BI - 2 mentions
- Snowflake - 2 mentions
- Pandas - 2 mentions
- R - 2 mentions
- Azure - 2 mentions
- AWS - 2 mentions

![skills for top paying roles](assets\2_top_paying_job_skills.png)
*Here's a bar chart showing the top 10 in-demand skills for high-paying data roles, with SQL and Python leading the list*

### 3. In Demand Skills For Data Analysts
This query helped identify the skills most frequently requested in job postings , directing focus to areas with high demand.
```sql
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
```
Key Insights 
- **SQL** is a non-negotiable skill for data-related roles.
- **Combining Excel with Python** can boost versatility in analytics and automation.
- **Data visualization tools (Tableau & Power BI)** are crucial for making data-driven business decisions.
- Mastering a combination of these skills will significantly improve job prospects and earning potential.


| Skill    | Demand Count |
|----------|--------------|
| SQL      |   7291       |
| Excel    |   4611       |
| Python   |   4330       |
| Tableau  |   3745       |
| Power BI |   2609       |

*table for the demand for top 5 skills in data analyst roles*

### 4.Skills based on salary
Exploring the average salaries for each skill revealed which skills are highest paying
```sql
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
```
Key Insights-
- **Big Data & AI Dominate**

PySpark (top-paying) is crucial for big data processing, making it a valuable skill.
Watson (IBM's AI platform) and DataRobot (AI-driven automation) also show high earning potential.
Version Control & DevOps Tools Pay Well

- **Bitbucket and GitLab**, both version control tools, highlight the demand for DevOps expertise.
Database & Cloud Skills Are Rewarding

- **Couchbase (a NoSQL database) and Elasticsearch (for search and analytics)** are among the top-paying skills.
Programming & Data Science Tools Have High Value

- **Swift (iOS development), Jupyter, and Pandas (data science tools)** show strong salary potential for developers and analysts.
 
 ![high_paying_skills](assets\4)
 *Top ten highest paying skills*

 ### 5. Most Optimal Skills To Learn

 Combining insight from demand and salary data, this query aimed to pin point skills that are both high in demand and high paying offering a strategic focus for skill development

 ```sql
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
```
![optimal skills](assets\5)
*Top ten skills based on the highest salary and demand*

Key Insights-
- **Cloud computing and data engineering** skills are among the most lucrative.
- **Project management and collaboration tools** are highly valued, showing a demand for team coordination skills.
- **Big data processing and analytics** continue to drive high salaries.

# What I Learned
Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:
- **Complex query crafting:** Mastrered the art of advance SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
- **Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- **Analytical wizardry:** Leveled up my real world puxxle-solving skills, turning questions into actionable, insightful SQL queries.

- # Conclusions
## Insights
1. **Wide salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000 indicating significant salary potential in the field.
2. **skills required for top paying jobs:** SQL is required for most high-paying jobs
3. **Most in demand skill:** SQL is also the most demanded skill in the data analyst job market.
4. **Skills with higher salaries**: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal skills for job market value**: SQL leads in demand and odffers for a high average salary.

## Closing thoughts
This project enhanced my SQL skills and provided me with valuable insights on the job market for a data analyst. It also streamlined the process for skills that statistically lead to success in the data analyst's job market. This exploration highlights the importance of cintinuoused learning and adaptation to emerging trends in the field of data analytics. 



