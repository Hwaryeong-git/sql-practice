-- LeetCode 619. Biggest Single Number
-- 문제: https://leetcode.com/problems/biggest-single-number/
-- 풀이 날짜: 2026-10-14
-- 연습: GROUP BY, HAVING, COUNT, MAX, 서브쿼리
-- 풀이: 한 번만 등장한 숫자 중 최댓값을 구하고, 해당 숫자가 없으면 NULL 반환

SELECT MAX(num) AS num
FROM (
    SELECT num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(*) = 1
) AS singles;
