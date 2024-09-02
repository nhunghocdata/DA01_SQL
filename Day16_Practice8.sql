--- Ex1:
/* input: order = delivery => immediate
earliest order date = first order 
output: percentage of immediate order in the first order 
first order 
no of immediate order + no of scheduled order
percentage
 
with first_order as (select customer_id, delivery_id, order_date, min(order_date) as 1st_order 
from delivery
group by customer_id),

imm_order as (select count(customer_id) as im_order from first_order 
where order_date = 1st_order)

select round((select count(customer_id) from first_order)/(select * from imm_order)*100) 
*/

with first_order as(select *,
rank() over(partition by customer_id order by order_date) as 1st_order
from Delivery

select round(avg(order_date = customer_pref_delivery_date)*100, 2) as immediate_percentage from first_order
where 1st_order = 1

--- Ex2:
  





