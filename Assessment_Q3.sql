SELECT
    p.id AS plan_id,
    p.owner_id,
    CASE
        WHEN p.plan_type_id = 1 THEN 'Savings'
        WHEN p.plan_type_id = 2 THEN 'Investment'
    END AS type,
    COALESCE(MAX(sa.transaction_date), p.start_date) AS last_transaction_date,
    DATEDIFF(CURDATE(), COALESCE(MAX(sa.transaction_date), p.start_date)) AS inactivity_days
FROM
    plans_plan p
LEFT JOIN
    savings_savingsaccount sa ON p.id = sa.plan_id
WHERE
    p.status_id = 1
    AND p.plan_type_id IN (1, 2)
GROUP BY
    p.id, p.owner_id, p.plan_type_id, p.start_date
HAVING
    inactivity_days > 365
ORDER BY
    inactivity_days;
