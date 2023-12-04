SELECT
    TO_CHAR(months, 'Mon') AS Month,
    COUNT(*) AS Total,
    COALESCE(SUM(CASE WHEN i_lessons.lesson_id IS NOT NULL THEN 1 ELSE 0 END), 0) AS Individual,
    COALESCE(SUM(CASE WHEN g_lessons.lesson_id IS NOT NULL THEN 1 ELSE 0 END), 0) AS Group,
    COALESCE(SUM(CASE WHEN e_lessons.lesson_id IS NOT NULL THEN 1 ELSE 0 END), 0) AS Ensamble
FROM
    generate_series(
        '2023-01-01'::timestamp,
        '2023-12-31'::timestamp,
        '1 month'::interval
    ) AS months
LEFT JOIN
    lesson ON EXTRACT(MONTH FROM lesson.start_time) = EXTRACT(MONTH FROM months)
LEFT JOIN
    individual_lessons i_lessons ON lesson.lesson_id = i_lessons.lesson_id
LEFT JOIN
    group_lesson g_lessons ON lesson.lesson_id = g_lessons.lesson_id
LEFT JOIN
    ensamble e_lessons ON lesson.lesson_id = e_lessons.lesson_id
WHERE
    EXTRACT(YEAR FROM months) = 2023
GROUP BY
    TO_CHAR(months, 'Mon')
ORDER BY
    MIN(EXTRACT(MONTH FROM months));