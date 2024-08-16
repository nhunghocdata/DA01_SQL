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
