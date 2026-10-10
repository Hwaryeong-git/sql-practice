-- LeetCode 570. Managers with at Least 5 Direct Reports
-- 문제: https://leetcode.com/problems/managers-with-at-least-5-direct-reports/
-- 풀이 날짜: 2026-10-09
-- 연습: 셀프 JOIN, GROUP BY, HAVING, COUNT
-- 풀이: 관리자별 직속 직원 수가 5명 이상인 경우 조회

SELECT m.name
FROM Employee AS e
LEFT JOIN Employee AS m
    ON e.managerId = m.id
WHERE m.id IS NOT NULL
GROUP BY m.id, m.name
HAVING COUNT(e.id) >= 5;
