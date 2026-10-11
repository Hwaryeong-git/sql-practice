-- LeetCode 1193. Monthly Transactions I
-- 문제: https://leetcode.com/problems/monthly-transactions-i/
-- 풀이 날짜: 2026-10-12
-- 연습: DATE_FORMAT, GROUP BY, COUNT, SUM, CASE WHEN
-- 풀이: 월별 국가별 전체 거래와 승인 거래의 건수 및 금액 합계 계산

SELECT DATE_FORMAT(trans_date, '%Y-%m') AS month,
       country,
       COUNT(*) AS trans_count,
       SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END)
           AS approved_count,
       SUM(amount) AS trans_total_amount,
       SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END)
           AS approved_total_amount
FROM Transactions
GROUP BY `month`, country;
