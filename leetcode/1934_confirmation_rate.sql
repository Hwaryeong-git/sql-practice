-- LeetCode 1934. Confirmation Rate
-- 문제: https://leetcode.com/problems/confirmation-rate/
-- 풀이 날짜: 2026-10-10
-- 연습: LEFT JOIN, GROUP BY, CASE WHEN, COUNT, IFNULL, ROUND
--
-- 풀이:
-- 1. 가입자 기준으로 확인 요청을 LEFT JOIN
-- 2. 사용자별 confirmed 횟수를 전체 요청 횟수로 나눔
-- 3. 요청이 없으면 0 / 0의 결과가 NULL이므로 IFNULL로 0 처리
-- 4. 소수점 둘째 자리까지 반올림
--
-- 기억할 점:
-- COUNT(*)는 LEFT JOIN으로 남은 행도 계산
-- COUNT(c.action)은 NULL을 제외하여 실제 요청 횟수만 계산

SELECT s.user_id,
       ROUND(
           IFNULL(
               SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END)
               / COUNT(c.action),
               0
           ),
           2
       ) AS confirmation_rate
FROM Signups AS s
LEFT JOIN Confirmations AS c
    ON s.user_id = c.user_id
GROUP BY s.user_id;
