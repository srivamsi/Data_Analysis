select * from customer_data;




# customers percentage grouped by gender
select 
	Gender, count(Gender) as `total count`, 
	(select count(*) from customer_data as total) as `whole`,
	concat (round(count(Gender) * 100.0/ (select count(*) from customer_data),2),"%") as percentage
from customer_data
group by Gender;

# customers status percentage grouped by stay status.
select Customer_Status,
round(count(Customer_Status)*100/(select count(*) from customer_data),2)as `status %`
from customer_data
group by Customer_status;

# customers revenue percentage, status percentage grouped by stay status.
SELECT 
	Customer_Status, 
	count(Customer_Status) as `count`,
	round(sum(Total_revenue),2) as Revenue, 
	round(sum(Total_revenue)*100.0/(select sum(Total_Revenue) from customer_data),2) as `revenue %`,
	round(count(Customer_Status)*100/(select count(*) from customer_data),2)as `status %`
from customer_data
Group by Customer_Status
order by Revenue desc;

# 
SELECT
	State,
	Count(State) as TotalCount,
	round(Count(State) * 100.0 / (Select Count(*) from customer_data),2)  as Percentage
from customer_data
Group by State
Order by Percentage desc
;

select
Internet_Type,
count(Internet_type)
from customer_data
group by Internet_Type
;




select * from customer_data;

UPDATE customer_data
SET Value_Deal = Nullif(Value_Deal,"None");



CREATE TABLE telecom_churn.prod_data
select * from telecom_churn.customer_data;


UPDATE prod_data
SET 
	Value_Deal = coalesce(Value_Deal, "None"),
	Multiple_Lines = coalesce(Multiple_Lines, "No"),
	Internet_Type = coalesce(Internet_Type, "None"),
	Online_Security = coalesce(Online_Security, "No"),
	Online_Backup = coalesce(Online_Backup, "No"),
	Device_Protection_Plan = coalesce(Device_Protection_Plan, "No"),
	Premium_Support = coalesce(Premium_Support, "No"),
	Streaming_TV = coalesce(Streaming_TV, "No"),
	Streaming_Movies = coalesce(Streaming_Movies, "No"),
	Unlimited_Data = coalesce(Unlimited_Data, "No"),
	Churn_Category = coalesce(Churn_Category, "Others"),
	Churn_Reason = coalesce(Churn_Reason, "Others")
where
	Value_Deal is null or
	Multiple_Lines is null or
	Internet_Type is null or
	Online_Security is null or
	Online_Backup is null or
	Device_Protection_Plan is null or
	Premium_Support is null or
	Streaming_TV is null or
	Streaming_Movies is null or
	Unlimited_Data is null or
	Churn_Category is null or
	Churn_Reason is null ;
    

select * from telecom_churn.prod_data;

# create view data
create view vw_churn_data as
	select * from prod_data where Customer_Status in ('churned','stayed');

create view vw_join_data as
	select * from prod_data where Customer_Status = 'Joined';
