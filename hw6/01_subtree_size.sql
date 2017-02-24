WITH RECURSIVE TreeSize AS (
  SELECT K.id AS root_id,
         K.id
  FROM Keyword K

  UNION ALL

  SELECT TS.root_id AS root_id,
         K.id
  FROM Keyword K
  JOIN TreeSize TS ON K.parent_id = TS.id
)
SELECT '#', root_id AS id, COUNT(1) AS size
FROM TreeSize
GROUP BY root_id
ORDER BY root_id;
