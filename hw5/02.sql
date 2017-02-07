WITH
WeeklyCompanyGrowth AS (
  SELECT week, company, share_price - FIRST_VALUE(share_price) OVER (PARTITION BY company
                                                                     ORDER BY week ASC
                                                                     ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) as growth
  FROM StockQuotes
),
WeeklyIndex AS (
  SELECT week, AVG(growth) as index
  FROM WeeklyCompanyGrowth
  GROUP BY week
),
CompanySuccess AS (
  SELECT wcg.company, wcg.week, CASE WHEN wcg.growth > i.index THEN 1 ELSE 0 END as was_success
  FROM WeeklyCompanyGrowth wcg JOIN WeeklyIndex i ON wcg.week = i.week
  ORDER BY company, week ASC
),
CompanyPeriods AS (
  SELECT company, SUM(was_success) OVER (PARTITION BY company
                                         ORDER BY week ASC
                                         ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as success_rate
  FROM CompanySuccess
)
SELECT company, COUNT(*)
FROM CompanyPeriods
WHERE success_rate = 3
GROUP BY company
HAVING COUNT(*) > 0
ORDER BY COUNT(*), company ASC;
