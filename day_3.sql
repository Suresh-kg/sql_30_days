
#stage : 1

select 
        user_id,
        status,
        lag(status) over(
        partition by user_id
        order by txn_date
    ) as past
from transactions 

#stage : 2

select distinct user_id
from (
    select *,
    lag(status) over(
        partition by user_id
        order by txn_date
    ) as past
from transactions 
) t where status = 'SUCCESS' and past = 'FAILED'
