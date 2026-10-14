-- LeetCode 1174. Immediate Food Delivery II
-- 문제: https://leetcode.com/problems/immediate-food-delivery-ii/
-- 풀이 날짜: 2026-10-14
-- 연습: CTE, MIN, GROUP BY, JOIN, CASE WHEN, SUM, COUNT, ROUND
-- 풀이: 고객별 첫 주문만 추출한 뒤 주문일과 희망 배송일이 같은 주문의 비율 계산

WITH first_orders AS (
    SELECT customer_id,
           MIN(order_date) AS first_order_date
    FROM Delivery
    GROUP BY customer_id
)
SELECT ROUND(
           SUM(
               CASE
                   WHEN d.order_date = d.customer_pref_delivery_date
                   THEN 1 ELSE 0
               END
           ) / COUNT(*) * 100,
           2
       ) AS immediate_percentage
FROM Delivery AS d
JOIN first_orders AS f
    ON d.customer_id = f.customer_id
   AND d.order_date = f.first_order_date;
