

# stage: 1
  
select activity_date, count(distinct(user_id)) as id
from user_activity
group by activity_date

  
# stage: 2
  
WITH daily_dau AS (
    SELECT
        activity_date,
        COUNT(DISTINCT user_id) AS daily_active_users
    FROM user_activity
    GROUP BY activity_date
)
SELECT
    activity_date,
    daily_active_users,
    AVG(daily_active_users) OVER (
        ORDER BY activity_date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS rolling_7_day_avg
FROM daily_dau
ORDER BY activity_date;
