--- Ex1:
with tb1 as (select 
  extract(year from transaction_date) as year,
  product_id,
  spend as current_year,
  lag(spend) over(partition by product_id order by product_id) as previous_year
from user_transactions)

select year, product_id, current_year, previous_year,
round(100*(current_year - previous_year)/previous_year,2) as yoy_rate
from tb1

--- Ex2: 
/* output: name of card, count issue in each month, 
order by issued_amount */
with launch_month as (select card_name,
issued_amount,
make_date(issue_year, issue_month, 1) as issue_date,
min(make_date(issue_year, issue_month, 1)) over(partition by card_name) as launch_date
from monthly_cards_issued)

select card_name, issued_amount
from launch_month
where issue_date = launch_date
order by issued_amount desc

--- Ex3:
/* output: third transaction of every user
*/
with number as 
(select user_id, spend, transaction_date,
row_number() over(partition by user_id order by transaction_date) as num
from transactions)

select user_id, spend, transaction_date
from number
where num = 3

--- Ex4: 
/* most recent transaction date
the users along with the number of products they bought
*/
with ranking_trans as (select product_id, user_id, spend, transaction_date,
rank() over(partition by user_id order by transaction_date) as ranking 
from user_transactions)

select * from ranking_trans
where ranking = 1

--- Ex5:
/* Output: user_id, tweet date, rolling averages rounded to 2 decimal places
*/
select user_id, tweet_date,
---avg(tweet_count) over(partition by user_id order by tweet_date) as
---rolling_avg,
tweet_count,
lead(tweet_count,1) over(partition by user_id order by tweet_date) as day2,
lead(tweet_count,2) over(partition by user_id order by tweet_date) as day3,
from tweets

--- Ex6: 
/* merchant_id = credit_card_id = amount 
within 10 minutes 
*/
with calculation as (select transaction_id, merchant_id, credit_card_id, amount, transaction_timestamp,
round(extract(epoch from transaction_timestamp - lag(transaction_timestamp) over(partition by merchant_id, credit_card_id, amount
order by transaction_timestamp))/60,1) as diff 
from transactions)
select count(merchant_id) as payment_count
from calculation
where diff <=10

--- Ex7: 
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
limit 2),

selling_electronics as ( 
select category, product,
sum(spend) as total_spend 
from product_spend
where extract(year from transaction_date) = 2022
and category = 'electronics'
group by category, product
order by total_spend DESC
limit 2),

select category, product, total_spend from selling_appliance
union all 
select category, product, total_spend from selling_electronics

--- Ex8:
/* output: top 5 artists whose songs appear most frequently in the Top 10
ascending order, along with their song appearance ranking */
with top_10 as (select a.artist_name, c.rank, b.name, 
dense_rank() over(order by count (b.song_id) desc) as artist_rank
from artists a
join songs b 
on a.artist_id = b.artist_id
join global_song_rank c 
on b.song_id = c.song_id
where c.rank <= 10
group by a.artist_name, c.rank, b.name)

select artist_name, artist_rank from top_10
where artist_rank <= 5
