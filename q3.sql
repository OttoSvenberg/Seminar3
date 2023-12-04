SELECT
    instructor.instructor_id,
    instructor.first_name,
    instructor.last_name,
    COUNT(lesson.lesson_id) AS total_lessons
FROM
    instructor
JOIN
    lesson ON instructor.instructor_id = lesson.instructor_id
WHERE
    lesson.start_time >= '2023-12-01'::timestamp
    AND lesson.start_time < '2023-12-28'::timestamp
GROUP BY
    instructor.instructor_id, instructor.first_name, instructor.last_name
HAVING
    COUNT(lesson.lesson_id) > 2
ORDER BY
    total_lessons DESC;