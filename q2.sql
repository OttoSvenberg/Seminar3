SELECT
  COALESCE(CASE WHEN sibling_count IS NULL THEN 'No Siblings' ELSE
                CASE WHEN sibling_count = 1 THEN 'One Sibling' ELSE 'Two Siblings' END
           END, 'No Siblings') AS SiblingStatus,
  COUNT(*) AS NumberOfStudents
FROM (
  SELECT student_id, COUNT(student_id2) AS sibling_count
  FROM sibling
  GROUP BY student_id
) AS SiblingCounts
RIGHT JOIN student ON SiblingCounts.student_id = student.student_id
GROUP BY SiblingStatus
ORDER BY SiblingStatus;