SELECT a.value, COUNT(*)
FROM T a, T b
GROUP BY a.value
HAVING
  SUM(CASE WHEN b.value <= a.value THEN 1 ELSE 0 END) >= (COUNT(*) + 1) / 2
  AND
  SUM(CASE WHEN b.value >= a.value THEN 1 ELSE 0 END) >= (COUNT(*) / 2) + 1;
