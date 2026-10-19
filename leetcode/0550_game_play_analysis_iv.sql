-- LeetCode 550. Game Play Analysis IV
-- 문제: https://leetcode.com/problems/game-play-analysis-iv/
-- 풀이 날짜: 2026-10-20
-- 연습: CTE, MIN, GROUP BY, LEFT JOIN, DATEDIFF, COUNT, ROUND
-- 풀이: 플레이어별 첫 접속일을 구하고, 바로 다음 날 재접속한 플레이어의 비율 계산

WITH first_login AS (
    SELECT player_id,
           MIN(event_date) AS first_date
    FROM Activity
    GROUP BY player_id
)
SELECT ROUND(
           COUNT(a.player_id) / COUNT(*),
           2
       ) AS fraction
FROM first_login AS f
LEFT JOIN Activity AS a
    ON f.player_id = a.player_id
   AND DATEDIFF(a.event_date, f.first_date) = 1;
