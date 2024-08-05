--- Ex1:
select name from city
where countrycode = 'USA' and population > 120000; 

--- Ex2:
select * from city
where countrycode = 'JPN';

--- Ex3:
select city, state from station;

--- Ex4:
select city from station
where city like 'A%' or city like 'E%' or city like 'I%' or city like 'O%' or city like 'U%';

--- Ex5:
select distinct city from station
where city like '%A' or city like '%E' or city like '%I' or city like '%O' or city like '%U';

--- Ex6:
select distinct city from station
where city not like 'A%' and city not like 'E%' and city not like 'I%' and city not like 'O%' and city not like 'U%'; --- khúc này phải là and không phải or

--- Ex7:
select name from Employee
order by name asc; 

--- Ex8:
select name from employee
where salary > 2000 and months < 10
order by employee_id;

--- Ex9:
select product_id from products
where low_fats = 'Y' and recyclable = 'Y'
order by product_id asc;

--- Ex10:
select name from customer
where not referee_id = 2 or referee_id is null;

--- Ex11:
select name, population, area from world
where area >= 3000000 or population >= 25000000
order by name asc;

--- Ex12:
select distinct author_id as id from views
where viewer_id = author_id
order by author_id asc;

--- Ex13:
select part, assembly_step from parts_assembly
where finish_date is null;

--- Ex14:
select * from lyft_drivers
where yearly_salary < 30000 or yearly_salary > 70000;

--- Ex15:
select advertising_channel from uber_advertising
where money_spent > 100000 and year = 2019;
