-- =====================================================================
-- [LeetCode] 1907. Count Salary Categories
-- 🔗 문제 링크: https://leetcode.com/problems/count-salary-categories/description/
-- 📅 풀이 날짜: 2026-10-18
-- 🏷️ 사용 개념: UNION ALL, CTE, LEFT JOIN, Aggregation
-- =====================================================================

/*
  [문제 요약]
  Accounts 테이블의 소득(income)을 기준으로 세 가지 카테고리(Low Salary, Average Salary, High Salary)로 분류하고,
  각 카테고리별 계좌의 수를 구하는 문제.
  특정 카테고리에 데이터가 존재하지 않더라도 결과에 반드시 포함되어야 하며, 개수는 0으로 출력되어야 함.
*/


-- =====================================================================
-- [방법 1] UNION ALL 방식 (추천)
-- 💡 접근 방식: 세 카테고리 조건에 맞는 데이터를 각각 구한 뒤 UNION ALL로 합침.
--               데이터가 없는 카테고리도 COUNT(*) 시 0이 반환되므로 누락을 방지함.
-- =====================================================================

SELECT 
    'Low Salary' AS category,
    COUNT(*) AS accounts_count
FROM Accounts
WHERE income < 20000

UNION ALL

SELECT 
    'Average Salary' AS category,
    COUNT(*) AS accounts_count
FROM Accounts
WHERE income >= 20000 AND income <= 50000

UNION ALL

SELECT 
    'High Salary' AS category,
    COUNT(*) AS accounts_count
FROM Accounts
WHERE income > 50000;


-- =====================================================================
-- [방법 2] CTE + LEFT JOIN 방식
-- 💡 접근 방식: 세 가지 카테고리명을 가진 기준 테이블(CTE)을 만든 뒤, 
--               원본 테이블을 LEFT JOIN하여 데이터가 없어도 카테고리가 사라지지 않도록 방어함.
--               매칭 실패 시 NULL이 되므로 COUNT(컬럼명)을 사용하여 0으로 집계되도록 처리.
-- =====================================================================

WITH Categories AS (
    SELECT 'Low Salary' AS category
    UNION ALL
    SELECT 'Average Salary'
    UNION ALL
    SELECT 'High Salary'
)
SELECT 
    c.category,
    COUNT(a.account_id) AS accounts_count
FROM Categories c
LEFT JOIN Accounts a ON (
    (c.category = 'Low Salary' AND a.income < 20000) OR
    (c.category = 'Average Salary' AND a.income BETWEEN 20000 AND 50000) OR
    (c.category = 'High Salary' AND a.income > 50000)
)
GROUP BY c.category;
