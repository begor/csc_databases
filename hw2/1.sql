-- В файл /tmp/answer1 надо записать отсортированные лексикографически
-- названия конференций с неоднозначным местом проведения, по одной конференции на строку

SELECT conference FROM Paper GROUP BY conference HAVING COUNT(DISTINCT location) > 1;

-- В файл /tmp/answer2 надо записать одну строку -- название статьи, поданной на несуществующую конференцию.
SELECT title FROM Paper WHERE conference NOT IN (SELECT value FROM Conference);
