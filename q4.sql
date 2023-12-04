SELECT
    CASE TO_CHAR(l.start_time, 'Dy')
        WHEN 'Mon' THEN 'Monday'
        WHEN 'Tue' THEN 'Tuesday'
        WHEN 'Wed' THEN 'Wednesday'
        WHEN 'Thu' THEN 'Thursday'
        WHEN 'Fri' THEN 'Friday'
        ELSE 'Other'
    END AS weekday,
    e.genre,
    CASE
        WHEN CAST(e.amount_of_students AS INTEGER) >= CAST(e.max_students AS INTEGER) THEN 'Full Booked'
        WHEN CAST(e.amount_of_students AS INTEGER) >= CAST(e.max_students AS INTEGER) - 2 THEN '1-2 Seats Left'
        ELSE 'More Seats Left'
    END AS availability
FROM
    ensamble e
JOIN
    lesson l ON e.lesson_id = l.lesson_id
WHERE
    l.start_time >= CURRENT_DATE
    AND l.start_time < CURRENT_DATE + INTERVAL '1 week'
ORDER BY
    CASE TO_CHAR(l.start_time, 'Dy')
        WHEN 'Mon' THEN 1
        WHEN 'Tue' THEN 2
        WHEN 'Wed' THEN 3
        WHEN 'Thu' THEN 4
        WHEN 'Fri' THEN 5
        ELSE 6
    END, e.genre;