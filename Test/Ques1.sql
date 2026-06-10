SELECT 7 AS month, COUNT(DISTINCT user_id) AS monthly_active_users
FROM user_actions
WHERE event_date >= DATE '2022-07-01'
  AND event_date <= DATE '2022-07-31'
  AND user_id IN (
    SELECT user_id FROM user_actions
    WHERE event_date >= '2022-06-01'
      AND event_date <= '2022-06-30'
  );