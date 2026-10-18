-- =====================================================================
-- [LeetCode] 585. Investments in 2016
-- 🔗 문제 링크: https://leetcode.com/problems/investments-in-2016/description/
-- 📅 풀이 날짜: 2026-10-18
-- 🏷️ 사용 개념: Subquery, IN (Multi-column), Window Function (COUNT OVER PARTITION BY)
-- =====================================================================

/*
  [문제 요약]
  1. 2015년 투자금액(tiv_2015)이 다른 가입자 중 한 명 이상과 겹치는 경우
  2. 위도/경도(lat, lon) 위치 쌍이 다른 가입자와 겹치지 않고 유일한 경우
  위 두 가지 조건을 모두 만족하는 가입자들의 2016년 투자금액(tiv_2016) 총합을 구하고,
  소수점 둘째 자리까지 반올림(ROUND)하는 문제.
*/


-- =====================================================================
-- [방법 1] 서브쿼리 + IN 방식 (전통적인 집계 및 필터링 방식)
-- 💡 접근 방식: 
-- 1. 2015년 금액이 2명 이상에게 존재하는 tiv_2015 목록을 구해 IN으로 매칭
-- 2. 위도와 경도 쌍이 딱 1명에게만 존재하는 유일한 (lat, lon) 목록을 구해 다중 컬럼 IN으로 매칭
-- =====================================================================

SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM Insurance
WHERE tiv_2015 IN (
    SELECT tiv_2015
    FROM Insurance
    GROUP BY tiv_2015
    HAVING COUNT(*) > 1
)
AND (lat, lon) IN (
    SELECT lat, lon
    FROM Insurance
    GROUP BY lat, lon
    HAVING COUNT(*) = 1
);


-- =====================================================================
-- [방법 2] 윈도우 함수 (COUNT OVER PARTITION BY) 방식
-- 💡 접근 방식: 
-- 1. 원본 행을 깨뜨리지 않고 각 행마다 조건별 인원수(tiv_count, loc_count)를 윈도우 함수로 계산
-- 2. CTE를 통해 임시 테이블 형태로 감싼 뒤, 바깥에서 필요한 조건만 필터링하여 합산
-- =====================================================================

WITH Stats AS (
    SELECT 
        tiv_2016,
        COUNT(*) OVER (PARTITION BY tiv_2015) AS tiv_count,
        COUNT(*) OVER (PARTITION BY lat, lon) AS loc_count
    FROM Insurance
)
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM Stats
WHERE tiv_count > 1
  AND loc_count = 1;
