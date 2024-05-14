
WITH CTE AS(SELECT first_player AS player, first_score AS score FROM Matches
UNION ALL
SELECT second_player AS player, second_score AS score FROM Matches)
,ACTE AS 
(SELECT c.player, SUM(c.score) AS score, p.group_id FROM CTE c
JOIN Players p
ON c.player = p.player_id
GROUP BY c.player)



SELECT group_id,player_id FROM
(SELECT group_id, player AS player_id, ROW_NUMBER() OVER(PARTITION BY group_id ORDER BY score DESC, player) as rn
FROM ACTE) a
WHERE a.rn = 1


-- Another way

SELECT group_id, player_id FROM
(SELECT p.group_id, p.player_id, RANK() OVER(PARTITION BY p.group_id ORDER BY SUM(
    CASE WHEN p.player_id = m.first_player THEN m.first_score
    ELSE m.second_score
    END
) DESC, p.player_id ASC) AS rnk FROM Players p 
JOIN Matches m 
ON p.player_id IN (m.first_player,m.second_player) 
GROUP BY p.group_id,p.player_id) AS intermediate
WHERE rnk = 1
