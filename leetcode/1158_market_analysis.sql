# [LeetCode] 1158. Market Analysis I (MySQL)

- **문제 링크:** [LeetCode 1158. Market Analysis I](https://leetcode.com/problems/market-analysis-i/)
- **난이도:** Medium
- **주요 개념:** `LEFT JOIN`, `GROUP BY`, `COUNT`, `JOIN ON 조건 절`

---

## 📌 문제 설명

회원 테이블(`Users`), 주문 테이블(`Orders`), 상품 테이블(`Items`)이 주어졌을 때, **모든 회원별로 2019년에 주문한 건수**를 구하는 문제.

- **출력 컬럼:** `buyer_id`, `join_date`, `orders_in_2019`
- **핵심 조건:** 2019년에 주문 내역이 없는 회원도 결과에 포함되어야 함 (`orders_in_2019 = 0`).

---

## 💡 핵심 풀이 포인트

1. **`LEFT JOIN`의 사용**
   - 주문을 하지 않은 사용자도 결과 집합에 모두 포함되어야 하므로 기준 테이블(`Users`)을 왼쪽에 두고 `Orders` 테이블을 `LEFT JOIN` 해야 함.

2. **2019년 필터링 조건의 위치 (`ON` vs `WHERE`)**
   - `WHERE` 절에 `YEAR(order_date) = '2019'`를 사용하면, 2019년 주문 내역이 없는 사용자의 행이 통째로 삭제(Filtering)되어 결과에서 누락됨.
   - 따라서 2019년 연도 조건은 **`LEFT JOIN`의 `ON` 절 내부**에 작성하여, 오른쪽 테이블(`Orders`)을 가져올 때 2019년 데이터만 체로 걸러낸 상태로 조인되도록 해야 함.

3. **집계 함수 `COUNT` 처리**
   - `COUNT(o.order_id)`를 사용하면 조인되지 않은 `NULL` 값은 카운트에서 제외되어 주문이 없는 사용자는 자동으로 `0`으로 집계됨.

---

## 💻 SQL 코드

```sql
SELECT 
    u.user_id AS buyer_id,
    u.join_date,
    COUNT(o.order_id) AS orders_in_2019
FROM 
    Users u
LEFT JOIN 
    Orders o 
    ON u.user_id = o.buyer_id 
    AND YEAR(o.order_date) = '2019'
GROUP BY 
    u.user_id, 
    u.join_date;
