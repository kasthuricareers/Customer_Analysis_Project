CREATE database Customer_Analysis;
USE customer_analysis;
show tables;
rename table customer_data_analysis to customer_data;
select * from customer_data_analysis limit 50;
select * from customer_data where gender = "female";
select count(customer_id) as total_customers from customer_data;
-- Total Revenue male vs female:
select gender, round(sum(purchase_amount_usd),0) as Revenue
from customer_data
group by gender;
-- customer used a discount but still spent more than average purchase:
select customer_id, purchase_amount_usd
from customer_data
where discount_applied = "Yes" and purchase_amount_usd >= (select AVG(purchase_amount_usd) 
from customer_data);
-- Comparing the average purchase between standard and express shipping:
select shipping_type,
round(avg(purchase_amount_usd),2) as avg_shipping
FROM customer_data
where shipping_type in ('standard','express')
group by shipping_type;
-- comparing average spend and total revenue between subscribers and non-subscribers:
select subscription_status,
count(customer_id) as total_customers,
round(avg(purchase_amount_usd),2) as avg_spend,
round(sum(purchase_amount_usd),0) as total_revenue
from customer_data
group by subscription_status
order by total_revenue, avg_spend desc;
-- Customeres who are repeat buyers > 5 times and also likely to subscribe:
select subscription_status,
count(customer_id) as repeat_buyers
from customer_data
where previous_purchases > 5
group by subscription_status; 
-- revenue contribution of each age group:
select age_group,
round(sum(purchase_amount_usd),2) as total_revenue
from customer_data 
group by age_group
order by total_revenue desc;
-- categories whose total sales amount is greater than 5000:
select category,
round(sum(purchase_amount_usd),2) as total_sales
from customer_data
group by category
having total_sales > 5000;













