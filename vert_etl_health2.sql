/*Query looks for yesterday's shipped units, there should be at least 50 units on a Sunday and at least 500 units on anyother day of the week, if not it will alert us*/




select 
ship_date
,DAYOFWEEK(ship_date)
,count(*)
from bitmp.ops_package
where ship_date >= current_date - 1
group by 1,2
having (count(*) > 50 and DAYOFWEEK(ship_date) in (1,7)) or (count(*) > 500 and DAYOFWEEK(ship_date) in (2,3,4,5,6))
order by 1
