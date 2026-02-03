

SELECT driver_id
FROM (
SELECT
    driver_id,
    date,
    cnt,
    past,
    d_past,
    CASE
        WHEN past IS NULL THEN 0
        WHEN cnt <= past THEN 1
        ELSE 0
    END AS is_bad
FROM (
    SELECT
        driver_id,
        date,
        cnt,
        LAG(cnt) OVER (
            PARTITION BY driver_id
            ORDER BY date
        ) AS past,
        LAG(date) OVER (
            PARTITION BY driver_id
            ORDER BY date
        ) AS d_past
    FROM (
        SELECT
            driver_id,
            DATE_FORMAT(ride_date, '%Y-%m') AS date,
            COUNT(*) AS cnt
        FROM rides
        GROUP BY driver_id, DATE_FORMAT(ride_date, '%Y-%m')
    ) t
) x) z

GROUP BY driver_id
HAVING SUM(is_bad) = 0;
