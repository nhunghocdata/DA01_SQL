--- Ex1:
/* the count of companies + have posted duplicate job listings 
(identical titles and descriptions)
output: count(company_id)
input: title, description, company_id */

with job_count_table as(
select company_id, title, description,
count(job_id) as job_count
from job_listings
group by company_id, title, description)

select count(distinct company_id) as duplicated_companies
from job_count_table
where job_count > 1

--- Ex2: 
/* identify the top two highest-grossing products 
in each category 
in the year 2022

output: category, product,  TOTAL_SPEND => cte
input: product, category, spend (in each category)
condition: max_total_spend
*/

with selling_appliance as ( 
select category, product,
sum(spend) as total_spend 
from product_spend
where extract(year from transaction_date) = 2022
and category = 'appliance'
group by category, product
order by total_spend DESC
limit 2)

with selling_electronics as ( 
select category, product,
sum(spend) as total_spend 
from product_spend
where extract(year from transaction_date) = 2022
and category = 'electronics'
group by category, product
order by total_spend DESC
limit 2)

select * from selling_appliance
union all
select * from selling_electronics

--- Ex3:
/* how many UHG policy holders made >= 3 calls
output: no_of_holders 
input: case_id, 
*/
with call_report as(
select policy_holder_id,
count(case_id) as case_count
from callers
group by policy_holder_id
having count(case_id) >= 3
order by policy_holder_id)

select count(policy_holder_id) as no_of_holders
from call_report

--- Ex4:
select a.page_id
from pages as a
left join page_likes as b 
on a.page_id = b.page_id
where b.page_id is null 

--- Ex5: 
/* output: month + country 
the number of transactions + total amount, 
the number of approved transactions + their total amount
input: group by trans_date, country, id, amount
*/
select date_format(trans_date, '%y-%m') as month_of_trans, country, 
count(id) as no_of_transactions,
sum(amount) as total_amount,
sum(case
    when state = 'approved' then 1 
    else 0
end) as no_of_approved_trans,
sum(case
    when state = 'approved' then amount
    else 0
end) as amount_of_approved_trans
from Transactions
group by date_format(trans_date, '%y-%m'), country

--- Ex6:
/* output: product id, year, quantity, and price for the first year 
group by: every product
*/
select product_id,
    year as first_year,
    quantity,
    price
from Sales
where
    (product_id, year) in (
        select product_id, min(year) as year
        from Sales
        group by product_id)

--- Ex7: 
select customer_id, count(product_key) as product_count
from customer
group by customer_id
having product_count >= 2

--- Ex8: 
/* output: IDs with salary is strictly less than $30000 
whose manager left the company (their information is deleted from the Employees table but still have their manager_id) 
*/
select employee_id 
from employees 
where salary<30000
and manager_id not in (select employee_id from employees)

--- Ex9:
/* the count of companies + have posted duplicate job listings 
(identical titles and descriptions)
output: count(company_id)
input: title, description, company_id */

with job_count_table as(
select company_id, title, description,
count(job_id) as job_count
from job_listings
group by company_id, title, description)

select count(distinct company_id) as duplicated_companies
from job_count_table
where job_count > 1

--- Ex10: 
/* name of the user who has rated the greatest number of movies 
movie name with the highest average rating + February 2020
*/
with first_query as (
    select 
        b.name as customer_name, 
        a.user_id, 
        count(a.movie_id) as movie_count 
    from movierating as a
    join users as b
    on a.user_id = b.user_id
    group by a.user_id
    order by count(a.movie_id) desc
    limit 1
),
second_query as (
    select c.title,
        avg(d.rating) as avg_rating
    from movies as c
    join movierating as d
    on c.movie_id = d.movie_id
    where 
        extract(month from d.created_at) = 2
        and 
        extract(year from d.created_at) = 2020
    group by c.title
    order by avg_rating desc
    limit 1
)

select customer_name from first_query
union all 
select title from second_query;

--- Ex11:
with friend as (
    select requester_id, accepter_id from RequestAccepted
    union all
    select accepter_id, requester_id from RequestAccepted
    )

select requester_id as id, count(*) as num from friend
group by id
order by num desc
limit 1

--- Ex12:
/* number of monthly active users
in July 2022 
*/
select 
  extract(month from curr_month.event_date) as mth, 
  count(distinct curr_month.user_id) as monthly_active_users 
from user_actions as curr_month
where exists (
  select last_month.user_id 
  from user_actions as last_month
  where last_month.user_id = curr_month.user_id
    and extract(month from last_month.event_date) =
    extract(month from curr_month.event_date - interval '1 month')
)
  and extract(month from curr_month.event_date) = 7
  and extract(year from curr_month.event_date) = 2022
group by extract(month from curr_month.event_date);

