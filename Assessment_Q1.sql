SELECT u.id, CONCAT(u.first_name, ' ', u.last_name) AS name,
COUNT(CASE WHEN p.is_regular_savings =1 THEN pl.id END) AS savings_count,
COUNT(CASE WHEN p.is_a_fund = 1 THEN pl.id END) AS investment_count,
ROUND(SUM(sa.confirmed_amount/100.0),2) AS total_deposits
FROM users_customuser u
JOIN savings_savingsaccount sa ON u.id = sa.owner_id
JOIN plans_plan pl ON sa.plan_id = pl.id
JOIN plans_plan p ON pl.id = p.id
WHERE sa.confirmed_amount > 0
GROUP BY u.id, CONCAT(u.first_name, ' ', u.last_name)
HAVING COUNT(CASE WHEN p.is_regular_savings =1 THEN pl.id END) AND
COUNT(CASE WHEN p.is_a_fund = 1 THEN pl.id END) >=1
ORDER BY total_deposits DESC