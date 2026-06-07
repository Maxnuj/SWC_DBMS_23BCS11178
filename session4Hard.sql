WITH events AS (
    SELECT DISTINCT start_time AS time_point, 1 AS delta
    FROM task_schedule
    WHERE start_time IS NOT NULL
      AND end_time IS NOT NULL

    UNION ALL

    SELECT DISTINCT end_time, -1
    FROM task_schedule
    WHERE start_time IS NOT NULL
      AND end_time IS NOT NULL
)

SELECT MAX(running) AS min_cpus_required
FROM (
    SELECT
        SUM(delta) OVER (
            ORDER BY time_point, delta
        ) AS running
    FROM events
) t;