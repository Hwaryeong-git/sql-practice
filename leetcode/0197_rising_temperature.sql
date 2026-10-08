-- LeetCode 197. Rising Temperature
-- 문제: https://leetcode.com/problems/rising-temperature/
-- 풀이 날짜: 2026-10-09
-- 연습: 셀프 JOIN, DATEDIFF

SELECT t.id
FROM Weather AS t
LEFT JOIN Weather AS y
    ON DATEDIFF(t.recordDate, y.recordDate) = 1
WHERE t.temperature > y.temperature;
