--- Ex1
/* calculates the total viewership for laptops and mobile devices
mobile is defined as the sum of tablet and phone viewership
output: viewship for laptops + mobile
input: user_id , device_type , view_time
condition: 
*/
select 
sum(case 
  when device_type = 'tablet' then 1 
  when device_type = 'phone' then 1 
end) as mobile_views,
sum(case 
  when device_type = 'laptop' then 1 
end) as laptop_views
from viewership
group by mobile_views, laptop_views

--- Ex2: 
/* whether they can form a triangle 
output: x + y > z ; x + z > y ; y + z > x
input: x ; y ; z
*/
select *,
case
    when (x+y)>z and (x+z)>y and (y+z)>x then 'yes'
    else 'no'
end triangle_result
from triangle

--- Ex3: (still stuck here)
/* calculate the percentage of calls that cannot be categorised
round your answer to 1 decimal place
output: % null / call category * 100
input: call_category
*/
select (select count(case 
  when call_category is null then 1
  when call_category = 'n/a' then 1
end))/(select count(*) from callers)*100
from callers

--- Ex4:
select name from customer
where not referee_id = 2 or referee_id is null;

--- Ex5:
select
case 
    when pclass = 1 then 'first_class'
    when pclass = 2 then 'second_class'
    when pclass = 3 then 'third_class'
end as class_category,
sum(case 
    when survived = 0 then 1 else 0
end) as died,
sum(case 
    when survived = 1 then 1 else 0
end) as alived
from titanic
group by class_category
