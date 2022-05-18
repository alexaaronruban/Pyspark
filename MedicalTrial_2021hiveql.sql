-- Databricks notebook source
select * from clinicaltrial_2021;

-- COMMAND ----------

--Problem1
select count(*) from clinicaltrial_2021;

-- COMMAND ----------

--Problem2
SELECT Type, count(Type) from clinicaltrial_2021 group by Type order by count(Type) desc;

-- COMMAND ----------

--Problem3
create view Condition as
select explode(split(Conditions,',')) as Condition_col from clinicaltrial_2021;
select Condition_col,count(*) from Condition group by Condition_col order by count(Condition_col) desc limit 5;

-- COMMAND ----------

--Problem4
create view mesh_intervention as 
select term, substr(tree,1,3) as tree from mesh;

-- COMMAND ----------

select * from mesh_intervention;

-- COMMAND ----------

create view cltrial_intervention as 
select explode(split(Conditions,',')) as Condition from clinicaltrial_2021;

-- COMMAND ----------

select * 
from cltrial_intervention

-- COMMAND ----------

create view Tree_main as
select tree
from mesh_intervention
INNER JOIN cltrial_intervention 
on mesh_intervention.term=cltrial_intervention.Condition;

-- COMMAND ----------

select tree, count(*)
from Tree_main
group by tree
order by count(tree) desc limit 5;

-- COMMAND ----------

--Problem5
select * from pharma;

-- COMMAND ----------

create view Company_parent as
select Parent_Company as Company
from pharma; 

-- COMMAND ----------

create view Sponsor as 
select Sponsor as Sponsor_name
from clinicaltrial_2021;

-- COMMAND ----------

create view Sponsor_Data as
select Sponsor_name, Company
from Sponsor
LEFT JOIN Company_parent
on Company_parent.Company=Sponsor.Sponsor_name;

-- COMMAND ----------

select Sponsor_name,count(Sponsor_name)
from Sponsor_Data 
where Company is null
group by Sponsor_name
order by count(Sponsor_name) desc limit 10;

-- COMMAND ----------

--Problem6
create view Clinical_month as 
SELECT Submission,Completion
from clinicaltrial_2021
where Completion like '%2021' and Status like 'Completed';

-- COMMAND ----------

create view Month_View as
select distinct Completion, count(*) as count_month
from Clinical_month
group by Completion
order by Completion;

-- COMMAND ----------

select * 
from Month_View
order By 
CASE WHEN Completion='Jan 2021' then 0
when Completion='Feb 2021' then 1
when Completion='Mar 2021' then 2
when Completion='Apr 2021' then 3
when Completion='May 2021' then 4
when Completion='Jun 2021' then 5
when Completion='Jul 2021' then 6
when Completion='Aug 2021' then 7
when Completion='Sep 2021' then 8
when Completion='Oct 2021' then 9
END
;

-- COMMAND ----------


