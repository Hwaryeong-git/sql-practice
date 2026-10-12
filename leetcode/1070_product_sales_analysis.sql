-- LeetCode 1070. Product Sales Analysis III
-- 문제: https://leetcode.com/problems/product-sales-analysis-iii/
-- 풀이 날짜: 2026-10-12
-- 연습: 서브쿼리, MIN(), JOIN, GROUP BY
-- 풀이: 각 상품별로 가장 첫 판매 연도(MIN(year))를 구하는 서브쿼리를 작성하고, 원본 테이블과 JOIN하여 첫 판매 연도에 발생한 모든 판매 기록(product_id, first_year, quantity, price)을 조회

SELECT s.product_id,
       s.year AS first_year,
       s.quantity,
       s.price
FROM Sales AS s
JOIN (
    SELECT product_id, MIN(year) AS first_year
    FROM Sales
    GROUP BY product_id
) AS first_sale
  ON s.product_id = first_sale.product_id
 AND s.year = first_sale.first_year;
