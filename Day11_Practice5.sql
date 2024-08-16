--- Ex1:
/* output: names of all the continents + average city populations
input: population from city + name from country 
key: */
select b.continent, avg(a.population) 
from city as a
inner join country as b
on a.countrycode = b.code
group by b.continent

--- Ex2:
/* output: the activation rate + round to 2 decimal places
input: email-id, signup_action */

select 
round(count(b.email_id)/count(distinct a.email_id),2) as activation_rate
from emails as a 
left join texts as b 
on a.email_id = b.email_id 
where b.signup_action = 'Confirmed'

--- Ex3:
/* output: time spent sending/opening snaps (%)
group by age group 
input: time_spent, age_bucket 
condition: activity_type = 'open' / 'send'
key: user_id */
  
select
b.age_bucket,
sum(case 
      when a.activity_type = 'send' then a.time_spent 
      else 0 
    end) as send_timespent,
sum(case 
      when a.activity_type = 'open' then a.time_spent 
      else 0 
    end) as open_timespent
sum(a.time_spent) as total_timespent,
round(100.0 * send_timespent / total_timespent,2) as send_percentage,
round(100.0 * open_timespent / total_timespent,2) as open_percentage
from activities as a 
inner join age_breakdown as b 
on a.user_id = b.user_id
where a.activity_type in ('open','send')
group by b.age_bucket

--- Ex4:
select count(distinct product_category) from products

select a.customer_id,
count(distinct b.product_category) as product_count
from customer_contracts as a 
left join products as b 
on a.product_id = b.product_id
group by a.customer_id
having count(distinct b.product_category) = 3

--- Ex5:
/* output: id + name all managers + no of employee */
select a.reports_to,
       b.name,
       count(a.reports_to) as reports_count,
       round(avg(a.age),0) as average_age
from employees as a
left join employees as b
on a.reports_to = b.reports_to
group by a.reports_to
order by a.reports_to


