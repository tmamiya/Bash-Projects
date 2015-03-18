/*Query looks for yesterday's shipped units, there should be at least 50 units on a Sunday and at least 500 units on anyother day of the week, if not it will alert us*/




select 
date_trunc('day',created_at)
,DAYOFWEEK(created_at)
,count(*)
from  raw_sources.assistly_cases
where created_at >= current_date - 1
group by 1,2
having (count(*) > 100 and DAYOFWEEK(created_at) in (1,7)) or (count(*) > 100 and DAYOFWEEK(created_at) in (2,3,4,5,6))
order by 1
