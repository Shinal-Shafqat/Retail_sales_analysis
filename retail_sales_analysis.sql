select * from retail_sales
------------------------------------- Data cleaning -------------------------------------------
select * from retail_sales

where
transactions_id	is null
or
sale_date is null
or
sale_time is null
or
gender is null
or
category is null
or
quantity	is null
or
cogs is null
or
total_sale is null
delete from retail_sales
select * from retail_sales

where
transactions_id	is null
or
sale_date is null
or
sale_time is null
or
gender is null
or
category is null
or
quantity	is null
or
cogs is null
or
total_sale is null
----------------Data Exploration------------------------------------
--how many sales we have?
select count(total_sale) from retail_sales
--how many nique customers we have?
select count(distinct customer_id) from retail_sales
--how many unique categories we have?
select distinct category from retail_sales

----- Data analysis and business key problems-----
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select * from retail_sales where sale_date = '2022-11-05'
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select * from retail_sales
where 
category = 'Clothing' and
TO_CHAR(sale_date , 'YYYY-MM') = '2022-11' and
quantity >=4

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each categor
select count(total_sale) as sales , 
sum(total_sale) as netsale,
category from retail_sales
group by category
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select avg(age) as Avg_age from retail_sales
where category = 'Beauty'
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales where 
total_sale > 1000
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select count(transactions_id) as total_trans , gender , category
from retail_sales
group by gender , category
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select * from
(
select 
EXTRACT(YEAR from sale_date ) as sale_year,

EXTRACT(MONTH from sale_date ) as sale_month,
avg(total_Sale),
Rank() over (partition by EXTRACT(YEAR from sale_date) order by avg(total_Sale) desc) as rnk 

from retail_sales
group by 1,2)
where rnk = 1
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select sum(total_sale) as sales, customer_id from retail_sales 
group by customer_id
order by sales desc
limit 5


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select count ( distinct customer_id ), category from retail_sales

group by  category  
 
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
with hourly_sales
as
(
select s.* , s.sale_time,

case
  when sale_time <= '12:00:00'then ' MORNING_SHIT'
  when sale_time between '12:00:00' and '17:00:00' then 'AFTERNOON_SHIFT'

else 'EVENING_SHIFT'
end as SHIFTS
from retail_sales s
)
select count(*) as total_orders, SHIFTS from hourly_sales
group by SHIFTS 
------------------------------- END OF PROJECT ----------------------------------------------

