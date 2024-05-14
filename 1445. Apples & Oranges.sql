
SELECT sale_date, 
SUM(CASE WHEN fruit='apples' THEN sold_num 
WHEN fruit='oranges' THEN -1*sold_num end) AS diff
FROM Sales
GROUP BY sale_date
ORDER BY sale_date


-- Another way using cte

WITH CTE AS (SELECT sale_date, sold_num FROM Sales WHERE fruit = 'apples' ORDER BY sale_date)
,ACTE AS (SELECT sale_date, sold_num FROM Sales WHERE fruit='oranges' 
ORDER BY sale_date)

SELECT c.sale_date, c.sold_num - COALESCE((SELECT a.sold_num FROM ACTE a WHERE a.sale_date = c.sale_date),0) AS diff 
FROM CTE c
