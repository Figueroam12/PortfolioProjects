-- https://public.tableau.com/app/profile/juan.diego.figueroa.matuk/viz/HRBIAttritionDashboard/Dashboard1?publish=yes


--Is there any relationship between who a person works for and their performance score?
--What is the overall diversity profile of the organization?
--What are our best recruiting sources if we want to ensure a diverse organization?
--Can we predict who is going to terminate and who isn't? What level of accuracy can we achieve on this?
-- Are there areas of the company where pay is not equitable?


-- Exploratory Data 

Select Count(*) as total_data_points from HRBIP;

-- Diversity profile of the organization
-- We can see clearly 
Select RaceDesc, Count(*) as total_data_points 
from HRBIP
Group by RaceDesc;

-- Salary by Race

Select RaceDesc, Count(*) as count, avg(salary) as Average_Salary
from HRBIP
Group by RaceDesc;

-- What are our best recruiting sources if we want to ensure a diverse organization?

Select * from hrbip;

with cte as (
Select RecruitmentSource,
sum(Case when RaceDesc = 'White' then 1 else 0 end ) as 'Whites',
sum(Case when RaceDesc = 'Black or African American' then 1 else 0 end ) as 'Black',
sum(Case when RaceDesc = 'Asian' then 1 else 0 end ) as 'Asian',
sum(Case when RaceDesc = 'Hispanic' then 1 else 0 end ) as 'Hispanic',
sum(Case when RaceDesc = 'Two or more races' then 1 else 0 end ) as 'Two or more races',
sum(Case when RaceDesc = 'American Indian or Alaska Native' then 1 else 0 end ) as 'American Indian',
count(*) as Total_Count
from hrbip
Group by RecruitmentSource
)

Select * , CAST(Whites AS float)/CAST(Total_count AS FLOAT) as Percentage from cte 


-- Are there areas of the company where pay is not equitable?

Select * from HRBIP
Select Position, avg(Salary) as Average_salary  FROM hrbip
Group by Position 
Order by Average_salary desc



