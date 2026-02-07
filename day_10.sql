

stagge: 1

with t as(
    select 
        user_id,
        txn_date,
        amount,
        count(txn_date) over(
            partition by user_id, txn_date
            order by user_id
        )as date
        from transactions
)

select 
    user_id,
    txn_date,	
    date,
    sum(amount) as amt
    
from t
group by user_id,
    txn_date,	
    date
having sum(amount) > 10000 and date >= 3

#optimal solution

SELECT
    user_id,
    txn_date,
    COUNT(*) AS txn_count,
    SUM(amount) AS total_amount
FROM transactions
GROUP BY user_id, txn_date
HAVING COUNT(*) >= 3
   AND SUM(amount) > 10000;
