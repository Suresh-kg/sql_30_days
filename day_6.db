

WITH t AS (
    SELECT
        user_id,
        order_date,
        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY order_date
        ) AS rn
    FROM orders
),
grp AS (
    SELECT
        user_id,
        order_date,
        order_date - rn AS grp_id
    FROM t
)
SELECT DISTINCT user_id
FROM grp
GROUP BY user_id, grp_id
HAVING COUNT(*) >= 3;
