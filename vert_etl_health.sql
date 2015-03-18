/*Query looks for yesterday's shipped units, there should be at least 100 units on a Sunday and at least 500 units on anyother day of the week, if not it will alert us*/

select 
date(datetime_ship)
,DAYOFWEEK(datetime_ship)
/*1=Sunday, 7=Sat*/
,sum(qty) as units_bo
,sum(retail) as retail
from analytics.salesline_based_shipping
where date(datetime_ship) >= current_date - 1
group by 1,2
having (sum(qty) > 80 and DAYOFWEEK(datetime_ship) = 1) or (sum(qty) > 500 and DAYOFWEEK(datetime_ship) in (2,3,4,5,6,7))
order by 1
