
WITH CTE AS (SELECT product_id, min(year) AS first_year FROM Sales GROUP BY product_id)

Select s.product_id, s.year AS first_year, s.quantity, s.price FROM Sales s
HAVING s.year = (SELECT first_year FROM CTE c WHERE s.product_id = c.product_id)
ORDER BY product_id