/*Query looks for yesterday's shipped units, there should be at least 50 units on a Sunday and at least 500 units on anyother day of the week, if not it will alert us*/




select 
date_trunc('day',start_time)
,DAYOFWEEK(start_time)
,count(*)
from  raw_sources.cdr_main
where start_time >= current_date - 3
group by 1,2
having (count(*) > 200 and DAYOFWEEK(start_time) in (1,7)) or (count(*) > 200 and DAYOFWEEK(start_time) in (2,3,4,5,6))
order by 1
