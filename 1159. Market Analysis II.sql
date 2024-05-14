-- Write your MySQL query statement below
-- 2nd item sold by user and is it fav or not 

WITH CTE AS (SELECT o.seller_id, o.item_id, i.item_brand FROM
(SELECT seller_id,item_id,rank() OVER(PARTITION BY seller_id ORDER BY order_date) AS rnk 
FROM Orders) o
JOIN Items i 
ON o.item_id = i.item_id
WHERE o.rnk = 2)

SELECT u.user_id AS seller_id,
 IF(c.item_brand = u.favorite_brand, 'yes', 'no') AS 2nd_item_fav_brand
FROM CTE c 
RIGHT JOIN Users u 
ON c.seller_id = u.user_id


