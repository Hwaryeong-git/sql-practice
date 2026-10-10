-- LeetCode 1075. Project Employees I
-- 문제: https://leetcode.com/problems/project-employees-i/
-- 풀이 날짜: 2026-10-10
-- 연습: JOIN, GROUP BY, AVG, ROUND
-- 풀이: 프로젝트별 참여 직원의 평균 경력을 구하고 소수점 둘째 자리까지 반올림

SELECT p.project_id,
       ROUND(AVG(e.experience_years), 2) AS average_years
FROM Project AS p
LEFT JOIN Employee AS e
    ON p.employee_id = e.employee_id
GROUP BY p.project_id;
