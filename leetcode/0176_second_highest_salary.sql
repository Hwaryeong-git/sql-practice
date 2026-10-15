-- =====================================================================
-- [LeetCode] 176. Second Highest Salary
-- 🔗 문제 링크: https://leetcode.com/problems/second-highest-salary/
-- 📅 풀이 날짜: 2026-10-16
-- 🏷️ 사용 개념: MAX 서브쿼리, LIMIT/OFFSET, DENSE_RANK 윈도우 함수
-- =====================================================================

/*
  [문제 요약]
  Employee 테이블에서 두 번째로 높은 급여(Salary)를 조회하는 문제.
  만약 두 번째로 높은 급여가 없으면 NULL을 리턴해야 함.
*/


-- =====================================================================
-- [방법 1] MAX() + 서브쿼리 방식 (가장 직관적이고 입문자에게 추천하는 방식)
-- 💡 접근 방식: 전체 1등을 제외한 나머지 사람들 중에서 가장 큰 값(2등)을 구함
-- =====================================================================

SELECT MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary < (
    SELECT MAX(salary) 
    FROM Employee
);


-- =====================================================================
-- [방법 2] LIMIT & OFFSET 방식 (정렬 후 건너뛰기 방식)
-- 💡 접근 방식: 급여를 내림차순 정렬한 뒤, 1등을 1개 건너뛰고(OFFSET 1) 딱 1개 가져오기(LIMIT 1)
--             * 데이터가 없을 때 NULL을 보장하기 위해 바깥쪽 SELECT로 감싸줌
-- =====================================================================

SELECT (
    SELECT DISTINCT salary 
    FROM Employee 
    ORDER BY salary DESC 
    LIMIT 1 OFFSET 1
) AS SecondHighestSalary;


-- =====================================================================
-- [방법 3] DENSE_RANK() 윈도우 함수 방식
-- 💡 접근 방식: 전체 급여 순위를 매긴 가상 테이블을 만든 뒤, 순위가 2인(rk = 2) 값을 추출
-- =====================================================================

WITH RankedSalary AS (
    SELECT salary,
           DENSE_RANK() OVER (ORDER BY salary DESC) AS rk
    FROM Employee
)
SELECT MAX(salary) AS SecondHighestSalary
FROM RankedSalary
WHERE rk = 2;
