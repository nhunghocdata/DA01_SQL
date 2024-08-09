--- Ex1:
/* Output: name + order by last 3 characters or id asc
Input: name, marks, id
Condition: score > 75 */
select name
from students
where marks > 75
order by right(name, 3), ID asc

--- Ex2: 
/* Output: first character is uppercase + order by user_id
Input: user_id + name
Condition: NA */
select 
user_id,
concat(upper(left(name,1)),lower(right(name, length(name)-1))) as name 
from users

--- Ex3:
/* total drug sales for each manufacturer
round to nearest million
order by total sales DESC
output: total_sales 
input: total_sales + manufacturer
condition: group by manufacturer */
select manufacturer,
concat('$',round(sum(total_sales)/1000000,0),' ','million') as total_sale
from pharmacy_sales
group by manufacturer
order by sum(total_sales) desc

--- Ex4:
/* average star rating for each product
grouped by month as a numerical value
product ID, and average star rating rounded to two decimal
Sort the output first by month and then by product ID

output: avg star rating, month
input: submit_date, stars
condition: group by month */

select
product_id,
extract(month from submit_date) as rated_month,
round(avg(stars),2)
from reviews
group by rated_month, product_id
order by rated_month, product_id

--- Ex5:
/* top 2 Power Users who sent the highest number of messages in August 2022
Display the IDs of these 2 users + total number of messages 
output: sender_id, no_of_messages
input: sent_date, sender_id, message_id */

select sender_id,
count(message_id) as message_count
from messages
where extract(month from sent_date) = 8
and extract(year from sent_date) = 2022
group by sender_id
order by message_count desc
limit (2)

--- Ex6:
/* find the IDs of the invalid tweets
the number of characters > 15 => invalid 
output: tweet_id, length of content
input: content, tweet_id
condition: length of content > 15 */

select tweet_id
from tweets
where length(content) > 15

--- Ex7:
/* find the daily active user
count for a period of 30 days ending 2019-07-27 */
select activity_date as day, 
count(distinct(user_id)) as active_users 
from activity
where activity_date between "2019-06-28" and "2019-07-27"
group by activity_date

--- Ex8: 
/* the number of employees hired
between the months of January and July in the year 2022 */
select 
count(distinct(id)) 
from employees
where joining_date between '2022-01-01' and '2022-07-01'

--- Ex9:
select 
position('a' in first_name) as where_is_a
from worker
where first_name = 'Amitah'

--- Ex10:
/* output: winery, year 
input: winery, title
condition: province = 'Macedonia' */
---select * from winemag_p2
select winery,
substring(title from length(winery)+2 for 4) as production_year
from winemag_p2
where country = 'Macedonia'













