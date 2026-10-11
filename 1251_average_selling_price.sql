-- LeetCode 1251. Average Selling Price
-- 문제: https://leetcode.com/problems/average-selling-price/
-- 풀이 날짜: 2026-10-12
-- 연습: LEFT JOIN, BETWEEN, GROUP BY, SUM, IFNULL, ROUND
-- 풀이: 판매일에 적용되는 가격을 연결해 총판매 금액을 총판매 수량으로 나누고, 판매가 없는 상품은 0으로 처리

SELECT p.product_id,
       ROUND(
           IFNULL(SUM(p.price * u.units) / SUM(u.units), 0),
           2
       ) AS average_price
FROM Prices AS p
LEFT JOIN UnitsSold AS u
    ON p.product_id = u.product_id
   AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;
