WITH sent_requests AS (
    SELECT
        date AS sent_date,
        user_id_sender,
        user_id_receiver
    FROM action_table
    WHERE action = 'sent'
),
accepted_requests AS (
    SELECT DISTINCT
        user_id_sender,
        user_id_receiver
    FROM action_table
    WHERE action = 'accepted'
)
SELECT
    s.sent_date,
    ROUND(
        COUNT(a.user_id_sender) * 1.0 / COUNT(*),
        2
    ) AS acceptance_rate
FROM sent_requests s
LEFT JOIN accepted_requests a
    ON s.user_id_sender = a.user_id_sender
   AND s.user_id_receiver = a.user_id_receiver
GROUP BY s.sent_date
HAVING COUNT(a.user_id_sender) > 0
ORDER BY s.sent_date;