
# stage: 1

select *,
    lag(order_date) over(
        partition by user_id
        order by order_date
    ) as past
from orders

#stage : 2

SELECT user_id
FROM (
    SELECT
        user_id,
        order_date,
        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY order_date
        ) AS rn,
        LAG(order_date) OVER (
            PARTITION BY user_id
            ORDER BY order_date
        ) AS prev_order_date
    FROM orders
) t
WHERE rn = 2
  AND order_date - prev_order_date <= 7;
