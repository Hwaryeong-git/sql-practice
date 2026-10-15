-- =====================================================================
-- [LeetCode] 184. Department Highest Salary
-- 🔗 문제 링크: https://leetcode.com/problems/department-highest-salary/
-- 📅 풀이 날짜: 2026-10-16
-- 🏷️ 사용 개념: WITH+JOIN, Window Function, Correlated Subquery (자기연관/서브쿼리)
-- =====================================================================

/*
  [문제 요약]
  각 부서에서 가장 높은 급여를 받는 직원의 정보(부서 이름, 직원 이름, 급여)를 조회하는 문제.
*/


-- =====================================================================
-- [방법 1] CTE(최대 급여 목록) + JOIN 방식
-- 💡 접근 방식: 부서별 최대 급여 테이블을 먼저 만들고 원본과 조인하기
-- =====================================================================

WITH HighestSalary AS (
    SELECT departmentId, MAX(salary) AS max_salary
    FROM Employee
    GROUP BY departmentId
)
SELECT 
    d.name AS Department,
    e.name AS Employee,
    e.salary AS Salary
FROM Employee e
JOIN HighestSalary hs 
    ON e.departmentId = hs.departmentId 
    AND e.salary = hs.max_salary
JOIN Department d 
    ON e.departmentId = d.id;


-- =====================================================================
-- [방법 2] CTE + DENSE_RANK() 윈도우 함수 방식 (가장 추천하는 깔끔한 방식)
-- 💡 접근 방식: 부서별로 급여 순위를 매겨 1등(rk = 1)만 뽑은 뒤 부서명 조인
-- =====================================================================

WITH RankedEmployee AS (
    SELECT 
        name AS Employee,
        salary,
        departmentId,
        DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS rk
    FROM Employee
)
SELECT 
    d.name AS Department,
    re.Employee,
    re.salary AS Salary
FROM RankedEmployee re
JOIN Department d ON re.departmentId = d.id
WHERE re.rk = 1;


-- =====================================================================
-- [방법 3] WHERE 절 상관 서브쿼리 (자기 참조 / 연관 방식)
-- 💡 접근 방식: 직원 한 명씩 돌면서 "내 부서의 최고 급여와 내 급여가 같니?" 비교하기
-- =====================================================================

SELECT 
    d.name AS Department,
    e.name AS Employee,
    e.salary AS Salary
FROM Employee e
JOIN Department d ON e.departmentId = d.id
WHERE e.salary = (
    SELECT MAX(salary)
    FROM Employee
    WHERE departmentId = e.departmentId
);
