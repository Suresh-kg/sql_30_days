
# stage : 1

With t AS (
    select 
        category, 
        product_id, 
        (quantity * price) as total_revenue
    from orders
),
ranked as (
    select 
        category, 
        product_id, 
        total_revenue,
        row_number() over(
            partition by category
            order by total_revenue desc
        ) as rn
    from t
) 

select 
    category, 
    product_id, 
    total_revenue 
from ranked
where rn <= 2 



# my ans

WITH t AS (
    SELECT
        category,
        product_id,
        sum((quantity * price)) AS total_revenue
    FROM orders
    group by category, product_id
),
ranked AS (
    SELECT
        category,
        product_id,
        total_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY total_revenue DESC
        ) AS rn
    FROM t
)
SELECT category, product_id, total_revenue
FROM ranked
WHERE rn <= 3
order by  total_revenue desc


## gpt 

WITH product_revenue AS (
    SELECT
        category,
        product_id,
        SUM(quantity * price) AS total_revenue
    FROM orders
    GROUP BY category, product_id
),
ranked_products AS (
    SELECT
        category,
        product_id,
        total_revenue,
        DENSE_RANK() OVER (
            PARTITION BY category
            ORDER BY total_revenue DESC
        ) AS rn
    FROM product_revenue
)
SELECT
    category,
    product_id,
    total_revenue
FROM ranked_products
WHERE rn <= 3;
