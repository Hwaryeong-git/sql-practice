-- =====================================================================
-- [LeetCode] 1633. Percentage of Users Attended a Contest
-- 문제 링크: https://leetcode.com/problems/percentage-of-users-attended-a-contest/
-- 풀이 날짜: 2026-10-16
-- 사용 개념: GROUP BY, COUNT(DISTINCT), 서브쿼리, 산술 연산
-- =====================================================================

-- [문제 요약]
-- 각 콘테스트에 등록(참여)한 유저의 비율(%)을 전체 유저 대비 백분율로 구하는 문제.
-- 정답은 percentage 기준 내림차순, contest_id 기준 오름차순 정렬.

SELECT 
    contest_id,
    ROUND(COUNT(DISTINCT user_id) * 100.0 / (SELECT COUNT(*) FROM Users), 2) AS percentage
FROM 
    Register
GROUP BY 
    contest_id
ORDER BY 
    percentage DESC, 
    contest_id ASC;
