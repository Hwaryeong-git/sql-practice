-- LeetCode 1045. Customers Who Bought All Products
-- 문제: https://leetcode.com/problems/customers-who-bought-all-products/
-- 풀이 날짜: 2026-10-14
-- 연습: GROUP BY, COUNT(DISTINCT), HAVING, 서브쿼리
-- 풀이: 고객별 구매한 상품 종류 수를 전체 상품 수와 비교해 모든 상품을 구매한 고객 조회

SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (
    SELECT COUNT(*)
    FROM Product
);
