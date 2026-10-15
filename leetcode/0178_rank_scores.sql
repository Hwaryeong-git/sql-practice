-- =====================================================================
-- [LeetCode] 178. Rank Scores
-- 🔗 문제 링크: https://leetcode.com/problems/rank-scores/
-- 📅 풀이 날짜: 2026-10-16
-- 🏷️ 사용 개념: Window Function (DENSE_RANK), 예약어(rank) 별칭 주의
-- =====================================================================

/*
  [문제 요약]
  점수(score)를 높은 순서대로 순위를 매기는 문제. 
  동점일 경우 같은 순위를 부여하고, 다음 순위는 건너뛰지 않고 이어짐(DENSE_RANK).
  
  [주의할 점]
  - `rank`는 SQL 예약어이므로 백틱(`` `rank` ``)으로 감싸거나 `score_rank` 같은 다른 별칭을 사용해야 함.
  - 전체 점수 기준 정렬이므로 `PARTITION BY`는 쓰지 않음.
*/

SELECT 
    score,
    DENSE_RANK() OVER (ORDER BY score DESC) AS score_rank
FROM Scores;
