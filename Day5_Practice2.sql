--- Ex1:
select city from station
where id%2=0;

--- Ex2:
select count(city) - count (distinct(city)) from station

--- Ex4:
select sum(item_count * order_occurrences)/sum(order_occurrences) as mean
from items_per_order

--- Ex5:
select round(cast(sum(item_count * order_occurrences)/sum(order_occurrences) as decimal),1) as mean
from items_per_order;

--- Ex6: 
/* find number of days between first post and last post of each users */
select user_id, max(post_date) - min(post_date) as no_of_days
from posts
where post_date >= '2021-01-01' and post_date <= '2022-01-01'
group by user_id;

--- Ex7:
/* name credit card + 
difference in the number of issued cards between the month with the highest issuance cards 
and the lowest issuance */
select card_name,
(max(issued_amount) - min(issued_amount)) as differences
from monthly_cards_issued
group by card_name
order by differences desc;

--- Ex8:
/* the manufacturers associated with the drugs
 calculate the total amount of losses incurred
 the total losses in absolute value
 sorted in descending order */
select manufacturer, 
count(drug) as no_of_drugs,
sum(total_sales - cogs) as net_loss
from pharmacy_sales
where total_sales - cogs <=0
group by manufacturer
order by net_loss desc;

--- Ex9:
/* odd-numbered ID 
a description that is not "boring"
ordered by rating in descending */
select id, movie, description, rating
from cinema
where id % 2 = 1 and description != 'boring'
group by id, movie, description, rating
order by rating desc;

--- Ex10:
select teacher_id,
count(distinct subject_id) as subject 
from teacher 

--- Ex11:
/* the number of followers
ordered by user_id in ascending */
select user_id,
count(follower_id) as followers_count
from followers
group by user_id
order by user_id asc;

--- Ex12:
/* find all the classes that have at least five students */
select class,
count(student)
from Courses
group by class
having count(student) >= 5
