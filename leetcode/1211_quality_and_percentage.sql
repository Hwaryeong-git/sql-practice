-- LeetCode 1211. Queries Quality and Percentage
-- 문제: https://leetcode.com/problems/queries-quality-and-percentage/
-- 풀이 날짜: 2026-10-12
-- 연습: GROUP BY, AVG, CASE WHEN, ROUND
-- 풀이: 쿼리 이름별로 그룹화하여 평가 점수와 위치의 비율 평균(quality)을 구하고, 평점이 3 미만인 쿼리의 비율(poor_query_percentage)을 퍼센트로 계산

SELECT query_name,
       ROUND(AVG(rating / position), 2) AS quality,
       ROUND(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS poor_query_percentage
FROM Queries
GROUP BY query_name;
